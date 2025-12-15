import sys
import os
import json
from unittest.mock import MagicMock

# Add backend to path
sys.path.append(os.path.join(os.getcwd(), "backend"))

from app.services.query_engine_service import QueryEngineService

# Mock classes
class MockDataSource:
    def __init__(self, id, tenant_id, name, tables_info, schema_info):
        self.id = id
        self.tenant_id = tenant_id
        self.name = name
        self.tables_info = tables_info
        self.schema_info = schema_info
        self.is_active = True

def test_get_schema_context():
    # Mock DB Session
    mock_db = MagicMock()
    
    # Mock Data
    tables_info = {
        "tables": [
            {
                "name": "users",
                "description": "User accounts",
                "columns": [
                    "id", 
                    {"name": "username", "type": "VARCHAR", "description": "Login name"},
                    {"name": "created_at", "type": "TIMESTAMP", "description": "Creation time"}
                ]
            }
        ]
    }
    
    mock_ds = MockDataSource(
        id=1,
        tenant_id=1,
        name="TestDB",
        tables_info=json.dumps(tables_info),
        schema_info="A test database."
    )
    
    # Setup mock query
    mock_query = MagicMock()
    mock_filter = MagicMock()
    mock_filter.all.return_value = [mock_ds]
    mock_query.filter.return_value = mock_filter
    mock_db.query.return_value = mock_query

    # Test
    service = QueryEngineService(mock_db)
    context = service.get_schema_context(tenant_id=1)
    
    print("Generated Context:\n" + "="*20)
    print(context)
    print("="*20)
    
    # Assertions
    assert "Table: users" in context
    assert "IMPORTANT CONTEXT" in context
    assert "Use ILIKE" in context
    assert "username (VARCHAR)" in context

if __name__ == "__main__":
    test_get_schema_context()
