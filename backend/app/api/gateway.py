from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy.orm import Session
from typing import Any
from app.core.database import get_db
from app.core.security import verify_token
from app.schemas.gateway import GatewayRequest, GatewayResponse, ServiceType, ActionType
from app.schemas.auth import SignupRequest, LoginRequest, RefreshTokenRequest
from app.schemas.query import QueryRequest, FeedbackRequest
from app.schemas.conversation import ConversationCreate
from app.services.auth_service import AuthService
from app.services.query_engine_service import QueryEngineService
from app.services.nlq_memory_service import NLQMemoryService
from app.services.conversation_service import ConversationService
from app.core.logging_config import logger

router = APIRouter()


def get_user_from_token(request: Request) -> dict:
    auth_header = request.headers.get("Authorization")
    if not auth_header or not auth_header.startswith("Bearer "):
        return None
    
    token = auth_header.split(" ")[1]
    payload = verify_token(token, "access")
    return payload


@router.post("/gateway", response_model=GatewayResponse)
async def gateway(
    gateway_request: GatewayRequest,
    request: Request,
    db: Session = Depends(get_db)
) -> GatewayResponse:
    try:
        service = gateway_request.service
        action = gateway_request.action
        payload = gateway_request.payload
        
        logger.info(f"Gateway request: service={service}, action={action}")
        
        if service == ServiceType.AUTH:
            return await handle_auth(action, payload, db, request)
        
        user = get_user_from_token(request)
        
        if service != ServiceType.AUTH and action not in [ActionType.SIGNUP, ActionType.LOGIN]:
            if not user:
                return GatewayResponse(
                    success=False,
                    error="Authentication required",
                    error_code="UNAUTHORIZED"
                )
        
        if service == ServiceType.QUERY:
            return await handle_query(action, payload, user, db)
        elif service == ServiceType.NLQ_MEMORY:
            return await handle_nlq_memory(action, payload, user, db)
        elif service == ServiceType.CONVERSATION:
            return await handle_conversation(action, payload, user, db)
        elif service == ServiceType.FEEDBACK:
            return await handle_feedback(action, payload, user, db)
        elif service == ServiceType.EXPORT:
            return await handle_export(action, payload, user, db)
        else:
            return GatewayResponse(
                success=False,
                error=f"Unknown service: {service}",
                error_code="UNKNOWN_SERVICE"
            )
    
    except ValueError as e:
        logger.error(f"Gateway ValueError: {e}")
        return GatewayResponse(
            success=False,
            error=str(e),
            error_code="VALIDATION_ERROR"
        )
    except Exception as e:
        logger.error(f"Gateway error: {e}")
        return GatewayResponse(
            success=False,
            error="Internal server error",
            error_code="INTERNAL_ERROR"
        )


async def handle_auth(action: ActionType, payload: dict, db: Session, request: Request) -> GatewayResponse:
    auth_service = AuthService(db)
    
    if action == ActionType.SIGNUP:
        signup_data = SignupRequest(**payload)
        user, tokens = auth_service.signup(signup_data)
        return GatewayResponse(
            success=True,
            data={
                "user": user.model_dump(),
                "tokens": tokens.model_dump()
            }
        )
    
    elif action == ActionType.LOGIN:
        login_data = LoginRequest(**payload)
        user, tokens = auth_service.login(login_data)
        return GatewayResponse(
            success=True,
            data={
                "user": user.model_dump(),
                "tokens": tokens.model_dump()
            }
        )
    
    elif action == ActionType.REFRESH:
        user = get_user_from_token(request)
        if not user:
            refresh_token = payload.get("refresh_token")
            if refresh_token:
                user_payload = verify_token(refresh_token, "refresh")
                if user_payload:
                    tokens = auth_service.refresh_token(user_payload.get("user_id"))
                    return GatewayResponse(success=True, data=tokens.model_dump())
            return GatewayResponse(success=False, error="Invalid refresh token", error_code="INVALID_TOKEN")
        
        tokens = auth_service.refresh_token(user.get("user_id"))
        return GatewayResponse(success=True, data=tokens.model_dump())
    
    elif action == ActionType.GET_USER:
        user = get_user_from_token(request)
        if not user:
            return GatewayResponse(success=False, error="Not authenticated", error_code="UNAUTHORIZED")
        
        user_data = auth_service.get_user(user.get("user_id"))
        return GatewayResponse(success=True, data=user_data.model_dump())
    
    elif action == ActionType.LOGOUT:
        return GatewayResponse(success=True, data={"message": "Logged out successfully"})
    
    return GatewayResponse(success=False, error="Unknown auth action", error_code="UNKNOWN_ACTION")


async def handle_query(action: ActionType, payload: dict, user: dict, db: Session) -> GatewayResponse:
    query_service = QueryEngineService(db)
    
    if action == ActionType.EXECUTE_QUERY:
        query_request = QueryRequest(**payload)
        result = query_service.execute_query(
            request=query_request,
            user_id=user.get("user_id"),
            tenant_id=user.get("tenant_id")
        )
        return GatewayResponse(success=True, data=result)
    
    elif action == ActionType.GET_SAMPLE_QUESTIONS:
        samples = query_service.get_sample_questions()
        return GatewayResponse(success=True, data=samples)
    
    return GatewayResponse(success=False, error="Unknown query action", error_code="UNKNOWN_ACTION")


async def handle_nlq_memory(action: ActionType, payload: dict, user: dict, db: Session) -> GatewayResponse:
    nlq_service = NLQMemoryService(db)
    
    if action == ActionType.GET_HISTORY:
        history = nlq_service.get_history(
            tenant_id=user.get("tenant_id"),
            user_id=user.get("user_id"),
            limit=payload.get("limit", 50)
        )
        return GatewayResponse(
            success=True,
            data=[{
                "id": h.id,
                "normalized_query": h.normalized_query,
                "raw_user_input": h.raw_user_input,
                "intent": h.intent,
                "hit_count": h.hit_count,
                "last_used_at": h.last_used_at.isoformat() if h.last_used_at else None,
                "created_at": h.created_at.isoformat() if h.created_at else None
            } for h in history]
        )
    
    elif action == ActionType.CLEAR_HISTORY:
        count = nlq_service.clear_history(
            tenant_id=user.get("tenant_id"),
            user_id=user.get("user_id")
        )
        return GatewayResponse(success=True, data={"cleared_count": count})
    
    return GatewayResponse(success=False, error="Unknown NLQ memory action", error_code="UNKNOWN_ACTION")


async def handle_conversation(action: ActionType, payload: dict, user: dict, db: Session) -> GatewayResponse:
    conv_service = ConversationService(db)
    
    if action == ActionType.GET_CONVERSATIONS:
        conversations = conv_service.get_conversations(
            tenant_id=user.get("tenant_id"),
            user_id=user.get("user_id"),
            limit=payload.get("limit", 50)
        )
        return GatewayResponse(
            success=True,
            data=[c.model_dump() for c in conversations]
        )
    
    elif action == ActionType.GET_CONVERSATION:
        conversation = conv_service.get_conversation(
            conversation_id=payload.get("conversation_id"),
            tenant_id=user.get("tenant_id"),
            user_id=user.get("user_id")
        )
        if not conversation:
            return GatewayResponse(success=False, error="Conversation not found", error_code="NOT_FOUND")
        return GatewayResponse(success=True, data=conversation.model_dump())
    
    elif action == ActionType.CREATE_CONVERSATION:
        conversation = conv_service.create_conversation(
            tenant_id=user.get("tenant_id"),
            user_id=user.get("user_id"),
            title=payload.get("title")
        )
        return GatewayResponse(
            success=True,
            data={
                "id": conversation.id,
                "title": conversation.title,
                "created_at": conversation.created_at.isoformat()
            }
        )
    
    elif action == ActionType.DELETE_CONVERSATION:
        success = conv_service.delete_conversation(
            conversation_id=payload.get("conversation_id"),
            tenant_id=user.get("tenant_id"),
            user_id=user.get("user_id")
        )
        return GatewayResponse(success=success, data={"deleted": success})
    
    return GatewayResponse(success=False, error="Unknown conversation action", error_code="UNKNOWN_ACTION")


async def handle_feedback(action: ActionType, payload: dict, user: dict, db: Session) -> GatewayResponse:
    query_service = QueryEngineService(db)
    
    if action == ActionType.SUBMIT_FEEDBACK:
        success = query_service.submit_feedback(
            message_id=payload.get("message_id"),
            rating=payload.get("rating"),
            feedback=payload.get("feedback")
        )
        return GatewayResponse(success=success, data={"submitted": success})
    
    return GatewayResponse(success=False, error="Unknown feedback action", error_code="UNKNOWN_ACTION")


async def handle_export(action: ActionType, payload: dict, user: dict, db: Session) -> GatewayResponse:
    if action == ActionType.EXPORT_CSV:
        return GatewayResponse(
            success=True,
            data={"message": "CSV export not yet implemented", "format": "csv"}
        )
    
    elif action == ActionType.EXPORT_PDF:
        return GatewayResponse(
            success=True,
            data={"message": "PDF export not yet implemented", "format": "pdf"}
        )
    
    return GatewayResponse(success=False, error="Unknown export action", error_code="UNKNOWN_ACTION")
