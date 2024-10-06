#!/bin/bash

# Variables
source /home/ubuntu/.ubuntu
UPLOAD="/opt/PATH/"

# FTP Interactive
while read file; do
    fname=$(echo $file | sed "s_$UPLOAD__g")

    ftp -inV $FTP_HOST <<END
    quote USER $FTP_USER
    quote PASS $FTP_PASS
    binary
    put $file $fname
    bye
END

    echo "Uploaded: $fname"
done < <(find $UPLOAD -type f -mmin -1 -print)

echo ''
echo 'Upload completed'
echo ''
exit 0
