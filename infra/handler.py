import json
import boto3
import uuid
from datetime import datetime
import os

s3 = boto3.client("s3")

BUCKET = os.environ["EVIDENCE_BUCKET"]

def lambda_handler(event, context):
    print("Received event:", json.dumps(event))

    key = f"audit/{datetime.utcnow().isoformat()}-{uuid.uuid4()}.json"

    body = {
        "event": event,
        "request_id": context.aws_request_id,
        "timestamp": datetime.utcnow().isoformat()
    }

    s3.put_object(
        Bucket=BUCKET,
        Key=key,
        Body=json.dumps(body),
    )

    print(f"Successfully wrote audit object: {key}")

    return {
        "status": "stored",
        "object_key": key
    }
