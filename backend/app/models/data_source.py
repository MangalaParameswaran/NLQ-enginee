from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Text, Boolean
from sqlalchemy.orm import relationship
from datetime import datetime
from app.core.database import Base


class DataSource(Base):
    __tablename__ = "data_sources"
    
    id = Column(Integer, primary_key=True, index=True)
    
    tenant_id = Column(Integer, ForeignKey("tenants.id"), nullable=False, index=True)
    
    name = Column(String(255), nullable=False)
    db_type = Column(String(50), nullable=False)
    connection_string = Column(Text, nullable=False)
    
    schema_info = Column(Text, nullable=True)
    tables_info = Column(Text, nullable=True)
    
    is_active = Column(Boolean, default=True)
    is_read_only = Column(Boolean, default=True)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    tenant = relationship("Tenant", back_populates="data_sources")
