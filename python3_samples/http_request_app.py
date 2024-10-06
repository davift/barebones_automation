#!/usr/bin/python3
import requests
import urllib
import json
import sys

# Where to send the payload to. E.g. example.com or example.com/api/xyz.php
domain = sys.argv[1]

# Fetching data from a Get request.
response = requests.get("https://api.ipify.org?format=json")
print('Received:', response.content)

if response.status_code != 200:
  print("Request failed!", flush=True)
  exit(1)

# Sending data via Get request.
escaped = urllib.parse.quote(response.content, safe='')
requests.get("https://" + domain + "?message=" + escaped)

# Sending data via Post request.
json_message = response.json()
requests.post("https://" + domain, json = json_message)

# Pretty printing JSON object.
print(json.dumps(json_message, indent=2))

exit()
