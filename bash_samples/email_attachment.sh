#!/usr/bin/bash

# Sending attachment on email (requires install Mutt).
echo 'Body of the email. Just any text or message.' | mutt -s "Subject of the email sent at `date "%Y-%m-%d %H:%M:%S"`" -e 'set from=sender@example.com' -e 'set realname=Sender Name' destination@example.com -a /opt/PATH/file.zip

# Sending a text file in the email body, instead of attached.
( echo "Subject: Test"; cat email_body.txt ) | msmtp username@example.com
# Or
cat email_body.txt | msmtp -a default username@example.com

echo ''
echo 'Email Sent'
echo ''
exit 0
