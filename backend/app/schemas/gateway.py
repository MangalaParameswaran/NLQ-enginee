from pydantic import BaseModel, Field
from typing import Any, Dict, Optional
from enum import Enum


class ServiceType(str, Enum):
    AUTH = "auth"
    QUERY = "query"
    NLQ_MEMORY = "nlq_memory"
    ANALYTICS = "analytics"
    EXPORT = "export"
    CONVERSATION = "conversation"
    FEEDBACK = "feedback"


class ActionType(str, Enum):
    SIGNUP = "signup"
    LOGIN = "login"
    REFRESH = "refresh"
    LOGOUT = "logout"
    GET_USER = "get_user"
    
    EXECUTE_QUERY = "execute_query"
    GET_SAMPLE_QUESTIONS = "get_sample_questions"
    
    GET_HISTORY = "get_history"
    CLEAR_HISTORY = "clear_history"
    
    GET_CONVERSATIONS = "get_conversations"
    GET_CONVERSATION = "get_conversation"
    CREATE_CONVERSATION = "create_conversation"
    DELETE_CONVERSATION = "delete_conversation"
    
    SUBMIT_FEEDBACK = "submit_feedback"
    
    EXPORT_CSV = "export_csv"
    EXPORT_PDF = "export_pdf"


class GatewayRequest(BaseModel):
    service: ServiceType
    action: ActionType
    payload: Dict[str, Any] = Field(default_factory=dict)


class GatewayResponse(BaseModel):
    success: bool
    data: Optional[Any] = None
    error: Optional[str] = None
    error_code: Optional[str] = None
