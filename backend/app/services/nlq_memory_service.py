from sqlalchemy.orm import Session
from datetime import datetime
from typing import Optional, List, Dict, Any
import hashlib
import re
from app.models.nlq_memory import NLQMemory


class NLQMemoryService:
    def __init__(self, db: Session):
        self.db = db
    
    def normalize_query(self, query: str) -> str:
        normalized = query.lower().strip()
        normalized = re.sub(r'\s+', ' ', normalized)
        normalized = re.sub(r'[^\w\s]', '', normalized)
        
        stop_words = {'the', 'a', 'an', 'is', 'are', 'was', 'were', 'be', 'been', 'being',
                      'have', 'has', 'had', 'do', 'does', 'did', 'will', 'would', 'could',
                      'should', 'may', 'might', 'must', 'shall', 'can', 'need', 'dare',
                      'ought', 'used', 'to', 'of', 'in', 'for', 'on', 'with', 'at', 'by',
                      'from', 'as', 'into', 'through', 'during', 'before', 'after',
                      'above', 'below', 'between', 'under', 'again', 'further', 'then',
                      'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all',
                      'each', 'few', 'more', 'most', 'other', 'some', 'such', 'no',
                      'nor', 'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very',
                      'just', 'also', 'now', 'please', 'show', 'me', 'give', 'get',
                      'tell', 'what', 'which'}
        
        words = normalized.split()
        words = [w for w in words if w not in stop_words]
        normalized = ' '.join(sorted(words))
        
        return normalized
    
    def lookup(self, tenant_id: int, user_id: int, raw_query: str) -> Optional[NLQMemory]:
        normalized = self.normalize_query(raw_query)
        
        memory = self.db.query(NLQMemory).filter(
            NLQMemory.tenant_id == tenant_id,
            NLQMemory.user_id == user_id,
            NLQMemory.normalized_query == normalized
        ).first()
        
        if memory:
            memory.hit_count += 1
            memory.last_used_at = datetime.utcnow()
            self.db.commit()
        
        return memory
    
    def store(
        self,
        tenant_id: int,
        user_id: int,
        raw_query: str,
        generated_sql: Optional[str] = None,
        generated_mongo_pipeline: Optional[str] = None,
        intent: Optional[str] = None,
        metrics: Optional[str] = None,
        filters: Optional[str] = None,
        confidence_score: Optional[float] = None
    ) -> NLQMemory:
        normalized = self.normalize_query(raw_query)
        
        existing = self.db.query(NLQMemory).filter(
            NLQMemory.tenant_id == tenant_id,
            NLQMemory.user_id == user_id,
            NLQMemory.normalized_query == normalized
        ).first()
        
        if existing:
            existing.generated_sql = generated_sql or existing.generated_sql
            existing.generated_mongo_pipeline = generated_mongo_pipeline or existing.generated_mongo_pipeline
            existing.intent = intent or existing.intent
            existing.metrics = metrics or existing.metrics
            existing.filters = filters or existing.filters
            existing.confidence_score = confidence_score or existing.confidence_score
            existing.hit_count += 1
            existing.last_used_at = datetime.utcnow()
            self.db.commit()
            return existing
        
        memory = NLQMemory(
            tenant_id=tenant_id,
            user_id=user_id,
            normalized_query=normalized,
            raw_user_input=raw_query,
            generated_sql=generated_sql,
            generated_mongo_pipeline=generated_mongo_pipeline,
            intent=intent,
            metrics=metrics,
            filters=filters,
            confidence_score=confidence_score
        )
        self.db.add(memory)
        self.db.commit()
        self.db.refresh(memory)
        
        return memory
    
    def get_history(self, tenant_id: int, user_id: int, limit: int = 50) -> List[NLQMemory]:
        return self.db.query(NLQMemory).filter(
            NLQMemory.tenant_id == tenant_id,
            NLQMemory.user_id == user_id
        ).order_by(NLQMemory.last_used_at.desc()).limit(limit).all()
    
    def clear_history(self, tenant_id: int, user_id: int) -> int:
        count = self.db.query(NLQMemory).filter(
            NLQMemory.tenant_id == tenant_id,
            NLQMemory.user_id == user_id
        ).delete()
        self.db.commit()
        return count
