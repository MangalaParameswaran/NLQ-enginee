from sqlalchemy.orm import Session
from sqlalchemy import create_engine, text
from typing import List, Dict, Any, Optional, Tuple
import json
import time
from abc import ABC, abstractmethod
from app.models.data_source import DataSource
from app.core.config import settings
from app.core.logging_config import logger


class QueryExecutor(ABC):
    @abstractmethod
    def execute(self, query: str, params: Dict[str, Any] = None) -> Tuple[List[Dict[str, Any]], List[str], float]:
        pass
    
    @abstractmethod
    def validate_read_only(self, query: str) -> bool:
        pass


class PostgreSQLQueryExecutor(QueryExecutor):
    def __init__(self, connection_string: str):
        self.engine = create_engine(connection_string, pool_pre_ping=True)
    
    def validate_read_only(self, query: str) -> bool:
        query_upper = query.upper().strip()
        forbidden = ['INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE', 'ALTER', 'TRUNCATE', 'GRANT', 'REVOKE']
        for keyword in forbidden:
            if query_upper.startswith(keyword):
                return False
        return True
    
    def execute(self, query: str, params: Dict[str, Any] = None) -> Tuple[List[Dict[str, Any]], List[str], float]:
        if not self.validate_read_only(query):
            raise ValueError("Only read-only queries are allowed")
        
        start_time = time.time()
        
        with self.engine.connect() as conn:
            result = conn.execute(text(query), params or {})
            columns = list(result.keys())
            rows = [dict(zip(columns, row)) for row in result.fetchall()]
        
        execution_time = (time.time() - start_time) * 1000
        
        return rows, columns, execution_time


class MongoDBQueryExecutor(QueryExecutor):
    def __init__(self, connection_string: str, database: str = "main"):
        try:
            from pymongo import MongoClient
            self.client = MongoClient(connection_string)
            self.db = self.client[database]
        except ImportError:
            logger.warning("pymongo not installed, MongoDB support disabled")
            self.client = None
            self.db = None
    
    def validate_read_only(self, query: str) -> bool:
        if isinstance(query, str):
            query_lower = query.lower()
            forbidden = ['insert', 'update', 'delete', 'drop', 'create', 'remove']
            for keyword in forbidden:
                if keyword in query_lower:
                    return False
        return True
    
    def execute(self, pipeline: List[Dict], collection: str = None) -> Tuple[List[Dict[str, Any]], List[str], float]:
        if not self.db:
            raise ValueError("MongoDB connection not available")
        
        start_time = time.time()
        
        coll = self.db[collection] if collection else self.db.list_collection_names()[0]
        cursor = self.db[coll].aggregate(pipeline)
        rows = list(cursor)
        
        columns = list(rows[0].keys()) if rows else []
        
        for row in rows:
            if '_id' in row:
                row['_id'] = str(row['_id'])
        
        execution_time = (time.time() - start_time) * 1000
        
        return rows, columns, execution_time


class DataSourceManager:
    def __init__(self, db: Session):
        self.db = db
        self._executors: Dict[int, QueryExecutor] = {}
    
    def get_executor(self, data_source_id: Optional[int] = None, tenant_id: Optional[int] = None) -> QueryExecutor:
        if data_source_id:
            if data_source_id in self._executors:
                return self._executors[data_source_id]
            
            data_source = self.db.query(DataSource).filter(
                DataSource.id == data_source_id,
                DataSource.is_active == True
            ).first()
            
            if not data_source:
                raise ValueError("Data source not found")
            
            if tenant_id and data_source.tenant_id != tenant_id:
                raise ValueError("Data source does not belong to tenant")
            
            executor = self._create_executor(data_source.db_type, data_source.connection_string)
            self._executors[data_source_id] = executor
            return executor
        
        return PostgreSQLQueryExecutor(settings.DATABASE_URL)
    
    def _create_executor(self, db_type: str, connection_string: str) -> QueryExecutor:
        if db_type.lower() == "postgresql":
            return PostgreSQLQueryExecutor(connection_string)
        elif db_type.lower() == "mongodb":
            return MongoDBQueryExecutor(connection_string)
        else:
            raise ValueError(f"Unsupported database type: {db_type}")
    
    def execute_query(
        self,
        query: str,
        tenant_id: int,
        data_source_id: Optional[int] = None,
        params: Dict[str, Any] = None
    ) -> Tuple[List[Dict[str, Any]], List[str], float]:
        executor = self.get_executor(data_source_id, tenant_id)
        return executor.execute(query, params)
    
    def get_data_sources(self, tenant_id: int) -> List[DataSource]:
        return self.db.query(DataSource).filter(
            DataSource.tenant_id == tenant_id,
            DataSource.is_active == True
        ).all()
    
    def get_schema_info(self, data_source_id: int, tenant_id: int) -> Dict[str, Any]:
        data_source = self.db.query(DataSource).filter(
            DataSource.id == data_source_id,
            DataSource.tenant_id == tenant_id
        ).first()
        
        if not data_source:
            return {}
        
        if data_source.schema_info:
            return json.loads(data_source.schema_info)
        
        return {}
