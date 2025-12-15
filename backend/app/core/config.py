import os
from typing import List, Optional
from pydantic_settings import BaseSettings
from pydantic import Field          # ✅ CHANGE 1: ADDED (for env alias)
from functools import lru_cache


class Settings(BaseSettings):
    APP_NAME: str = "NLQ Engine"
    APP_VERSION: str = "1.0.0"
    DEBUG: bool = True

    # ❌ OLD (kept but NOT recommended – leaving as-is per your request)
    DATABASE_URL: str = os.environ.get("DATABASE_URL", "")

    # ❌ OLD
    # SECRET_KEY: str = "your-secret-key-change-in-production"

    # ✅ CHANGE 2: UPDATED
    # Maps SESSION_SECRET env var → SECRET_KEY
    SECRET_KEY: str = Field(
        default="your-secret-key-change-in-production",
        validation_alias="SESSION_SECRET"
    )

    JWT_ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    REFRESH_TOKEN_EXPIRE_DAYS: int = 7

    # ❌ OLD (kept as-is)
    GEMINI_API_KEY: str = os.environ.get("GEMINI_API_KEY", "")
    GEMINI_MODEL: str = "gemini-2.5-flash"

    RATE_LIMIT_PER_MINUTE: int = 60
    RATE_LIMIT_PER_HOUR: int = 1000
    RATE_LIMIT_BURST: int = 10

    CORS_ORIGINS: List[str] = ["*"]

    # ❌ OLD (kept as-is)
    MONGODB_URL: Optional[str] = os.environ.get("MONGODB_URL", None)

    class Config:
        env_file = ".env"
        case_sensitive = True


@lru_cache()
def get_settings() -> Settings:
    return Settings()


settings = get_settings()
