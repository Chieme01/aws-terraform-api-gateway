import json

def lambda_handler(event, context):
    body = "Hello from Lambda B. The 2nd function."
    statuscode = 200
    print("lambda B ran", event)
    return {
        "statusCode": statuscode,
        "body": json.dumps(body),
        "headers": {
            "Content-Type": "application/json"
        }
    }