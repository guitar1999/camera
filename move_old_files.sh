#!/bin/bash
month=$1
start=$2
end=$3

for i in $(seq -f %02g ${start} ${end})
do 
    aws s3 mv s3://lunt-security/2017${month}${i}_daily.mp4 s3://lunt-security/2017/${month}/2017${month}${i}_daily.mp4 --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
done
