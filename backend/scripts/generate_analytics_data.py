#!/usr/bin/env python3
"""Generate enterprise analytics sample data."""
import os
import sys
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from datetime import datetime, timedelta
import random
from decimal import Decimal
from sqlalchemy import create_engine, text

DATABASE_URL = os.environ.get("DATABASE_URL")
engine = create_engine(DATABASE_URL)

TENANTS = [1, 2]  # acme_corp and tech_startup

DEPARTMENTS = [
    ("SALES", "Sales Department", "CC-SALES"),
    ("FIN", "Finance Department", "CC-FIN"),
    ("HR", "Human Resources", "CC-HR"),
    ("OPS", "Operations", "CC-OPS"),
    ("MKT", "Marketing", "CC-MKT"),
]

REGIONS = [
    ("NORTH", "North Region", "USA", "America/New_York"),
    ("SOUTH", "South Region", "USA", "America/Chicago"),
    ("EAST", "East Region", "USA", "America/New_York"),
    ("WEST", "West Region", "USA", "America/Los_Angeles"),
    ("INTL", "International", "Global", "UTC"),
]

PRODUCTS = [
    ("PRD-001", "Enterprise Software License", "Software", "Enterprise", 5000, 1500),
    ("PRD-002", "Cloud Storage Plan", "Services", "Cloud", 199, 50),
    ("PRD-003", "Analytics Dashboard Pro", "Software", "Analytics", 2500, 800),
    ("PRD-004", "Data Integration Suite", "Software", "Integration", 3500, 1200),
    ("PRD-005", "Mobile App Development Kit", "Software", "Mobile", 1500, 400),
    ("PRD-006", "API Gateway License", "Software", "Infrastructure", 2000, 600),
    ("PRD-007", "Security Compliance Package", "Services", "Security", 4500, 1500),
    ("PRD-008", "Support Premium Plan", "Services", "Support", 500, 150),
    ("PRD-009", "Training Workshop Bundle", "Services", "Training", 800, 200),
    ("PRD-010", "Hardware Sensor Kit", "Hardware", "IoT", 350, 120),
]

CUSTOMERS = [
    ("CUST-001", "TechCorp Industries", "Technology", "Enterprise"),
    ("CUST-002", "Global Manufacturing Co", "Manufacturing", "Enterprise"),
    ("CUST-003", "Healthcare Systems Inc", "Healthcare", "Enterprise"),
    ("CUST-004", "Retail Solutions Ltd", "Retail", "Mid-Market"),
    ("CUST-005", "Finance Partners LLC", "Finance", "Enterprise"),
    ("CUST-006", "Education First Group", "Education", "Mid-Market"),
    ("CUST-007", "Logistics Network Inc", "Logistics", "Mid-Market"),
    ("CUST-008", "Energy Solutions Corp", "Energy", "Enterprise"),
    ("CUST-009", "Media Dynamics Ltd", "Media", "SMB"),
    ("CUST-010", "Startup Innovations", "Technology", "SMB"),
    ("CUST-011", "AgriTech Farms", "Agriculture", "Mid-Market"),
    ("CUST-012", "Construction Builders Co", "Construction", "Mid-Market"),
    ("CUST-013", "Telecom Networks", "Telecommunications", "Enterprise"),
    ("CUST-014", "Travel Adventures Inc", "Travel", "SMB"),
    ("CUST-015", "Food Services Group", "Food & Beverage", "Mid-Market"),
]

EXPENSE_CATEGORIES = [
    ("Travel", ["Flights", "Hotels", "Meals", "Transportation"]),
    ("Payroll", ["Salaries", "Bonuses", "Benefits", "Overtime"]),
    ("Infrastructure", ["Servers", "Networking", "Cloud Services", "Software Licenses"]),
    ("Marketing", ["Advertising", "Events", "Content", "Social Media"]),
    ("Operations", ["Office Supplies", "Utilities", "Maintenance", "Equipment"]),
]

SALES_CHANNELS = ["Online", "Retail", "Partner", "Direct Sales", "Reseller"]
SALES_REPS = ["John Smith", "Jane Doe", "Mike Johnson", "Sarah Wilson", "David Brown", 
              "Emily Davis", "Chris Lee", "Amanda White", "Robert Taylor", "Lisa Anderson"]

def generate_data():
    with engine.connect() as conn:
        # Insert departments for each tenant
        print("Inserting departments...")
        for tenant_id in TENANTS:
            for code, name, cost_center in DEPARTMENTS:
                conn.execute(text("""
                    INSERT INTO analytics_departments (tenant_id, code, name, cost_center, manager_name)
                    VALUES (:tenant_id, :code, :name, :cost_center, :manager)
                    ON CONFLICT DO NOTHING
                """), {"tenant_id": tenant_id, "code": code, "name": name, 
                       "cost_center": cost_center, "manager": f"Manager {code}"})
        
        # Insert regions for each tenant
        print("Inserting regions...")
        for tenant_id in TENANTS:
            for code, name, country, tz in REGIONS:
                conn.execute(text("""
                    INSERT INTO analytics_regions (tenant_id, code, name, country, timezone)
                    VALUES (:tenant_id, :code, :name, :country, :tz)
                    ON CONFLICT DO NOTHING
                """), {"tenant_id": tenant_id, "code": code, "name": name, 
                       "country": country, "tz": tz})
        
        # Insert products for each tenant
        print("Inserting products...")
        for tenant_id in TENANTS:
            for sku, name, category, subcat, price, cost in PRODUCTS:
                conn.execute(text("""
                    INSERT INTO analytics_products (tenant_id, sku, name, category, subcategory, unit_price, cost_price)
                    VALUES (:tenant_id, :sku, :name, :category, :subcat, :price, :cost)
                    ON CONFLICT DO NOTHING
                """), {"tenant_id": tenant_id, "sku": sku, "name": name, 
                       "category": category, "subcat": subcat, "price": price, "cost": cost})
        
        # Insert customers for each tenant
        print("Inserting customers...")
        for tenant_id in TENANTS:
            for code, name, industry, segment in CUSTOMERS:
                region_id = random.randint(1, 5)
                credit = random.choice([50000, 100000, 250000, 500000, 1000000])
                conn.execute(text("""
                    INSERT INTO analytics_customers (tenant_id, customer_code, company_name, industry, segment, region_id, credit_limit)
                    VALUES (:tenant_id, :code, :name, :industry, :segment, :region_id, :credit)
                    ON CONFLICT DO NOTHING
                """), {"tenant_id": tenant_id, "code": code, "name": name, 
                       "industry": industry, "segment": segment, "region_id": region_id, "credit": credit})
        
        # Generate sales data (1000+ records per tenant)
        print("Generating sales data...")
        start_date = datetime(2023, 1, 1)
        end_date = datetime(2024, 12, 31)
        
        for tenant_id in TENANTS:
            for i in range(600):
                days_offset = random.randint(0, (end_date - start_date).days)
                order_date = start_date + timedelta(days=days_offset)
                
                customer_id = random.randint(1, 15)
                product_id = random.randint(1, 10)
                region_id = random.randint(1, 5)
                department_id = 1  # Sales department
                
                quantity = random.randint(1, 20)
                unit_price = PRODUCTS[product_id - 1][4]
                cost_price = PRODUCTS[product_id - 1][5]
                discount = random.choice([0, 5, 10, 15, 20])
                
                total = quantity * unit_price * (1 - discount / 100)
                cost = quantity * cost_price
                profit = total - cost
                
                conn.execute(text("""
                    INSERT INTO analytics_sales 
                    (tenant_id, order_number, order_date, customer_id, product_id, region_id, department_id,
                     sales_channel, quantity, unit_price, discount_percent, total_amount, cost_amount, profit_amount,
                     sales_rep, invoice_number, payment_status)
                    VALUES (:tenant_id, :order_num, :order_date, :customer_id, :product_id, :region_id, :dept_id,
                            :channel, :qty, :unit_price, :discount, :total, :cost, :profit, :rep, :invoice, :status)
                """), {
                    "tenant_id": tenant_id,
                    "order_num": f"ORD-{tenant_id}-{i+1:05d}",
                    "order_date": order_date.date(),
                    "customer_id": customer_id,
                    "product_id": product_id,
                    "region_id": region_id,
                    "dept_id": department_id,
                    "channel": random.choice(SALES_CHANNELS),
                    "qty": quantity,
                    "unit_price": unit_price,
                    "discount": discount,
                    "total": round(total, 2),
                    "cost": round(cost, 2),
                    "profit": round(profit, 2),
                    "rep": random.choice(SALES_REPS),
                    "invoice": f"INV-{tenant_id}-{i+1:05d}",
                    "status": random.choice(["Paid", "Paid", "Paid", "Pending", "Overdue"])
                })
        
        # Generate expense data (500+ records per tenant)
        print("Generating expense data...")
        for tenant_id in TENANTS:
            for i in range(300):
                days_offset = random.randint(0, (end_date - start_date).days)
                expense_date = start_date + timedelta(days=days_offset)
                
                category, subcats = random.choice(EXPENSE_CATEGORIES)
                subcategory = random.choice(subcats)
                department_id = random.randint(1, 5)
                
                if category == "Payroll":
                    amount = random.randint(5000, 50000)
                elif category == "Infrastructure":
                    amount = random.randint(1000, 20000)
                else:
                    amount = random.randint(100, 5000)
                
                conn.execute(text("""
                    INSERT INTO analytics_expenses
                    (tenant_id, expense_date, department_id, category, subcategory, description, amount,
                     cost_center, approval_status, payment_method, vendor_name)
                    VALUES (:tenant_id, :date, :dept_id, :category, :subcategory, :desc, :amount,
                            :cost_center, :status, :method, :vendor)
                """), {
                    "tenant_id": tenant_id,
                    "date": expense_date.date(),
                    "dept_id": department_id,
                    "category": category,
                    "subcategory": subcategory,
                    "desc": f"{subcategory} expense",
                    "amount": amount,
                    "cost_center": f"CC-{DEPARTMENTS[department_id-1][0]}",
                    "status": random.choice(["Approved", "Approved", "Approved", "Pending", "Rejected"]),
                    "method": random.choice(["Credit Card", "Bank Transfer", "Check", "Cash"]),
                    "vendor": f"Vendor {random.randint(1, 50)}"
                })
        
        # Generate budget data
        print("Generating budget data...")
        for tenant_id in TENANTS:
            for year in [2023, 2024]:
                for quarter in [1, 2, 3, 4]:
                    for dept_id in range(1, 6):
                        for category, _ in EXPENSE_CATEGORIES:
                            allocated = random.randint(50000, 500000)
                            used = int(allocated * random.uniform(0.6, 1.1))
                            remaining = allocated - used
                            
                            conn.execute(text("""
                                INSERT INTO analytics_budgets
                                (tenant_id, fiscal_year, fiscal_quarter, department_id, category,
                                 budget_allocated, budget_used, budget_remaining)
                                VALUES (:tenant_id, :year, :quarter, :dept_id, :category,
                                        :allocated, :used, :remaining)
                            """), {
                                "tenant_id": tenant_id,
                                "year": year,
                                "quarter": quarter,
                                "dept_id": dept_id,
                                "category": category,
                                "allocated": allocated,
                                "used": used,
                                "remaining": remaining
                            })
        
        # Generate financial summaries
        print("Generating financial summaries...")
        for tenant_id in TENANTS:
            for year in [2023, 2024]:
                for month in range(1, 13):
                    quarter = (month - 1) // 3 + 1
                    revenue = random.randint(500000, 2000000)
                    cogs = int(revenue * random.uniform(0.3, 0.5))
                    gross_profit = revenue - cogs
                    operating_exp = int(revenue * random.uniform(0.2, 0.35))
                    operating_income = gross_profit - operating_exp
                    tax = int(operating_income * 0.25) if operating_income > 0 else 0
                    net_income = operating_income - tax
                    ebitda = operating_income + int(operating_exp * 0.1)
                    
                    conn.execute(text("""
                        INSERT INTO analytics_financial_summaries
                        (tenant_id, period_year, period_month, period_quarter,
                         total_revenue, total_cogs, gross_profit, operating_expenses,
                         operating_income, tax_expense, net_income, ebitda)
                        VALUES (:tenant_id, :year, :month, :quarter,
                                :revenue, :cogs, :gross, :opex, :opinc, :tax, :net, :ebitda)
                    """), {
                        "tenant_id": tenant_id,
                        "year": year,
                        "month": month,
                        "quarter": quarter,
                        "revenue": revenue,
                        "cogs": cogs,
                        "gross": gross_profit,
                        "opex": operating_exp,
                        "opinc": operating_income,
                        "tax": tax,
                        "net": net_income,
                        "ebitda": ebitda
                    })
        
        conn.commit()
        print("Data generation complete!")

if __name__ == "__main__":
    generate_data()
