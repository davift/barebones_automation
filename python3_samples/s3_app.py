#!/usr/bin/python3
import boto3
import sys

s3 = boto3.resource('s3')
s3client = boto3.client('s3')

source_bucket = 'bucket_name'
destination_bucket = 'bucket_name'
counter = {}
counter['new'] = 0
counter['skipped'] = 0
counter['overwritten'] = 0

def copy_objects_by_prefix(source_prefix):
  objects = s3client.list_objects_v2(Bucket=source_bucket, Prefix=source_prefix)

  try :
    for item in objects['Contents']:
      copy_object(item['Key'])
  except :
    print('Zero objects in this prefix.')

  while objects['IsTruncated']:
    # Next pages
    objects = s3client.list_objects_v2(Bucket=source_bucket, Prefix=source_prefix, ContinuationToken=objects['NextContinuationToken'])
    for item in objects['Contents']:
      copy_object(item['Key'])

def copy_object(key):
  source = {'Bucket': source_bucket, 'Key': key}
  destination = ''

  etag_source = s3.Object(source_bucket, key).e_tag.strip('"')
  try :
    etag_destination = s3.Object(destination_bucket, destination).e_tag.strip('"')

    if etag_source != etag_destination:
      # Overwriting if etags are different
      s3.meta.client.copy(source, destination_bucket, destination)
      counter['overwritten'] += 1
    else:
      # Skipping identical objects.
      counter['skipped'] += 1
  except :
    # Copying new file.
    s3.meta.client.copy(source, destination_bucket, destination)
    counter['new'] += 1

copy_objects_by_prefix(sys.argv[1])
print('New files:', counter['new'])
print('Skipped files:', counter['equal'])
print('Overwriten files:', counter['different'])
exit()
