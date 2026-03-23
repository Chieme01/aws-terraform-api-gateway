import json

def lambda_handler(event, context):
    body = "Hello from Lambda A"
    statuscode = 200
    print("lambda A ran", event)
    return {
        "statusCode": statuscode,
        "body": json.dumps(body),
        "headers": {
            "Content-Type": "application/json"
        }
    }