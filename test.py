import requests
import base64
import json

# Replace with your actual ShuftiPro credentials
CLIENT_ID = "o7PFvKcJMZKCJIWlGBb7DRGqoAfM2kxEIfPZPKXHCsmZ1ChPq51689211125"
SECRET_KEY =  "gIKH3kN6Gx53Fsr7bt0Lx9vb9fviWfft"


# ShuftiPro API endpoint (sandbox for testing)
API_URL = "https://api.shuftipro.com/status"  # Use / for actual verification

# Prepare basic auth header
auth_string = f"{CLIENT_ID}:{SECRET_KEY}"
auth_bytes = auth_string.encode("utf-8")
auth_b64 = base64.b64encode(auth_bytes).decode("utf-8")
headers = {
    "Authorization": f"Basic {auth_b64}",
    "Content-Type": "application/json"
}

# Example payload (for /status, payload is not required)
payload = {
    "reference": f"package_sample_Flutter_{__import__('datetime').datetime.now().isoformat()}"
}

try:
    response = requests.post(API_URL, headers=headers, json=payload)
    print("Status Code:", response.status_code)
    print("Response Body:")
    print(json.dumps(response.json(), indent=2))
except Exception as e:
    print("Error making API call:", str(e))
