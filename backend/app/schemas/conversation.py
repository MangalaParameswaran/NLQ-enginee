from pydantic import BaseModel
from typing import Optional, List, Any, Dict
from datetime import datetime


class ConversationCreate(BaseModel):
    title: Optional[str] = "New Conversation"


class ConversationResponse(BaseModel):
    id: int
    title: Optional[str]
    created_at: datetime
    updated_at: datetime
    message_count: int = 0
    
    class Config:
        from_attributes = True


class MessageResponse(BaseModel):
    id: int
    role: str
    content: str
    query_type: Optional[str]
    generated_query: Optional[str]
    chart_type: Optional[str]
    chart_data: Optional[str]
    insights: Optional[str]
    user_rating: Optional[int]
    execution_time_ms: Optional[float]
    created_at: datetime
    
    class Config:
        from_attributes = True


class ConversationWithMessages(BaseModel):
    id: int
    title: Optional[str]
    created_at: datetime
    updated_at: datetime
    messages: List[MessageResponse]
    
    class Config:
        from_attributes = True
