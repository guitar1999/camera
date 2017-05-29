#!/bin/bash
year=$1
month=$2
start=$3
end=$4

for i in $(seq -f %02g ${start} ${end})
do 
    aws s3 mv s3://lunt-security/${year}${month}${i}_daily.mp4 s3://lunt-security/${year}/${month}/${year}${month}${i}_daily.mp4 --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
done
