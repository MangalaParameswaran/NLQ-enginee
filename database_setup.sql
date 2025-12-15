-- NLQ Engine Database Setup Script
-- Run this script on your local PostgreSQL database to set up all tables and sample data

-- =====================================================
-- STEP 1: CREATE TABLES
-- =====================================================

-- Tenants table
CREATE TABLE IF NOT EXISTS tenants (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    display_name VARCHAR(200),
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    db_type VARCHAR(50) DEFAULT 'postgresql',
    db_connection_string TEXT,
    rate_limit_per_minute INTEGER DEFAULT 60,
    rate_limit_per_hour INTEGER DEFAULT 1000
);

-- Organizations table
CREATE TABLE IF NOT EXISTS organizations (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER REFERENCES tenants(id),
    name VARCHAR(100) NOT NULL,
    display_name VARCHAR(200),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(200),
    hashed_password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    profile_picture TEXT,
    tenant_id INTEGER REFERENCES tenants(id),
    organization_id INTEGER REFERENCES organizations(id),
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

-- Data Sources table
CREATE TABLE IF NOT EXISTS data_sources (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER REFERENCES tenants(id),
    name VARCHAR(200) NOT NULL,
    db_type VARCHAR(50) DEFAULT 'postgresql',
    connection_string TEXT,
    schema_info TEXT,
    tables_info JSONB,
    is_active BOOLEAN DEFAULT TRUE,
    is_read_only BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Conversations table
CREATE TABLE IF NOT EXISTS conversations (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER REFERENCES tenants(id),
    user_id INTEGER REFERENCES users(id),
    title VARCHAR(200),
    is_archived BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Messages table
CREATE TABLE IF NOT EXISTS messages (
    id SERIAL PRIMARY KEY,
    conversation_id INTEGER REFERENCES conversations(id),
    role VARCHAR(20) NOT NULL,
    content TEXT,
    query_type VARCHAR(50),
    generated_query TEXT,
    query_result JSONB,
    chart_type VARCHAR(50),
    chart_data JSONB,
    insights JSONB,
    user_rating INTEGER,
    user_feedback TEXT,
    execution_time_ms FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- NLQ Memories table (query cache)
CREATE TABLE IF NOT EXISTS nlq_memories (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER REFERENCES tenants(id),
    user_id INTEGER REFERENCES users(id),
    raw_query TEXT NOT NULL,
    normalized_query TEXT,
    generated_sql TEXT,
    generated_mongo_pipeline TEXT,
    intent VARCHAR(50),
    metrics JSONB,
    filters JSONB,
    confidence_score FLOAT,
    usage_count INTEGER DEFAULT 1,
    last_used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Analytics: Regions
CREATE TABLE IF NOT EXISTS analytics_regions (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER NOT NULL,
    code VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100),
    timezone VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Analytics: Departments
CREATE TABLE IF NOT EXISTS analytics_departments (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER NOT NULL,
    code VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    cost_center VARCHAR(50),
    manager_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Analytics: Products
CREATE TABLE IF NOT EXISTS analytics_products (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER NOT NULL,
    sku VARCHAR(50) NOT NULL,
    name VARCHAR(200) NOT NULL,
    category VARCHAR(100),
    subcategory VARCHAR(100),
    unit_price DECIMAL(12,2),
    cost_price DECIMAL(12,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Analytics: Customers
CREATE TABLE IF NOT EXISTS analytics_customers (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER NOT NULL,
    customer_code VARCHAR(50) NOT NULL,
    company_name VARCHAR(200) NOT NULL,
    industry VARCHAR(100),
    segment VARCHAR(50),
    region_id INTEGER,
    credit_limit DECIMAL(12,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Analytics: Sales
CREATE TABLE IF NOT EXISTS analytics_sales (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER NOT NULL,
    order_number VARCHAR(50) NOT NULL,
    order_date DATE NOT NULL,
    customer_id INTEGER,
    product_id INTEGER,
    region_id INTEGER,
    sales_channel VARCHAR(50),
    quantity INTEGER,
    unit_price DECIMAL(12,2),
    discount_percent DECIMAL(5,2),
    total_amount DECIMAL(12,2),
    cost_amount DECIMAL(12,2),
    profit_amount DECIMAL(12,2),
    sales_rep VARCHAR(100),
    payment_status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Analytics: Expenses
CREATE TABLE IF NOT EXISTS analytics_expenses (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER NOT NULL,
    expense_date DATE NOT NULL,
    department_id INTEGER,
    category VARCHAR(100),
    subcategory VARCHAR(100),
    amount DECIMAL(12,2),
    cost_center VARCHAR(50),
    approval_status VARCHAR(50),
    vendor_name VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Analytics: Budgets
CREATE TABLE IF NOT EXISTS analytics_budgets (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER NOT NULL,
    fiscal_year INTEGER NOT NULL,
    fiscal_quarter INTEGER NOT NULL,
    department_id INTEGER,
    category VARCHAR(100),
    budget_allocated DECIMAL(12,2),
    budget_used DECIMAL(12,2),
    budget_remaining DECIMAL(12,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Analytics: Financial Summaries
CREATE TABLE IF NOT EXISTS analytics_financial_summaries (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER NOT NULL,
    period_year INTEGER NOT NULL,
    period_month INTEGER NOT NULL,
    period_quarter INTEGER,
    total_revenue DECIMAL(14,2),
    total_cogs DECIMAL(14,2),
    gross_profit DECIMAL(14,2),
    operating_expenses DECIMAL(14,2),
    operating_income DECIMAL(14,2),
    tax_expense DECIMAL(14,2),
    net_income DECIMAL(14,2),
    ebitda DECIMAL(14,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- STEP 2: INSERT SAMPLE DATA
-- =====================================================

-- Insert Tenants
INSERT INTO tenants (id, name, display_name, description, is_active, db_type, rate_limit_per_minute, rate_limit_per_hour) VALUES
(1, 'acme_corp', 'Acme Corporation', 'Primary demo tenant', TRUE, 'postgresql', 60, 1000),
(2, 'tech_startup', 'Tech Startup Inc', 'Secondary demo tenant', TRUE, 'postgresql', 30, 500);

-- Insert Organizations
INSERT INTO organizations (id, tenant_id, name, display_name, is_active) VALUES
(1, 1, 'engineering', 'Engineering Team', TRUE),
(2, 1, 'sales', 'Sales Team', TRUE),
(3, 2, 'product', 'Product Team', TRUE);

-- Insert Users (password for all: password123)
-- The hashed password is bcrypt hash of 'password123'
INSERT INTO users (id, email, name, hashed_password, tenant_id, organization_id, is_active, is_verified) VALUES
(1, 'admin@acme.com', 'Admin User', '$2b$12$DmZbMeY808O93ALEjp9LvuP6lmkpOu.rKYFQoQt3G8.9iKeUE6gS6', 1, 1, TRUE, TRUE),
(2, 'john@acme.com', 'John Smith', '$2b$12$DmZbMeY808O93ALEjp9LvuP6lmkpOu.rKYFQoQt3G8.9iKeUE6gS6', 1, 1, TRUE, TRUE),
(3, 'jane@acme.com', 'Jane Doe', '$2b$12$DmZbMeY808O93ALEjp9LvuP6lmkpOu.rKYFQoQt3G8.9iKeUE6gS6', 1, 2, TRUE, TRUE),
(4, 'demo@techstartup.com', 'Demo User', '$2b$12$DmZbMeY808O93ALEjp9LvuP6lmkpOu.rKYFQoQt3G8.9iKeUE6gS6', 2, 3, TRUE, TRUE);

-- Insert Data Sources
INSERT INTO data_sources (id, tenant_id, name, db_type, connection_string, schema_info, tables_info, is_active, is_read_only) VALUES
(1, 1, 'Enterprise Analytics Database', 'postgresql', 'current_database', 
 'Analytics schema with sales, expenses, budgets, and financial data covering 2023-2024',
 '{"tables": [
    {"name": "analytics_sales", "description": "Sales transactions with order details, customer, product, revenue and profit", "columns": ["order_number", "order_date", "customer_id", "product_id", "region_id", "sales_channel", "quantity", "unit_price", "discount_percent", "total_amount", "cost_amount", "profit_amount", "sales_rep", "payment_status", "tenant_id"]},
    {"name": "analytics_expenses", "description": "Expense records by category and department", "columns": ["expense_date", "department_id", "category", "subcategory", "amount", "cost_center", "approval_status", "vendor_name", "tenant_id"]},
    {"name": "analytics_customers", "description": "Customer master data", "columns": ["customer_code", "company_name", "industry", "segment", "region_id", "credit_limit", "tenant_id"]},
    {"name": "analytics_products", "description": "Product catalog with pricing", "columns": ["sku", "name", "category", "subcategory", "unit_price", "cost_price", "tenant_id"]},
    {"name": "analytics_departments", "description": "Department information", "columns": ["code", "name", "cost_center", "manager_name", "tenant_id"]},
    {"name": "analytics_regions", "description": "Geographic regions", "columns": ["code", "name", "country", "tenant_id"]},
    {"name": "analytics_budgets", "description": "Budget allocations by department and category", "columns": ["fiscal_year", "fiscal_quarter", "department_id", "category", "budget_allocated", "budget_used", "budget_remaining", "tenant_id"]},
    {"name": "analytics_financial_summaries", "description": "Monthly P&L summaries", "columns": ["period_year", "period_month", "total_revenue", "total_cogs", "gross_profit", "operating_expenses", "operating_income", "tax_expense", "net_income", "ebitda", "tenant_id"]}
  ]}',
 TRUE, TRUE);

-- Insert Regions (for both tenants)
INSERT INTO analytics_regions (tenant_id, code, name, country, timezone) VALUES
(1, 'NORTH', 'North Region', 'USA', 'America/New_York'),
(1, 'SOUTH', 'South Region', 'USA', 'America/Chicago'),
(1, 'EAST', 'East Region', 'USA', 'America/New_York'),
(1, 'WEST', 'West Region', 'USA', 'America/Los_Angeles'),
(1, 'INTL', 'International', 'Global', 'UTC');

-- Insert Departments (for tenant 1)
INSERT INTO analytics_departments (tenant_id, code, name, cost_center, manager_name) VALUES
(1, 'SALES', 'Sales Department', 'CC-SALES', 'Manager SALES'),
(1, 'FIN', 'Finance Department', 'CC-FIN', 'Manager FIN'),
(1, 'HR', 'Human Resources', 'CC-HR', 'Manager HR'),
(1, 'OPS', 'Operations', 'CC-OPS', 'Manager OPS'),
(1, 'MKT', 'Marketing', 'CC-MKT', 'Manager MKT');

-- Insert Products (10 products for tenant 1)
INSERT INTO analytics_products (tenant_id, sku, name, category, subcategory, unit_price, cost_price) VALUES
(1, 'PRD-001', 'Enterprise Software License', 'Software', 'Enterprise', 5000.00, 1500.00),
(1, 'PRD-002', 'Cloud Storage Plan', 'Services', 'Cloud', 199.00, 50.00),
(1, 'PRD-003', 'Analytics Dashboard Pro', 'Software', 'Analytics', 2500.00, 800.00),
(1, 'PRD-004', 'Data Integration Suite', 'Software', 'Integration', 3500.00, 1200.00),
(1, 'PRD-005', 'Mobile App Development Kit', 'Software', 'Mobile', 1500.00, 400.00),
(1, 'PRD-006', 'API Gateway License', 'Software', 'Infrastructure', 2000.00, 600.00),
(1, 'PRD-007', 'Security Compliance Package', 'Services', 'Security', 4500.00, 1500.00),
(1, 'PRD-008', 'Support Premium Plan', 'Services', 'Support', 500.00, 150.00),
(1, 'PRD-009', 'Training Workshop Bundle', 'Services', 'Training', 800.00, 200.00),
(1, 'PRD-010', 'Hardware Sensor Kit', 'Hardware', 'IoT', 350.00, 120.00);

-- Insert Customers (15 customers for tenant 1)
INSERT INTO analytics_customers (tenant_id, customer_code, company_name, industry, segment, region_id, credit_limit) VALUES
(1, 'CUST-001', 'TechCorp Industries', 'Technology', 'Enterprise', 2, 50000.00),
(1, 'CUST-002', 'Global Manufacturing Co', 'Manufacturing', 'Enterprise', 3, 500000.00),
(1, 'CUST-003', 'Healthcare Systems Inc', 'Healthcare', 'Enterprise', 4, 250000.00),
(1, 'CUST-004', 'Retail Solutions Ltd', 'Retail', 'Mid-Market', 3, 500000.00),
(1, 'CUST-005', 'Finance Partners LLC', 'Finance', 'Enterprise', 1, 1000000.00),
(1, 'CUST-006', 'Education First Group', 'Education', 'Mid-Market', 1, 50000.00),
(1, 'CUST-007', 'Logistics Network Inc', 'Logistics', 'Mid-Market', 4, 1000000.00),
(1, 'CUST-008', 'Energy Solutions Corp', 'Energy', 'Enterprise', 3, 1000000.00),
(1, 'CUST-009', 'Media Dynamics Ltd', 'Media', 'SMB', 3, 1000000.00),
(1, 'CUST-010', 'Startup Innovations', 'Technology', 'SMB', 3, 1000000.00),
(1, 'CUST-011', 'AgriTech Farms', 'Agriculture', 'Mid-Market', 5, 50000.00),
(1, 'CUST-012', 'Construction Builders Co', 'Construction', 'Mid-Market', 3, 500000.00),
(1, 'CUST-013', 'Telecom Networks', 'Telecommunications', 'Enterprise', 3, 100000.00),
(1, 'CUST-014', 'Travel Adventures Inc', 'Travel', 'SMB', 2, 1000000.00),
(1, 'CUST-015', 'Food Services Group', 'Food & Beverage', 'Mid-Market', 3, 50000.00);

-- Generate Sales Data (1200 records for 2023-2024)
INSERT INTO analytics_sales (tenant_id, order_number, order_date, customer_id, product_id, region_id, sales_channel, quantity, unit_price, discount_percent, total_amount, cost_amount, profit_amount, sales_rep, payment_status)
SELECT 
    1 as tenant_id,
    'ORD-' || LPAD(row_number() OVER ()::text, 6, '0') as order_number,
    DATE '2023-01-01' + (random() * 730)::int as order_date,
    (random() * 14 + 1)::int as customer_id,
    (random() * 9 + 1)::int as product_id,
    (random() * 4 + 1)::int as region_id,
    (ARRAY['Online', 'Direct', 'Partner', 'Reseller'])[floor(random() * 4 + 1)::int] as sales_channel,
    (random() * 10 + 1)::int as quantity,
    (random() * 4000 + 500)::decimal(12,2) as unit_price,
    (random() * 15)::decimal(5,2) as discount_percent,
    (random() * 50000 + 1000)::decimal(12,2) as total_amount,
    (random() * 20000 + 500)::decimal(12,2) as cost_amount,
    (random() * 30000 + 500)::decimal(12,2) as profit_amount,
    'Sales Rep ' || (random() * 5 + 1)::int as sales_rep,
    (ARRAY['Paid', 'Pending', 'Overdue'])[floor(random() * 3 + 1)::int] as payment_status
FROM generate_series(1, 1200);

-- Generate Expenses Data (600 records for 2023-2024)
INSERT INTO analytics_expenses (tenant_id, expense_date, department_id, category, subcategory, amount, cost_center, approval_status, vendor_name)
SELECT 
    1 as tenant_id,
    DATE '2023-01-01' + (random() * 730)::int as expense_date,
    (random() * 4 + 1)::int as department_id,
    (ARRAY['Travel', 'Payroll', 'Infrastructure', 'Marketing', 'Operations'])[floor(random() * 5 + 1)::int] as category,
    (ARRAY['Domestic', 'International', 'Equipment', 'Software', 'Consulting'])[floor(random() * 5 + 1)::int] as subcategory,
    (random() * 50000 + 500)::decimal(12,2) as amount,
    'CC-' || (ARRAY['SALES', 'FIN', 'HR', 'OPS', 'MKT'])[floor(random() * 5 + 1)::int] as cost_center,
    (ARRAY['Approved', 'Pending', 'Rejected'])[floor(random() * 3 + 1)::int] as approval_status,
    'Vendor ' || (random() * 20 + 1)::int as vendor_name
FROM generate_series(1, 600);

-- Generate Budget Data (for 2023-2024, all departments and categories)
INSERT INTO analytics_budgets (tenant_id, fiscal_year, fiscal_quarter, department_id, category, budget_allocated, budget_used, budget_remaining)
SELECT 
    1 as tenant_id,
    year as fiscal_year,
    quarter as fiscal_quarter,
    dept as department_id,
    cat as category,
    (random() * 400000 + 50000)::decimal(12,2) as budget_allocated,
    (random() * 350000 + 50000)::decimal(12,2) as budget_used,
    (random() * 150000 - 30000)::decimal(12,2) as budget_remaining
FROM 
    generate_series(2023, 2024) as year,
    generate_series(1, 4) as quarter,
    generate_series(1, 5) as dept,
    unnest(ARRAY['Travel', 'Payroll', 'Infrastructure', 'Marketing', 'Operations']) as cat;

-- Generate Financial Summaries (monthly for 2023-2024)
INSERT INTO analytics_financial_summaries (tenant_id, period_year, period_month, period_quarter, total_revenue, total_cogs, gross_profit, operating_expenses, operating_income, tax_expense, net_income, ebitda)
SELECT 
    1 as tenant_id,
    year as period_year,
    month as period_month,
    ((month - 1) / 3 + 1)::int as period_quarter,
    (random() * 1500000 + 500000)::decimal(14,2) as total_revenue,
    (random() * 600000 + 200000)::decimal(14,2) as total_cogs,
    (random() * 900000 + 300000)::decimal(14,2) as gross_profit,
    (random() * 500000 + 150000)::decimal(14,2) as operating_expenses,
    (random() * 600000 + 100000)::decimal(14,2) as operating_income,
    (random() * 150000 + 30000)::decimal(14,2) as tax_expense,
    (random() * 450000 + 70000)::decimal(14,2) as net_income,
    (random() * 650000 + 100000)::decimal(14,2) as ebitda
FROM 
    generate_series(2023, 2024) as year,
    generate_series(1, 12) as month;

-- Reset sequences to correct values
SELECT setval('tenants_id_seq', (SELECT MAX(id) FROM tenants));
SELECT setval('organizations_id_seq', (SELECT MAX(id) FROM organizations));
SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));
SELECT setval('data_sources_id_seq', (SELECT MAX(id) FROM data_sources));
SELECT setval('analytics_regions_id_seq', (SELECT MAX(id) FROM analytics_regions));
SELECT setval('analytics_departments_id_seq', (SELECT MAX(id) FROM analytics_departments));
SELECT setval('analytics_products_id_seq', (SELECT MAX(id) FROM analytics_products));
SELECT setval('analytics_customers_id_seq', (SELECT MAX(id) FROM analytics_customers));
SELECT setval('analytics_sales_id_seq', (SELECT MAX(id) FROM analytics_sales));
SELECT setval('analytics_expenses_id_seq', (SELECT MAX(id) FROM analytics_expenses));
SELECT setval('analytics_budgets_id_seq', (SELECT MAX(id) FROM analytics_budgets));
SELECT setval('analytics_financial_summaries_id_seq', (SELECT MAX(id) FROM analytics_financial_summaries));

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================
-- Run these to verify data was loaded correctly:

-- SELECT 'tenants' as table_name, COUNT(*) as count FROM tenants
-- UNION ALL SELECT 'organizations', COUNT(*) FROM organizations
-- UNION ALL SELECT 'users', COUNT(*) FROM users
-- UNION ALL SELECT 'data_sources', COUNT(*) FROM data_sources
-- UNION ALL SELECT 'analytics_regions', COUNT(*) FROM analytics_regions
-- UNION ALL SELECT 'analytics_departments', COUNT(*) FROM analytics_departments
-- UNION ALL SELECT 'analytics_products', COUNT(*) FROM analytics_products
-- UNION ALL SELECT 'analytics_customers', COUNT(*) FROM analytics_customers
-- UNION ALL SELECT 'analytics_sales', COUNT(*) FROM analytics_sales
-- UNION ALL SELECT 'analytics_expenses', COUNT(*) FROM analytics_expenses
-- UNION ALL SELECT 'analytics_budgets', COUNT(*) FROM analytics_budgets
-- UNION ALL SELECT 'analytics_financial_summaries', COUNT(*) FROM analytics_financial_summaries;

COMMIT;
