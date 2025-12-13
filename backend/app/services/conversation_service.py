from sqlalchemy.orm import Session
from typing import List, Optional
import json
from app.models.conversation import Conversation, Message
from app.schemas.conversation import ConversationCreate, ConversationResponse, ConversationWithMessages, MessageResponse


class ConversationService:
    def __init__(self, db: Session):
        self.db = db
    
    def create_conversation(self, tenant_id: int, user_id: int, title: Optional[str] = None) -> Conversation:
        conversation = Conversation(
            tenant_id=tenant_id,
            user_id=user_id,
            title=title or "New Conversation"
        )
        self.db.add(conversation)
        self.db.commit()
        self.db.refresh(conversation)
        return conversation
    
    def get_conversations(self, tenant_id: int, user_id: int, limit: int = 50) -> List[ConversationResponse]:
        conversations = self.db.query(Conversation).filter(
            Conversation.tenant_id == tenant_id,
            Conversation.user_id == user_id,
            Conversation.is_active == 1
        ).order_by(Conversation.updated_at.desc()).limit(limit).all()
        
        result = []
        for conv in conversations:
            message_count = self.db.query(Message).filter(Message.conversation_id == conv.id).count()
            result.append(ConversationResponse(
                id=conv.id,
                title=conv.title,
                created_at=conv.created_at,
                updated_at=conv.updated_at,
                message_count=message_count
            ))
        return result
    
    def get_conversation(self, conversation_id: int, tenant_id: int, user_id: int) -> Optional[ConversationWithMessages]:
        conversation = self.db.query(Conversation).filter(
            Conversation.id == conversation_id,
            Conversation.tenant_id == tenant_id,
            Conversation.user_id == user_id
        ).first()
        
        if not conversation:
            return None
        
        messages = self.db.query(Message).filter(
            Message.conversation_id == conversation_id
        ).order_by(Message.created_at.asc()).all()
        
        message_responses = [
            MessageResponse(
                id=msg.id,
                role=msg.role,
                content=msg.content,
                query_type=msg.query_type,
                generated_query=msg.generated_query,
                chart_type=msg.chart_type,
                chart_data=msg.chart_data,
                insights=msg.insights,
                user_rating=msg.user_rating,
                execution_time_ms=msg.execution_time_ms,
                created_at=msg.created_at
            ) for msg in messages
        ]
        
        return ConversationWithMessages(
            id=conversation.id,
            title=conversation.title,
            created_at=conversation.created_at,
            updated_at=conversation.updated_at,
            messages=message_responses
        )
    
    def delete_conversation(self, conversation_id: int, tenant_id: int, user_id: int) -> bool:
        conversation = self.db.query(Conversation).filter(
            Conversation.id == conversation_id,
            Conversation.tenant_id == tenant_id,
            Conversation.user_id == user_id
        ).first()
        
        if not conversation:
            return False
        
        conversation.is_active = 0
        self.db.commit()
        return True
    
    def add_message(
        self,
        conversation_id: int,
        role: str,
        content: str,
        query_type: Optional[str] = None,
        generated_query: Optional[str] = None,
        chart_type: Optional[str] = None,
        chart_data: Optional[dict] = None,
        insights: Optional[list] = None,
        execution_time_ms: Optional[float] = None
    ) -> Message:
        message = Message(
            conversation_id=conversation_id,
            role=role,
            content=content,
            query_type=query_type,
            generated_query=generated_query,
            chart_type=chart_type,
            chart_data=json.dumps(chart_data) if chart_data else None,
            insights=json.dumps(insights) if insights else None,
            execution_time_ms=execution_time_ms
        )
        self.db.add(message)
        
        conversation = self.db.query(Conversation).filter(Conversation.id == conversation_id).first()
        if conversation and role == "user" and not conversation.title.startswith("New"):
            pass
        elif conversation and role == "user":
            conversation.title = content[:50] + "..." if len(content) > 50 else content
        
        self.db.commit()
        self.db.refresh(message)
        return message
    
    def update_message_feedback(self, message_id: int, rating: int, feedback: Optional[str] = None) -> bool:
        message = self.db.query(Message).filter(Message.id == message_id).first()
        if not message:
            return False
        
        message.user_rating = rating
        message.user_feedback = feedback
        self.db.commit()
        return True
