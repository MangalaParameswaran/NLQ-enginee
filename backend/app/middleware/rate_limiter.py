from fastapi import Request, HTTPException
from starlette.middleware.base import BaseHTTPMiddleware
from collections import defaultdict
from datetime import datetime, timedelta
from typing import Dict, Tuple
import asyncio
from app.core.config import settings
from app.core.logging_config import logger


class RateLimitStore:
    def __init__(self):
        self._ip_requests: Dict[str, list] = defaultdict(list)
        self._user_requests: Dict[int, list] = defaultdict(list)
        self._tenant_requests: Dict[int, list] = defaultdict(list)
        self._lock = asyncio.Lock()
    
    async def check_and_record(
        self,
        ip: str,
        user_id: int = None,
        tenant_id: int = None,
        tenant_rate_limit: int = None
    ) -> Tuple[bool, str]:
        async with self._lock:
            now = datetime.utcnow()
            minute_ago = now - timedelta(minutes=1)
            hour_ago = now - timedelta(hours=1)
            
            self._ip_requests[ip] = [t for t in self._ip_requests[ip] if t > minute_ago]
            
            if len(self._ip_requests[ip]) >= settings.RATE_LIMIT_PER_MINUTE:
                return False, "IP rate limit exceeded"
            
            if user_id:
                self._user_requests[user_id] = [t for t in self._user_requests[user_id] if t > minute_ago]
                if len(self._user_requests[user_id]) >= settings.RATE_LIMIT_PER_MINUTE:
                    return False, "User rate limit exceeded"
            
            if tenant_id:
                self._tenant_requests[tenant_id] = [t for t in self._tenant_requests[tenant_id] if t > hour_ago]
                limit = tenant_rate_limit or settings.RATE_LIMIT_PER_HOUR
                if len(self._tenant_requests[tenant_id]) >= limit:
                    return False, "Tenant rate limit exceeded"
            
            self._ip_requests[ip].append(now)
            if user_id:
                self._user_requests[user_id].append(now)
            if tenant_id:
                self._tenant_requests[tenant_id].append(now)
            
            return True, ""


rate_limit_store = RateLimitStore()


class RateLimitMiddleware(BaseHTTPMiddleware):
    def __init__(self, app, exclude_paths: list = None):
        super().__init__(app)
        self.exclude_paths = exclude_paths or ["/health", "/docs", "/openapi.json", "/redoc"]
    
    async def dispatch(self, request: Request, call_next):
        if any(request.url.path.startswith(p) for p in self.exclude_paths):
            return await call_next(request)
        
        client_ip = request.client.host if request.client else "unknown"
        
        user_id = getattr(request.state, "user_id", None) if hasattr(request, "state") else None
        tenant_id = getattr(request.state, "tenant_id", None) if hasattr(request, "state") else None
        tenant_rate_limit = getattr(request.state, "tenant_rate_limit", None) if hasattr(request, "state") else None
        
        allowed, reason = await rate_limit_store.check_and_record(
            ip=client_ip,
            user_id=user_id,
            tenant_id=tenant_id,
            tenant_rate_limit=tenant_rate_limit
        )
        
        if not allowed:
            logger.warning(f"Rate limit exceeded: {reason} for IP {client_ip}")
            raise HTTPException(status_code=429, detail=reason)
        
        response = await call_next(request)
        return response
