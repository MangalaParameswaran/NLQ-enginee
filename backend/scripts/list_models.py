import sys
import os

# Add backend to path
sys.path.append(os.path.join(os.getcwd(), "backend"))

from app.services.gemini_service import get_gemini_client

def list_models():
    client = get_gemini_client()
    if not client:
        print("Failed to init client")
        return

    try:
        # Loop through available models
        # Note: Syntax depends on the exact version of the library.
        # Trying a generic pager approach often used in Google SDKs.
        for model in client.models.list(config={}):
           print(model.name)
            
    except Exception as e:
        print(f"Error listing models: {e}")

if __name__ == "__main__":
    list_models()
