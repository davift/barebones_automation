#!/bin/bash

S3_BUCKET="bucket_name"
UPLOAD="/opt/PATH/"

while read file; do
    # Converting full path into relative path.
    fname=$(echo $file | sed "s_$UPLOAD__g")

    # Uploading
    aws s3 cp --no-progress "$file" "s3://$S3_BUCKET/$fname"
    echo "Uploaded: $fname"
done < <(find $UPLOAD -type f -mmin -1 -print)

echo ''
echo 'Upload completed'
echo ''
exit 0
