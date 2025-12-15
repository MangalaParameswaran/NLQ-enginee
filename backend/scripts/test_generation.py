import sys
import os

# Add backend to path
sys.path.append(os.path.join(os.getcwd(), "backend"))

from app.services.gemini_service import gemini_service

def test_generation():
    print("Testing SQL generation...")
    try:
        query = "Show me monthly expenses for 2024"
        schema = "Table: analytics_expenses\nColumns: expense_date, amount, category, description\nIMPORTANT: Use ILIKE for string matching."
        plan = {"tables": ["analytics_expenses"], "select_columns": ["date_trunc('month', expense_date)", "sum(amount)"]}
        
        sql = gemini_service.sql_generator.generate(query, plan, schema)
        print(f"Generated SQL: {sql}")
        
        if "SELECT" in sql:
            print("SUCCESS: Valid SQL generated.")
        else:
            print("FAILURE: Invalid generation.")
            
    except Exception as e:
        print(f"ERROR: {e}")

if __name__ == "__main__":
    test_generation()
