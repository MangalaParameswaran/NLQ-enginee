# NLQ Engine - Natural Language Query Engine

## Overview
A production-ready, enterprise-grade Natural Language Query Engine that allows users to query databases using natural language. Built with a multi-tenant architecture supporting PostgreSQL and MongoDB, featuring AI-powered query generation using Google Gemini.

## Tech Stack

### Backend
- **Framework**: FastAPI (Python 3.11)
- **AI**: Google Gemini via google-genai SDK
- **Database**: PostgreSQL with SQLAlchemy ORM
- **Authentication**: JWT with bcrypt password hashing
- **Architecture**: MVC with API Gateway pattern

### Frontend
- **Framework**: React 18 with Vite
- **UI Library**: Material UI (MUI)
- **Charts**: Recharts, D3.js, Chart.js
- **State**: React Context API
- **Features**: Dark/Light theme, Voice input (Web Speech API)

## Project Structure

```
/backend
  /app
    /api          - API Gateway endpoint
    /core         - Config, database, security, logging
    /middleware   - Auth and rate limiting middleware
    /models       - SQLAlchemy models (User, Tenant, Org, NLQMemory, Conversation, Message, DataSource)
    /schemas      - Pydantic schemas for validation
    /services     - Business logic (Auth, NLQ Memory, Query Engine, Gemini AI, Conversation, DataSource)
    main.py       - FastAPI application entry point

/frontend
  /src
    /components   - Reusable UI components (Chat, Charts, Layout)
    /context      - React contexts (Auth, Theme)
    /hooks        - Custom hooks (useSpeechRecognition)
    /pages        - Page components (Login, Signup, Dashboard)
    /services     - API client
    App.tsx       - Main app with routing
    theme.ts      - MUI theme configuration
```

## Key Features

1. **Multi-Tenancy**: Each user belongs to a tenant and organization
2. **API Gateway**: All frontend requests go through `/api/gateway`
3. **NLQ Memory**: Query caching per tenant/user to reduce AI costs
4. **Rate Limiting**: Per-IP, per-user, and tenant-aware throttling
5. **Read-Only SQL**: Strict enforcement of SELECT-only queries
6. **Voice Input**: Web Speech API for voice queries
7. **Auto Charts**: AI recommends best visualization type
8. **Insights**: AI-generated key takeaways from data

## Running the Application

### Backend
```bash
cd backend
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### Frontend
```bash
cd frontend
npm run dev
```

## Environment Variables

Required:
- `DATABASE_URL` - PostgreSQL connection string
- `GEMINI_API_KEY` - Google AI API key
- `SESSION_SECRET` - JWT signing secret

## API Gateway Actions

All requests go to `POST /api/gateway` with:
```json
{
  "service": "auth|query|conversation|nlq_memory|feedback|export",
  "action": "action_name",
  "payload": {}
}
```

### Auth Service
- `signup`, `login`, `refresh`, `logout`, `get_user`

### Query Service
- `execute_query`, `get_sample_questions`

### Conversation Service
- `get_conversations`, `get_conversation`, `create_conversation`, `delete_conversation`

### NLQ Memory Service
- `get_history`, `clear_history`

### Feedback Service
- `submit_feedback`

## User Preferences
- Dark mode preferred by default
- Voice input available for hands-free querying
