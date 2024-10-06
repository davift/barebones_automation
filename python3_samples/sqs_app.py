#!/usr/bin/python3
import boto3
import json
import time
import os

# Environments
AWS_ACCESS_KEY = os.environ.get('AWS_ACCESS_KEY')
AWS_SECRET_KEY = os.environ.get('AWS_SECRET_KEY')
ACCOUNT_ID='10000000000'
QUEUE_NAME='queue_name'

sqs = boto3.client('sqs', aws_access_key_id=AWS_ACCESS_KEY, aws_secret_access_key=AWS_SECRET_KEY, region_name="us-east-1")
queue_url = "https://sqs.us-west-2.amazonaws.com/" + ACCOUNT_ID + "/" + QUEUE_NAME

def handle_message(message):
  receipt_handle = message ['ReceiptHandle']
  body = json.loads(message["Body"])["Records"][0]
  s3Body = body["s3"]

  # Processing S3 type event from SQS. In this example, printing.
  print(body["eventName"], s3Body["object"]["key"])

  # Deleting the message from the queue.
  sqs.delete_message(QueueUrl = queue_url,ReceiptHandle = receipt_handle)

while True:
    # Checking for messages.
    response = sqs.receive_message( QueueUrl=queue_url, MaxNumberOfMessages=50)

    # 1 minute sleep if there is no messages.
    if(len(response.get("Messages",[]))==0):
      time.sleep(60)
      continue;

    # Processing messages.
    for message in response['Messages']:
      handle_message(message)
