import sys
import os

# Add backend to path
sys.path.append(os.path.join(os.getcwd(), "backend"))

from app.services.gemini_service import get_gemini_client

def test_client_init():
    print("Attempting to get Gemini client...")
    try:
        client = get_gemini_client()
        if client:
            print("SUCCESS: Gemini client initialized.")
            print(f"Client type: {type(client)}")
        else:
            print("FAILURE: Gemini client is None.")
    except Exception as e:
        print(f"ERROR: {e}")

if __name__ == "__main__":
    test_client_init()
