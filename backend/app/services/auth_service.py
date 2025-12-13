from sqlalchemy.orm import Session
from datetime import datetime
from typing import Optional, Tuple
from app.models.user import User
from app.models.tenant import Tenant, Organization
from app.schemas.auth import SignupRequest, LoginRequest, TokenResponse, UserResponse
from app.core.security import get_password_hash, verify_password, create_access_token, create_refresh_token
from app.core.config import settings


class AuthService:
    def __init__(self, db: Session):
        self.db = db
    
    def signup(self, request: SignupRequest) -> Tuple[UserResponse, TokenResponse]:
        existing_user = self.db.query(User).filter(User.email == request.email).first()
        if existing_user:
            raise ValueError("Email already registered")
        
        tenant = self.db.query(Tenant).filter(Tenant.name == request.tenant_name).first()
        if not tenant:
            tenant = Tenant(
                name=request.tenant_name,
                display_name=request.tenant_name,
                is_active=True
            )
            self.db.add(tenant)
            self.db.flush()
        
        org = self.db.query(Organization).filter(
            Organization.name == request.org,
            Organization.tenant_id == tenant.id
        ).first()
        if not org:
            org = Organization(
                name=request.org,
                display_name=request.org,
                tenant_id=tenant.id,
                is_active=True
            )
            self.db.add(org)
            self.db.flush()
        
        user = User(
            email=request.email,
            name=request.name,
            hashed_password=get_password_hash(request.password),
            phone_number=request.phone_number,
            profile_picture=request.profile_picture,
            tenant_id=tenant.id,
            organization_id=org.id,
            is_active=True
        )
        self.db.add(user)
        self.db.commit()
        self.db.refresh(user)
        
        tokens = self._create_tokens(user, tenant, org)
        user_response = self._build_user_response(user, tenant, org)
        
        return user_response, tokens
    
    def login(self, request: LoginRequest) -> Tuple[UserResponse, TokenResponse]:
        user = self.db.query(User).filter(User.email == request.email).first()
        if not user:
            raise ValueError("Invalid credentials")
        
        if not verify_password(request.password, user.hashed_password):
            raise ValueError("Invalid credentials")
        
        tenant = self.db.query(Tenant).filter(Tenant.id == user.tenant_id).first()
        org = self.db.query(Organization).filter(Organization.id == user.organization_id).first()
        
        if org.name != request.org:
            raise ValueError("Invalid organization")
        
        if not user.is_active:
            raise ValueError("Account is disabled")
        
        user.last_login = datetime.utcnow()
        self.db.commit()
        
        tokens = self._create_tokens(user, tenant, org)
        user_response = self._build_user_response(user, tenant, org)
        
        return user_response, tokens
    
    def refresh_token(self, user_id: int) -> TokenResponse:
        user = self.db.query(User).filter(User.id == user_id).first()
        if not user:
            raise ValueError("User not found")
        
        tenant = self.db.query(Tenant).filter(Tenant.id == user.tenant_id).first()
        org = self.db.query(Organization).filter(Organization.id == user.organization_id).first()
        
        return self._create_tokens(user, tenant, org)
    
    def get_user(self, user_id: int) -> UserResponse:
        user = self.db.query(User).filter(User.id == user_id).first()
        if not user:
            raise ValueError("User not found")
        
        tenant = self.db.query(Tenant).filter(Tenant.id == user.tenant_id).first()
        org = self.db.query(Organization).filter(Organization.id == user.organization_id).first()
        
        return self._build_user_response(user, tenant, org)
    
    def _create_tokens(self, user: User, tenant: Tenant, org: Organization) -> TokenResponse:
        token_data = {
            "user_id": user.id,
            "email": user.email,
            "tenant_id": tenant.id,
            "tenant_name": tenant.name,
            "org_id": org.id,
            "org_name": org.name
        }
        
        access_token = create_access_token(token_data)
        refresh_token = create_refresh_token(token_data)
        
        return TokenResponse(
            access_token=access_token,
            refresh_token=refresh_token,
            expires_in=settings.ACCESS_TOKEN_EXPIRE_MINUTES * 60
        )
    
    def _build_user_response(self, user: User, tenant: Tenant, org: Organization) -> UserResponse:
        return UserResponse(
            id=user.id,
            email=user.email,
            name=user.name,
            phone_number=user.phone_number,
            profile_picture=user.profile_picture,
            tenant_id=tenant.id,
            tenant_name=tenant.name,
            organization_id=org.id,
            org_name=org.name,
            is_active=user.is_active,
            created_at=user.created_at
        )
