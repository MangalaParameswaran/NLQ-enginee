from sqlalchemy.orm import Session
from typing import Dict, Any, List, Optional
import json
import time
from app.services.gemini_service import gemini_service
from app.services.nlq_memory_service import NLQMemoryService
from app.services.conversation_service import ConversationService
from app.services.data_source_manager import DataSourceManager
from app.schemas.query import QueryRequest, QueryResponse, QueryIntent, GeneratedQuery, QueryResult, ChartRecommendation, QueryInsight
from app.core.logging_config import logger


SAMPLE_QUESTIONS = [
    {"question": "Show me monthly expenses for 2024", "category": "trend", "description": "Monthly expense breakdown for 2024"},
    {"question": "What is the total sales by product category?", "category": "aggregation", "description": "Sales breakdown by product category"},
    {"question": "Compare expenses by category for 2024", "category": "comparison", "description": "Expense comparison across categories"},
    {"question": "Top 10 products by revenue in 2024", "category": "ranking", "description": "Highest revenue products"},
    {"question": "Show sales trend by month for 2023", "category": "trend", "description": "Monthly sales trend for 2023"},
    {"question": "What is the total expense by department?", "category": "aggregation", "description": "Department-wise expense totals"},
    {"question": "Compare 2023 vs 2024 sales performance", "category": "comparison", "description": "Year over year sales comparison"},
    {"question": "Which vendors have the highest expenses?", "category": "ranking", "description": "Top vendors by expense amount"},
]


class QueryEngineService:
    def __init__(self, db: Session):
        self.db = db
        self.nlq_memory = NLQMemoryService(db)
        self.conversation_service = ConversationService(db)
        self.data_source_manager = DataSourceManager(db)
    
    def get_sample_questions(self) -> List[Dict[str, str]]:
        return SAMPLE_QUESTIONS
    
    def get_schema_context(self, tenant_id: int, data_source_id: Optional[int] = None) -> str:
        from app.models.data_source import DataSource
        
        data_sources = self.db.query(DataSource).filter(
            DataSource.tenant_id == tenant_id,
            DataSource.is_active == True
        ).all()
        
        schema_parts = ["Available Tables and Schema:\n"]
        
        for ds in data_sources:
            if ds.tables_info:
                try:
                    tables_info = json.loads(ds.tables_info) if isinstance(ds.tables_info, str) else ds.tables_info
                    if isinstance(tables_info, dict) and "tables" in tables_info:
                        for table in tables_info["tables"]:
                            table_name = table.get("name", "unknown")
                            description = table.get("description", "")
                            columns = table.get("columns", [])
                            schema_parts.append(f"- {table_name}: {description}")
                            if columns:
                                schema_parts.append(f"  Columns: {', '.join(columns)}")
                except:
                    pass
            
            if ds.schema_info:
                schema_parts.append(f"\nData Source: {ds.name}")
                schema_parts.append(f"Description: {ds.schema_info}")
        
        schema_parts.append(f"\nIMPORTANT: Filter analytics tables by tenant_id = {tenant_id} for data isolation.")
        schema_parts.append("Generate only SELECT queries. Never generate INSERT, UPDATE, DELETE, or DROP statements.")
        
        return "\n".join(schema_parts)
    
    def execute_query(
        self,
        request: QueryRequest,
        user_id: int,
        tenant_id: int
    ) -> Dict[str, Any]:
        start_time = time.time()
        
        cached = self.nlq_memory.lookup(tenant_id, user_id, request.query)
        
        conversation_id = request.conversation_id
        if not conversation_id:
            conv = self.conversation_service.create_conversation(tenant_id, user_id, request.query[:50])
            conversation_id = conv.id
        
        self.conversation_service.add_message(
            conversation_id=conversation_id,
            role="user",
            content=request.query
        )
        
        schema_context = self.get_schema_context(tenant_id, request.data_source_id)
        
        from_cache = False
        if cached and cached.generated_sql:
            nlq_result = {
                "needs_clarification": False,
                "intent": {"intent_type": cached.intent or "summary", "confidence": 0.9, "entities": {}},
                "metrics": json.loads(cached.metrics) if cached.metrics else {},
                "filters": json.loads(cached.filters) if cached.filters else {},
                "generated_query": cached.generated_sql,
                "query_type": "sql"
            }
            from_cache = True
            logger.info(f"Using cached query for tenant {tenant_id}, user {user_id}")
        else:
            nlq_result = gemini_service.process_query(
                query=request.query,
                db_type="postgresql",
                schema_context=schema_context
            )
        
        if nlq_result.get("needs_clarification"):
            assistant_message = self.conversation_service.add_message(
                conversation_id=conversation_id,
                role="assistant",
                content=nlq_result.get("clarification_question", "Could you please provide more details?")
            )
            
            return {
                "message_id": assistant_message.id,
                "conversation_id": conversation_id,
                "needs_clarification": True,
                "clarification_question": nlq_result.get("clarification_question"),
                "intent": nlq_result.get("intent", {})
            }
        
        generated_query = nlq_result.get("generated_query", "SELECT 1")
        
        try:
            rows, columns, exec_time = self.data_source_manager.execute_query(
                query=generated_query,
                tenant_id=tenant_id,
                data_source_id=request.data_source_id
            )
        except Exception as e:
            logger.error(f"Query execution failed: {e}")
            rows, columns, exec_time = [], [], 0
            
            assistant_message = self.conversation_service.add_message(
                conversation_id=conversation_id,
                role="assistant",
                content=f"I encountered an error executing the query: {str(e)}. Please try rephrasing your question."
            )
            
            return {
                "message_id": assistant_message.id,
                "conversation_id": conversation_id,
                "error": str(e)
            }
        
        intent = nlq_result.get("intent", {})
        metrics = nlq_result.get("metrics", {})
        
        chart_rec = gemini_service.get_chart_recommendation(
            query=request.query,
            intent=intent,
            metrics=metrics,
            result=rows
        )
        
        insights, explanation = gemini_service.get_insights(
            query=request.query,
            result=rows,
            chart_type=chart_rec.get("chart_type", "table")
        )
        
        if not from_cache and generated_query != "SELECT 1":
            self.nlq_memory.store(
                tenant_id=tenant_id,
                user_id=user_id,
                raw_query=request.query,
                generated_sql=generated_query if nlq_result.get("query_type") == "sql" else None,
                generated_mongo_pipeline=json.dumps(generated_query) if nlq_result.get("query_type") == "mongodb" else None,
                intent=intent.get("intent_type"),
                metrics=json.dumps(metrics),
                filters=json.dumps(nlq_result.get("filters", {})),
                confidence_score=intent.get("confidence", 0.5)
            )
        
        total_time = (time.time() - start_time) * 1000
        
        assistant_message = self.conversation_service.add_message(
            conversation_id=conversation_id,
            role="assistant",
            content=explanation,
            query_type=nlq_result.get("query_type"),
            generated_query=generated_query,
            chart_type=chart_rec.get("chart_type"),
            chart_data={"data": rows, "config": chart_rec.get("config", {})},
            insights=insights,
            execution_time_ms=total_time
        )
        
        normalized = self.nlq_memory.normalize_query(request.query)
        
        return {
            "message_id": assistant_message.id,
            "conversation_id": conversation_id,
            "query": request.query,
            "normalized_query": normalized,
            "intent": QueryIntent(
                intent_type=intent.get("intent_type", "summary"),
                confidence=intent.get("confidence", 0.5),
                entities=intent.get("entities", {})
            ).model_dump(),
            "generated_query": GeneratedQuery(
                sql=generated_query if nlq_result.get("query_type") == "sql" else None,
                mongo_pipeline=generated_query if nlq_result.get("query_type") == "mongodb" else None,
                query_type=nlq_result.get("query_type", "sql"),
                is_read_only=True
            ).model_dump(),
            "result": QueryResult(
                data=rows,
                columns=columns,
                row_count=len(rows),
                execution_time_ms=exec_time
            ).model_dump(),
            "chart": ChartRecommendation(
                chart_type=chart_rec.get("chart_type", "table"),
                reason=chart_rec.get("reason", ""),
                config=chart_rec.get("config", {})
            ).model_dump(),
            "insights": [QueryInsight(**i).model_dump() for i in insights] if insights else [],
            "explanation": explanation,
            "from_cache": from_cache
        }
    
    def submit_feedback(self, message_id: int, rating: int, feedback: Optional[str] = None) -> bool:
        return self.conversation_service.update_message_feedback(message_id, rating, feedback)
