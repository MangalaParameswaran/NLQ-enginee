import os
import json
import logging
from typing import Dict, Any, List, Optional, Tuple
from app.core.config import settings
from app.core.logging_config import logger

client = None

def get_gemini_client():
    global client
    if client is None:
        api_key = os.environ.get("GEMINI_API_KEY", "")
        if api_key:
            from google import genai
            client = genai.Client(api_key=api_key)
    return client

def get_genai_types():
    from google.genai import types
    return types


class IntentDetector:
    INTENTS = [
        "aggregation",
        "comparison",
        "trend_analysis",
        "distribution",
        "ranking",
        "filtering",
        "correlation",
        "summary",
        "detail_lookup",
        "clarification_needed"
    ]
    
    def detect(self, query: str, schema_context: str = "") -> Dict[str, Any]:
        prompt = f"""Analyze this natural language query and determine the intent.

Query: "{query}"

Available database schema:
{schema_context}

Respond with JSON containing:
- intent_type: one of {self.INTENTS}
- confidence: float between 0 and 1
- entities: extracted entities like table names, columns, values, time periods
- is_ambiguous: boolean indicating if the query needs clarification
- clarification_question: if ambiguous, what to ask the user

JSON Response:"""
        
        try:
            gemini = get_gemini_client()
            types = get_genai_types()
            if gemini:
                response = gemini.models.generate_content(
                    model=settings.GEMINI_MODEL,
                    contents=prompt,
                    config=types.GenerateContentConfig(
                        response_mime_type="application/json"
                    )
                )
                
                if response.text:
                    result = json.loads(response.text)
                    return {
                        "intent_type": result.get("intent_type", "summary"),
                        "confidence": result.get("confidence", 0.5),
                        "entities": result.get("entities", {}),
                        "is_ambiguous": result.get("is_ambiguous", False),
                        "clarification_question": result.get("clarification_question")
                    }
        except Exception as e:
            logger.error(f"Intent detection failed: {e}")
        
        return {
            "intent_type": "summary",
            "confidence": 0.5,
            "entities": {},
            "is_ambiguous": False
        }


class MetricExtractor:
    def extract(self, query: str, intent: Dict[str, Any], schema_context: str = "") -> Dict[str, Any]:
        prompt = f"""Extract metrics, dimensions, and aggregations from this query.

Query: "{query}"
Intent: {intent.get('intent_type')}

Available database schema:
{schema_context}

Respond with JSON containing:
- metrics: list of numeric measures to calculate (e.g., ["revenue", "count", "average_price"])
- dimensions: list of categorical fields to group by (e.g., ["category", "date", "region"])
- aggregations: list of aggregation functions needed (e.g., ["SUM", "COUNT", "AVG"])
- time_granularity: if time-based, the granularity (day, week, month, year, or null)

JSON Response:"""
        
        try:
            gemini = get_gemini_client()
            types = get_genai_types()
            if gemini:
                response = gemini.models.generate_content(
                    model=settings.GEMINI_MODEL,
                    contents=prompt,
                    config=types.GenerateContentConfig(
                        response_mime_type="application/json"
                    )
                )
                
                if response.text:
                    return json.loads(response.text)
        except Exception as e:
            logger.error(f"Metric extraction failed: {e}")
        
        return {"metrics": [], "dimensions": [], "aggregations": [], "time_granularity": None}


class FilterBuilder:
    def build(self, query: str, entities: Dict[str, Any], schema_context: str = "") -> Dict[str, Any]:
        prompt = f"""Extract filter conditions from this query.

Query: "{query}"
Entities: {json.dumps(entities)}

Available database schema:
{schema_context}

Respond with JSON containing:
- time_range: object with start_date, end_date, relative (e.g., "last 7 days"), or null
- conditions: list of filter conditions, each with:
  - field: column name
  - operator: =, !=, >, <, >=, <=, LIKE, IN, BETWEEN
  - value: the filter value
- limit: number of results to return (default null for all)
- order_by: list of objects with field and direction (ASC/DESC)

JSON Response:"""
        
        try:
            gemini = get_gemini_client()
            types = get_genai_types()
            if gemini:
                response = gemini.models.generate_content(
                    model=settings.GEMINI_MODEL,
                    contents=prompt,
                    config=types.GenerateContentConfig(
                        response_mime_type="application/json"
                    )
                )
                
                if response.text:
                    return json.loads(response.text)
        except Exception as e:
            logger.error(f"Filter building failed: {e}")
        
        return {"time_range": None, "conditions": [], "limit": None, "order_by": []}


class QueryPlanner:
    def plan(self, query: str, intent: Dict, metrics: Dict, filters: Dict, schema_context: str = "") -> Dict[str, Any]:
        prompt = f"""Create a query execution plan for this natural language query.

Original Query: "{query}"
Intent: {json.dumps(intent)}
Metrics: {json.dumps(metrics)}
Filters: {json.dumps(filters)}

Available database schema:
{schema_context}

Respond with JSON containing:
- tables: list of tables needed
- joins: list of join conditions (if multiple tables)
- select_columns: list of columns to select with any aggregations
- group_by: list of columns to group by
- where_conditions: list of WHERE clause conditions
- having_conditions: list of HAVING clause conditions (for aggregation filters)
- order_by: list of ORDER BY specifications
- limit: result limit

JSON Response:"""
        
        try:
            response = client.models.generate_content(
                model=settings.GEMINI_MODEL,
                contents=prompt,
                config=types.GenerateContentConfig(
                    response_mime_type="application/json"
                )
            )
            
            if response.text:
                return json.loads(response.text)
        except Exception as e:
            logger.error(f"Query planning failed: {e}")
        
        return {"tables": [], "joins": [], "select_columns": [], "group_by": [], "where_conditions": [], "having_conditions": [], "order_by": [], "limit": None}


class SQLGenerator:
    def generate(self, query: str, plan: Dict[str, Any], schema_context: str = "") -> str:
        prompt = f"""Generate a valid, read-only SQL query for PostgreSQL.

Natural Language Query: "{query}"
Query Plan: {json.dumps(plan)}

Available database schema:
{schema_context}

IMPORTANT RULES:
1. Generate ONLY SELECT statements - no INSERT, UPDATE, DELETE, DROP, etc.
2. Use proper PostgreSQL syntax
3. Include appropriate table aliases
4. Handle NULL values properly
5. Use COALESCE for potential nulls in aggregations
6. Add LIMIT 1000 if no limit specified for safety

Respond with ONLY the SQL query, no explanation:"""
        
        try:
            response = client.models.generate_content(
                model=settings.GEMINI_MODEL,
                contents=prompt
            )
            
            if response.text:
                sql = response.text.strip()
                sql = sql.replace("```sql", "").replace("```", "").strip()
                return sql
        except Exception as e:
            logger.error(f"SQL generation failed: {e}")
        
        return "SELECT 1"


class MongoPipelineGenerator:
    def generate(self, query: str, plan: Dict[str, Any], schema_context: str = "") -> List[Dict]:
        prompt = f"""Generate a MongoDB aggregation pipeline.

Natural Language Query: "{query}"
Query Plan: {json.dumps(plan)}

Available schema:
{schema_context}

IMPORTANT: Generate a valid MongoDB aggregation pipeline as a JSON array.
Only read operations are allowed.

Respond with ONLY the JSON pipeline array:"""
        
        try:
            response = client.models.generate_content(
                model=settings.GEMINI_MODEL,
                contents=prompt,
                config=types.GenerateContentConfig(
                    response_mime_type="application/json"
                )
            )
            
            if response.text:
                return json.loads(response.text)
        except Exception as e:
            logger.error(f"MongoDB pipeline generation failed: {e}")
        
        return [{"$limit": 100}]


class ChartRecommender:
    def recommend(self, query: str, intent: Dict, metrics: Dict, result_sample: List[Dict]) -> Dict[str, Any]:
        prompt = f"""Recommend the best chart type to visualize this data.

Query: "{query}"
Intent: {intent.get('intent_type')}
Metrics: {json.dumps(metrics)}
Sample Data (first 3 rows): {json.dumps(result_sample[:3] if result_sample else [])}

Chart options: bar, line, pie, area, mixed, table

Respond with JSON containing:
- chart_type: the recommended chart type
- reason: brief explanation why this chart type is best
- config: chart configuration with:
  - x_axis: field for x-axis (or null for pie)
  - y_axis: field(s) for y-axis
  - series: for multi-series charts
  - colors: suggested color scheme
  - title: chart title

JSON Response:"""
        
        try:
            response = client.models.generate_content(
                model=settings.GEMINI_MODEL,
                contents=prompt,
                config=types.GenerateContentConfig(
                    response_mime_type="application/json"
                )
            )
            
            if response.text:
                return json.loads(response.text)
        except Exception as e:
            logger.error(f"Chart recommendation failed: {e}")
        
        return {
            "chart_type": "table",
            "reason": "Default to table for data display",
            "config": {}
        }


class InsightEngine:
    def generate_insights(self, query: str, result: List[Dict], chart_type: str) -> Tuple[List[Dict], str]:
        if not result:
            return [], "No data available for analysis."
        
        prompt = f"""Analyze this data and provide key insights.

Query: "{query}"
Chart Type: {chart_type}
Data (first 10 rows): {json.dumps(result[:10])}
Total rows: {len(result)}

Respond with JSON containing:
- insights: list of insight objects, each with:
  - title: short insight title
  - description: detailed explanation
  - importance: "high", "medium", or "low"
- explanation: a natural language explanation of the data suitable for display to the user

JSON Response:"""
        
        try:
            response = client.models.generate_content(
                model=settings.GEMINI_MODEL,
                contents=prompt,
                config=types.GenerateContentConfig(
                    response_mime_type="application/json"
                )
            )
            
            if response.text:
                data = json.loads(response.text)
                return data.get("insights", []), data.get("explanation", "")
        except Exception as e:
            logger.error(f"Insight generation failed: {e}")
        
        return [], "Data retrieved successfully."


class GeminiNLQService:
    def __init__(self):
        self.intent_detector = IntentDetector()
        self.metric_extractor = MetricExtractor()
        self.filter_builder = FilterBuilder()
        self.query_planner = QueryPlanner()
        self.sql_generator = SQLGenerator()
        self.mongo_generator = MongoPipelineGenerator()
        self.chart_recommender = ChartRecommender()
        self.insight_engine = InsightEngine()
    
    def process_query(
        self,
        query: str,
        db_type: str = "postgresql",
        schema_context: str = ""
    ) -> Dict[str, Any]:
        intent = self.intent_detector.detect(query, schema_context)
        
        if intent.get("is_ambiguous"):
            return {
                "needs_clarification": True,
                "clarification_question": intent.get("clarification_question", "Could you please provide more details?"),
                "intent": intent
            }
        
        metrics = self.metric_extractor.extract(query, intent, schema_context)
        filters = self.filter_builder.build(query, intent.get("entities", {}), schema_context)
        plan = self.query_planner.plan(query, intent, metrics, filters, schema_context)
        
        if db_type.lower() == "mongodb":
            generated_query = self.mongo_generator.generate(query, plan, schema_context)
            query_type = "mongodb"
        else:
            generated_query = self.sql_generator.generate(query, plan, schema_context)
            query_type = "sql"
        
        return {
            "needs_clarification": False,
            "intent": intent,
            "metrics": metrics,
            "filters": filters,
            "plan": plan,
            "generated_query": generated_query,
            "query_type": query_type
        }
    
    def get_chart_recommendation(self, query: str, intent: Dict, metrics: Dict, result: List[Dict]) -> Dict[str, Any]:
        return self.chart_recommender.recommend(query, intent, metrics, result)
    
    def get_insights(self, query: str, result: List[Dict], chart_type: str) -> Tuple[List[Dict], str]:
        return self.insight_engine.generate_insights(query, result, chart_type)


gemini_service = GeminiNLQService()
