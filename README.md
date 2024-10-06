# barebones_automation

The script in this repo were created based on my personal notes and have no utility as they are. Instead, they shoudl be used as a starting point to avoid start from scratch every time.

Every thing you can see is basic and shall be mastered by any SysAdm or DevOps because Bash and Python are the base of the Linux automation.

Of course, there are more sofisticated declarative tools line Ansible and Terraform, but they are not full replaments. They are complimnetary tools instead.

## Installation Script

A good installation script makes sure no manual file copy or edit is needed.

This installation script has a collections of features that might or not be the usage case:

- Checks if the process service account is being used.
- Prompts for all enviroment variables.
- Places all configuration files where they should be.
- Prevents others from reading the credentials in the files.
- Install any dependencies.

Strip them to meet your app needs.

- install_environments.sh
  - Creates the environment files for the app.
- install_service.sh
  - Creates a service that will initialize the app.

## Bash Samples

- email_attachemnt.sh
  - Sends a files as an attachment to an email.
- ftp_upload.sh
  - Sends a file via FTP.
  - Can also rename, delete, or download too.
- mysql_app.sh
  - Queries a MySQL directly then processes the entries.
- mysqldump.sh
  - Backup, encrypt, and compress a database backup.
- s3_upload.sh
  - Looks for files changed in the last minute then,
  - Uploads the files to an S3 bucket.

## Python Samples

- dynamodb_app.py
  - Scans and processes all records from a table.
- http_request_app.py
  - Makes a request and processes response,
  - Makes a Get request with parameters,
  - Makes a Post request with a JSON payload.
- mysql_app.py
  - Queries a database and processes the returned entries,
  - Gracefully handle exceptions (errors).
- s3_app.py
  - Checks etag between source and destination objects then,
  - Copies files over from one S3 to another S3.
- sqs_app.py
  - Consumes and processes messages from AWS SQS.
