#!/bin/bash

while :
do
    echo "Starting my_app" `date` >> /var/log/my_app.log

	# Simple query
	mysql -e 'select * from db_name.table_name' > /opt/PATH/query.output
	# Or
	mysql db_name <<< 'select * from table_name' > /opt/PATH/query.output
	# Or
	mysql < query_file.sql > /opt/PATH/query.output

    # Passing environment variables to a Python app for more complex data processing.
	source /home/ubuntu/.database
	DB_USER=$DB_USER DB_PASS=$DB_PASS /opt/PATH/my_app.py &>> /var/log/my_app.log

	echo "Pausing for 10 seconds before restarting" >> /var/log/my_app.log
	sleep 10
done
