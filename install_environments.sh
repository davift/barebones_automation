#!/bin/bash

if [ `whoami` != "ubuntu" ]; then
	echo ""
	echo "Switch to user 'ubuntu' and do not use 'sudo'"
	echo ""
	exit 2
fi

# As for the variables
echo "Enter database information:"
read -p "Host: " db_host
read -p "User: " db_user
read -p "Pass: " db_pass
read -p "Name: " db_name
echo "Enter AWS credentials:"
read -p "Access Key: " aws_access_key
read -p "Secret Key: " aws_secret_key
echo ""
echo "Review DB:"
echo "  'Host:'$db_host'"
echo "  'User:'$db_user'"
echo "  'Pass:'$db_pass'"
echo "  'Name:'$db_name'"
echo "Review AWS:"
echo "  'Access Key:'$aws_access_key'"
echo "  'Secret Key:'$aws_secret_key'"
echo ""
read -p "Is everything correct? (y/N): " toContinue

if [ "$toContinue" != "y" ] && [ "$toContinue" != "Y" ]; then
	echo ""
	echo "Installation aborted"
	echo ""
	exit 2
fi

# Placing variables
cat database_env | sed 's/<DB_USER>/'$db_user'/g;s/<DB_PASS>/'$db_pass'/g' > /home/ubuntu/database_env
cat database_env.py | sed 's/<DB_HOST>/'$db_host'/g;s/<DB_NAME>/'$db_name'/g' > /home/ubuntu/database_env.py
cat _my.cnf | sed 's/<DB_USER>/'$db_user'/g;s/<DB_PASS>/'$db_pass'/g;s/<DB_HOST>/'$db_host'/g;s/<DB_NAME>/'$db_name'/g' > /home/ubuntu/.my.cnf
mkdir -p /home/ubuntu/.aws/
# Note that secret keys might contain the characters /, +, and =
cat _aws_credentials | sed 's|<AWS_ACCESS_KEY>|'$aws_access_key'|g;s|<AWS_SECRET_KEY>|'$aws_secret_key'|g' > /home/ubuntu/.aws/credentials
cp _aws_config /home/ubuntu/.aws/config

# Locking files from others to read
chmod o-r -R /home/ubuntu/

# Installing dependencies (if applicable)
sudo apt update && sudo apt install mysql-client -y
sudo snap install aws-cli --classic

echo ""
echo "Installation completed!"
echo ""
exit 0
