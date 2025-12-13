from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Text, Float
from sqlalchemy.orm import relationship
from datetime import datetime
from app.core.database import Base


class NLQMemory(Base):
    __tablename__ = "nlq_memories"
    
    id = Column(Integer, primary_key=True, index=True)
    
    tenant_id = Column(Integer, ForeignKey("tenants.id"), nullable=False, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False, index=True)
    
    normalized_query = Column(String(512), nullable=False, index=True)
    raw_user_input = Column(Text, nullable=False)
    
    generated_sql = Column(Text, nullable=True)
    generated_mongo_pipeline = Column(Text, nullable=True)
    
    intent = Column(String(100), nullable=True)
    metrics = Column(Text, nullable=True)
    filters = Column(Text, nullable=True)
    
    hit_count = Column(Integer, default=1)
    last_used_at = Column(DateTime, default=datetime.utcnow)
    confidence_score = Column(Float, nullable=True)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    user = relationship("User", back_populates="nlq_memories")
