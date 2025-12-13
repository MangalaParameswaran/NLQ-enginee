# 📦 High-Level Enterprise Analytics Dataset Generator (Replit Prompt)

## 🧩 SYSTEM ROLE
You are a **senior data architect and analytics engineer**.
Your task is to design and generate a **realistic, enterprise-grade, high-level dataset**
that can be used for **analytics, dashboards, and natural language query engines**.

The dataset must look like it belongs to a **real organization** and follow best practices
used in production BI systems.

---

## 🎯 OBJECTIVE

Create a **high-level organizational dataset** covering:

- Sales
- Expenses
- Finance
- Budgeting
- Revenue
- Profit & Loss
- Departments
- Regions
- Customers
- Products
- Time-based metrics

This dataset will be used for:

- BI dashboards
- Charts & visualizations
- Reports
- Natural Language Queries (NLQ)
- Analytics & business insights

---

## 🏢 ORGANIZATION STRUCTURE (HIGH LEVEL)

Design the dataset assuming:

- **Multiple organizations (multi-tenant ready)**
- Each organization contains:
  - Departments (Sales, Finance, HR, Operations, Marketing)
  - Regions (North, South, East, West, International)
  - Teams under departments
  - Managers & employees (lightweight references, no PII)

---

## 📊 DATA DOMAINS TO INCLUDE

### 1️⃣ SALES

Include:

- Orders
- Invoices
- Customers
- Products
- Quantity
- Unit price
- Discounts
- Revenue
- Sales channel (Online, Retail, Partner)
- Region
- Sales date
- Sales representative / team

**Example analytics supported:**

- Monthly sales trend
- Top customers by revenue
- Revenue by region
- Product-wise sales performance

---

### 2️⃣ EXPENSES

Include:

- Expense category (Travel, Payroll, Infrastructure, Marketing, Operations)
- Department
- Amount
- Expense date
- Approval status
- Cost center

**Example analytics supported:**

- Expenses by department
- Monthly expense trend
- Budget vs actual expenses

---

### 3️⃣ FINANCE

Include:

- Revenue
- Expenses
- Gross profit
- Net profit
- Tax
- EBITDA
- Financial period (month, quarter, year)

**Support use cases:**

- Profit & Loss (P&L) statements
- Profitability analysis
- Year-over-year comparison

---

### 4️⃣ BUDGETING

Include:

- Budget allocated
- Budget used
- Remaining budget
- Department
- Fiscal year / quarter

---

### 5️⃣ TIME DIMENSION

Every major table must include:

- Date
- Month
- Quarter
- Year

---

## 🧱 DATA DESIGN REQUIREMENTS

- Use **relational data modeling**
- Use **UUIDs or numeric primary keys**
- Maintain **clear relationships** (foreign-key style references)
- Use **analytics-friendly column names**
- Avoid all personally identifiable information (PII)
- Keep values **realistic and business-meaningful**

---

## 📁 OUTPUT FORMAT

Generate the dataset in **ONE** of the following formats (choose one and stay consistent):

- PostgreSQL schema (DDL + INSERT statements)
- CSV files (one file per entity)
- JSON files (normalized, structured)

---

## 🧠 SCALE REQUIREMENTS

Minimum dataset size:

- 3 organizations (tenants)
- 5 departments per organization
- 12–24 months of historical data
- 1,000+ sales records
- 500+ expense records

---

## 🧪 SAMPLE DATA REQUIREMENTS

- Provide sample rows for **each table**
- Use realistic numeric values
- Ensure meaningful relationships between entities

---

## 📌 FINAL DELIVERABLE

Provide:

1. Schema definition
2. Sample data
3. Short explanation of each dataset/table
4. Example analytics or SQL queries the dataset supports

**Important:**
- Do NOT include UI or frontend code
- Focus ONLY on high-quality, analytics-ready data modeling and sample data

---

## ✅ EXPECTED USE CASES

This dataset must be suitable for:

- Natural Language Query engines
- AI-driven analytics
- Dashboards & KPI reporting
- Business intelligence platforms

---

_End of prompt._

