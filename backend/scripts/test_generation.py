import sys
import os

# Add backend to path
sys.path.append(os.path.join(os.getcwd(), "backend"))

from app.services.gemini_service import gemini_service

def test_generation():
    print("Testing SQL generation...")
    try:
        query = "What is the total sales by product category?"
        schema = "Table: products\nColumns: category, price\nTable: sales\nColumns: product_id, amount"
        plan = {"tables": ["sales"], "select_columns": ["sum(amount)"]}
        
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
