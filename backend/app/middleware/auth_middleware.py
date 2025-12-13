from fastapi import Request, HTTPException
from starlette.middleware.base import BaseHTTPMiddleware
from app.core.security import verify_token
from app.core.logging_config import logger


class AuthMiddleware(BaseHTTPMiddleware):
    def __init__(self, app, exclude_paths: list = None):
        super().__init__(app)
        self.exclude_paths = exclude_paths or [
            "/health",
            "/docs",
            "/openapi.json",
            "/redoc",
            "/api/gateway"
        ]
    
    async def dispatch(self, request: Request, call_next):
        if any(request.url.path.startswith(p) for p in self.exclude_paths):
            return await call_next(request)
        
        auth_header = request.headers.get("Authorization")
        
        if auth_header and auth_header.startswith("Bearer "):
            token = auth_header.split(" ")[1]
            payload = verify_token(token, "access")
            
            if payload:
                request.state.user_id = payload.get("user_id")
                request.state.email = payload.get("email")
                request.state.tenant_id = payload.get("tenant_id")
                request.state.tenant_name = payload.get("tenant_name")
                request.state.org_id = payload.get("org_id")
                request.state.org_name = payload.get("org_name")
        
        response = await call_next(request)
        return response


def get_current_user(request: Request):
    if not hasattr(request.state, "user_id") or not request.state.user_id:
        raise HTTPException(status_code=401, detail="Not authenticated")
    
    return {
        "user_id": request.state.user_id,
        "email": request.state.email,
        "tenant_id": request.state.tenant_id,
        "tenant_name": request.state.tenant_name,
        "org_id": request.state.org_id,
        "org_name": request.state.org_name
    }
