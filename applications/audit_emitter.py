import json
import uuid
import datetime
import hashlib
import boto3

EVENT_BUS = "audit-events"

def emit_event(action, actor):
    event = {
        "event_id": str(uuid.uuid4()),
        "timestamp": datetime.datetime.utcnow().isoformat(),
        "actor": actor,
        "action": action
    }

    event["hash"] = hashlib.sha256(
        json.dumps(event, sort_keys=True).encode()
    ).hexdigest()

    client = boto3.client("events")

    response = client.put_events(
        Entries=[{
            "Source": "regulated.app",
            "DetailType": "audit_event",
            "Detail": json.dumps(event),
            "EventBusName": EVENT_BUS
        }]
    )

    print("SUCCESS:", response)

if __name__ == "__main__":
    emit_event("ACCOUNT_BALANCE_VIEW", "user_123")
