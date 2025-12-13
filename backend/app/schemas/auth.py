from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime


class SignupRequest(BaseModel):
    name: str = Field(..., min_length=2, max_length=255)
    email: EmailStr
    password: str = Field(..., min_length=8, max_length=100)
    org: str = Field(..., min_length=1, max_length=100)
    tenant_name: str = Field(..., min_length=1, max_length=255)
    phone_number: Optional[str] = None
    profile_picture: Optional[str] = None


class LoginRequest(BaseModel):
    email: EmailStr
    password: str
    org: str


class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    expires_in: int


class RefreshTokenRequest(BaseModel):
    refresh_token: str


class UserResponse(BaseModel):
    id: int
    email: str
    name: str
    phone_number: Optional[str]
    profile_picture: Optional[str]
    tenant_id: int
    tenant_name: str
    organization_id: int
    org_name: str
    is_active: bool
    created_at: datetime
    
    class Config:
        from_attributes = True


class TokenPayload(BaseModel):
    user_id: int
    email: str
    tenant_id: int
    tenant_name: str
    org_id: int
    org_name: str
