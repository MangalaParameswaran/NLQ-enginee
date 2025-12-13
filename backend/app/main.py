from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from contextlib import asynccontextmanager
import logging

from app.core.config import settings
from app.core.database import init_db
from app.core.logging_config import logger
from app.middleware.rate_limiter import RateLimitMiddleware
from app.middleware.auth_middleware import AuthMiddleware
from app.api.gateway import router as gateway_router


@asynccontextmanager
async def lifespan(app: FastAPI):
    logger.info("Starting NLQ Engine...")
    init_db()
    logger.info("Database initialized")
    yield
    logger.info("Shutting down NLQ Engine...")


app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    description="Natural Language Query Engine - Enterprise Multi-Tenant Analytics Platform",
    lifespan=lifespan
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.add_middleware(RateLimitMiddleware, exclude_paths=["/health", "/docs", "/openapi.json", "/redoc"])
app.add_middleware(AuthMiddleware, exclude_paths=["/health", "/docs", "/openapi.json", "/redoc", "/api/gateway"])

app.include_router(gateway_router, prefix="/api", tags=["Gateway"])


@app.get("/health")
async def health_check():
    return {"status": "healthy", "version": settings.APP_VERSION}


@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logger.error(f"Unhandled exception: {exc}", exc_info=True)
    return JSONResponse(
        status_code=500,
        content={
            "success": False,
            "error": "Internal server error",
            "error_code": "INTERNAL_ERROR"
        }
    )


@app.exception_handler(ValueError)
async def value_error_handler(request: Request, exc: ValueError):
    return JSONResponse(
        status_code=400,
        content={
            "success": False,
            "error": str(exc),
            "error_code": "VALIDATION_ERROR"
        }
    )
