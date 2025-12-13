from pydantic import BaseModel, Field
from typing import Optional, List, Dict, Any
from datetime import datetime
from enum import Enum


class ChartType(str, Enum):
    BAR = "bar"
    LINE = "line"
    PIE = "pie"
    AREA = "area"
    MIXED = "mixed"
    TABLE = "table"


class QueryRequest(BaseModel):
    query: str = Field(..., min_length=1, max_length=2000)
    conversation_id: Optional[int] = None
    data_source_id: Optional[int] = None


class QueryIntent(BaseModel):
    intent_type: str
    confidence: float
    entities: Dict[str, Any] = {}


class QueryMetrics(BaseModel):
    metrics: List[str]
    dimensions: List[str]
    aggregations: List[str]


class QueryFilters(BaseModel):
    time_range: Optional[Dict[str, Any]] = None
    conditions: List[Dict[str, Any]] = []


class GeneratedQuery(BaseModel):
    sql: Optional[str] = None
    mongo_pipeline: Optional[List[Dict[str, Any]]] = None
    query_type: str
    is_read_only: bool = True


class ChartRecommendation(BaseModel):
    chart_type: ChartType
    reason: str
    config: Dict[str, Any] = {}


class QueryInsight(BaseModel):
    title: str
    description: str
    importance: str


class QueryResult(BaseModel):
    data: List[Dict[str, Any]]
    columns: List[str]
    row_count: int
    execution_time_ms: float


class QueryResponse(BaseModel):
    message_id: int
    query: str
    normalized_query: str
    intent: QueryIntent
    generated_query: GeneratedQuery
    result: QueryResult
    chart: ChartRecommendation
    insights: List[QueryInsight]
    explanation: str
    from_cache: bool = False
    

class FeedbackRequest(BaseModel):
    message_id: int
    rating: int = Field(..., ge=1, le=5)
    feedback: Optional[str] = None


class SampleQuestion(BaseModel):
    question: str
    category: str
    description: str
