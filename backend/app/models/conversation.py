from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Text, Enum, Float
from sqlalchemy.orm import relationship
from datetime import datetime
from app.core.database import Base
import enum


class MessageRole(str, enum.Enum):
    USER = "user"
    ASSISTANT = "assistant"
    SYSTEM = "system"


class Conversation(Base):
    __tablename__ = "conversations"
    
    id = Column(Integer, primary_key=True, index=True)
    
    tenant_id = Column(Integer, ForeignKey("tenants.id"), nullable=False, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False, index=True)
    
    title = Column(String(255), nullable=True)
    is_active = Column(Integer, default=1)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    user = relationship("User", back_populates="conversations")
    messages = relationship("Message", back_populates="conversation", order_by="Message.created_at")


class Message(Base):
    __tablename__ = "messages"
    
    id = Column(Integer, primary_key=True, index=True)
    conversation_id = Column(Integer, ForeignKey("conversations.id"), nullable=False, index=True)
    
    role = Column(String(20), nullable=False)
    content = Column(Text, nullable=False)
    
    query_type = Column(String(50), nullable=True)
    generated_query = Column(Text, nullable=True)
    query_result = Column(Text, nullable=True)
    chart_type = Column(String(50), nullable=True)
    chart_data = Column(Text, nullable=True)
    insights = Column(Text, nullable=True)
    
    user_rating = Column(Integer, nullable=True)
    user_feedback = Column(Text, nullable=True)
    
    execution_time_ms = Column(Float, nullable=True)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    
    conversation = relationship("Conversation", back_populates="messages")
