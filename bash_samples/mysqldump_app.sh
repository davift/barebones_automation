#!/bin/bash

while :
do
    echo "Starting my_app" `date` >> /var/log/my_app.log

    # Uploading to AWS S3 with Emcryption
	( mysqldump --single-transaction --routines --quick --column-statistics=0 db_name | gpg -r "username@example.com" --yes --encrypt -q | aws s3 cp --no-progress - s3://bucket_name/db_name.sql.gpg ) &>> /var/log/my_app.log
	# Uploading to any S3 using S3CMD with throutled speed to 1 mbps
	( mysqldump --no-tablespaces --lock-tables=false db_name | throttle -k 1024 | s3cmd put - s3://bucket_name/db_name ) &>> /var/log/my_app.log
	# Uploading to MinIO with Compression
	( mysqldump --no-tablespaces --lock-tables=false db_name | gzip -c | mc pipe -q https://host:9000/bucket_name/db_name.tar.gz ) &>> /var/log/my_app.log

	echo "Pausing for 6 hours before starting over" >> /var/log/my_app.log
	sleep 360
done
