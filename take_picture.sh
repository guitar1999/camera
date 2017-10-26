#!/bin/bash

now=$(date +'%Y%m%d%H%M%S')
sudo service motion stop
/usr/bin/raspistill -hf -vf -o /var/local/camera/${now}.jpg
sudo service motion start
/usr/local/bin/aws s3 cp /var/local/camera/${now}.jpg s3://lunt-security/daily_images/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
