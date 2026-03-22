import json

def lambda_handler(event, context):
    body = "Hello from Lambda"
    statuscode = 200
    print("This lambda ran", event)
    return {
        "statusCode": statuscode,
        "body": json.dumps(body),
        "headers": {
            "Content-Type": "application/json"
        }
    }