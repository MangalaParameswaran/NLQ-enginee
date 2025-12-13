# 🧩 SYSTEM ROLE

You are a **full-stack enterprise engineer**.

Your task is to generate a **complete, production-ready Natural Language Query Engine (NLQ Engine)** with **fully runnable code**, covering frontend, backend, API gateway, authentication, rate-limiting, multi-tenancy, NLQ memory, and multi-database support.

---

# ⚙️ TECH STACK

## 🖥️ Frontend

**Framework & UI**
- React (Vite)
- MUI (Material UI)
- Premium 3D-style modern UI
- Dark / Light theme engine
- Responsive layout (desktop + mobile)

**Core Features**
- Chat UI with **ChatGPT-like conversation history**
- Voice input using **Web Speech API**
- Loader & skeleton UI
- Clarification prompts when queries are ambiguous
- Auto-suggested sample questions
- User input correction & normalization
- Toast notifications
- Feedback loop (user rating / correction feedback)

**Visualization & Output**
- Auto-selected charts using:
  - D3.js
  - Recharts
  - Chart.js
- Supported chart types:
  - Bar
  - Line
  - Pie
  - Area
  - Mixed charts
- Chart explanation (AI-generated)
- Table rendering
- Insight rendering (key takeaways)

**Authentication UI**
- Signup page
- Login page

**API Communication Rule (MANDATORY)**
- ⚠️ All frontend API calls **MUST go through a single API Gateway endpoint**:

```http
/api/gateway
```

---

## 🧠 Backend

**Core Stack**
- FastAPI
- Python 3.12.7
- LangChain
- LlamaIndex
- Gemini AI (**ONLY Gemini – no OpenAI**)

**Architecture**
- MVC architecture
- Router-AI pattern
- Dedicated **API Gateway layer**
- Centralized error handling
- Structured logging
- Security validation

**Core Capabilities**
- JWT-based authentication
- Token refresh support
- Multi-tenant architecture
- Strict **read-only SQL enforcement**
- Rate-limiting middleware
- Data-source abstraction layer

**Infrastructure**
- Docker-ready
- Config-driven setup
- Clear README with setup instructions

### ▶️ Run Commands

**Backend**
```bash
uvicorn app.main:app --reload
```

**Frontend**
```bash
npm run dev
```

---

# 🏢 MULTI-TENANCY (MANDATORY)

The system **MUST be multi-tenant by design**.

## Tenancy Rules

- Each user belongs to **exactly one tenant**
- Tenants are **configurable** (NOT hardcoded)
- New tenants can be added **without code changes**
- Tenant context must be resolved from:
  - JWT token
- Tenant enforcement is mandatory at:
  - Database query level
  - NLQ memory level

---

# 🔐 AUTHENTICATION & SIGNUP

## Signup Fields (MANDATORY)

- `name` (required)
- `email` (required)
- `password` (required)
- `org` (required, configurable – e.g. ITL, ITD)
- `tenant_name` (required)
- `phone_number` (optional)
- `profile_picture` (optional)

## Login Fields

- `email`
- `password`
- `org`

## Authentication Requirements

- JWT access token
- Refresh token support
- Secure password hashing (bcrypt / argon2)
- Tenant + org info embedded in JWT
- Protected API routes
- Secure frontend token storage

---

# 🧠 NLQ MEMORY / QUERY HISTORY (MANDATORY)

The system **MUST maintain a ChatGPT-style NLQ memory layer**.

## NLQ Memory Rules

- Every user query is stored
- Stored **per tenant + per user**
- Stored **before calling Gemini**
- Dedicated NLQ Memory storage (DB / collection)

## NLQ Memory Schema (Example)

```text
key   = normalized_llm_query
value = raw_user_input
```

## NLQ Memory Flow

```text
User Query
→ Normalize Query
→ Check NLQ Memory Store
→ If exists:
     reuse stored structured query
  Else:
     send to Gemini
     store mapping in NLQ DB
```

### Benefits
- Improved performance
- Reduced AI cost
- Consistent responses
- System learns over time

---

# 🗄️ MULTIPLE DATABASE SUPPORT

The backend **MUST support multiple data sources**.

## Required Components

- `DataSourceManager`
- `PostgreSQLQueryExecutor`
- `MongoDBQueryExecutor`

## Behavior

- Auto-route queries based on user `db_type`
- Enforce tenant-level data isolation
- Read-only execution only

---

# 🚦 RATE LIMITING (MANDATORY)

## Frontend

- Debounce user input
- Throttle API calls
- Prevent accidental request flooding

## Backend

- Global rate-limiting middleware
- Per-IP limits
- Per-user limits
- Tenant-aware throttling
- Fully configurable limits

---

# 🚏 API GATEWAY (MANDATORY)

All frontend requests **MUST go through**:

```http
/api/gateway
```

## Gateway Responsibilities

- Authentication validation
- Tenant resolution
- Rate limiting
- Routing to internal services:
  - AuthService
  - QueryEngineService
  - NLQMemoryService
  - AnalyticsService
  - ExportService
  - Future services (plug-and-play)

---

# 📊 NL → ANALYTICS PIPELINE

```text
User Query
→ API Gateway
→ Auth + Tenant Resolver
→ NLQ Memory Lookup
→ IntentDetector
→ MetricExtractor
→ FilterBuilder
→ QueryPlanner
→ SQLGenerator OR MongoPipelineGenerator
→ DataSourceManager
→ DB Execution
→ ChartRecommender
→ InsightEngine
→ ResponseAssembler
```

### Architecture Reference

```text
[ UI ]
   ↓
[ NLP / AI Agent ]
   ↓
[ Query Planner ]
   ↓
[ Data Connectors ]
   ↓
[ Execution Layer ]
   ↓
[ Visualization Engine ]
   ↓
[ Dashboard Generator ]
```

---

# 📝 FINAL INSTRUCTION

Generate **full production-ready code** that satisfies **all requirements above**.

- Code must be runnable
- No pseudo-code
- No placeholders
- Clean folder structure
- Enterprise-grade quality

---

# ✅ END OF DOCUMENT

