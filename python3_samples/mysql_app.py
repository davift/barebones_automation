#!/usr/bin/python3
from datetime import datetime
import MySQLdb
import warnings
import os

# Importing environment variables from a file.
from database_env import *

# Common libraries for multiple purposes.
#import urllib.request
#import csv
#import boto3
#import json
#import string

# Gathering credentials from runtime.
DB_USER = os.environ.get('DB_USER')
DB_PASS = os.environ.get('DB_PASS')

try:
    startTime = datetime.now()
    print("Starting: {}".format(startTime))

    # Mysql connection
    db = MySQLdb.connect(host=DB_HOST, user=DB_USER, passwd=DB_PASS, db=DB_NAME)
    db.set_character_set('utf8')
    warnings.filterwarnings("ignore", category=MySQLdb.Warning)

    cursor = db.cursor()
    query = "SELECT * FROM table_name"
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        for row in rows:
            print(row)
    except MySQLdb.Error as e:
        print("Error executing query: {}".format(e))

    cursor.close()
    db.close()

except Exception as e:
    print("Failed to connect to database. Error: {}".format(e))

finally:
    startTime = datetime.now()
    print("Finished. Time elapsed: {}".format(datetime.now() - startTime))

exit()
