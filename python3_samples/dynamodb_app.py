#!/usr/bin/python3
import boto3
import os

# Enviroments
AWS_ACCESS_KEY = os.environ.get('AWS_ACCESS_KEY')
AWS_SECRET_KEY = os.environ.get('AWS_SECRET_KEY')

session = boto3.Session(AWS_ACCESS_KEY, AWS_SECRET_KEY, region_name = 'us-east-1')
dynamodb = session.resource("dynamodb")
table = dynamodb.Table('table_name')
startKey = None
response = table.scan()

# Rows / Entries
data = []
while True:
    for i in response['Items']:
        data.append(i)
    # Pagination: checks if it is the last page.
    if 'LastEvaluatedKey' not in response:
        break
    # Pagination: fetches the next page.
    response = table.scan(LastEvaluatedKey = response['LastEvaluatedKey'])

for row in data:
    for key in list(row.keys()):
        print(key, row[key])

print('Finished')
exit()
