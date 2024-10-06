#!/bin/bash

if [ `whoami` != "root" ]; then
	echo ""
	echo "Switch to user 'root' or use 'sudo'"
	echo ""
	exit 2
fi

# As for the variables
echo "Enter information for:"
read -p "Service Name: " service_name
read -p "App Full Path: " full_path
echo ""
echo "Review:"
echo "  'Name:'$service_name'"
echo "  'Path:'$full_path'"
echo ""
read -p "Is everything correct? (y/N): " toContinue

if [ "$toContinue" != "y" ] && [ "$toContinue" != "Y" ]; then
	echo ""
	echo "Installation aborted"
	echo ""
	exit 2
fi

# Placing variables
cat template.service | sed 's/<SERVICE_NAME>/'$service_name'/g;s/<FULL_PATH>/'$full_path'/g' > /etc/systemd/system/$service_name.service

# Locking files from others to read
chmod o-r -R /home/ubuntu/

# Loading, starting, and enabling service to load on boot.
systemctl daemon-reload
systemctl enable $service_name --now

echo ""
echo "Installation completed!"
echo ""
exit 0
