#!/bin/bash

indir='/var/local/motion/'
date=$(echo $1 | sed 's/-//g' | sed 's:/::g')

let "oldlockdate = date - 1"

cd $indir
mkdir $date

lockfile=motion_${date}.lock
touch $lockfile
function finish {
    rm -rf $lockfile
}
trap finish EXIT SIGINT SIGTERM SIGKILL SIGQUIT

while [ -e motion_${oldlockdate}.lock ]
do
    echo "Waiting on processing from $oldlockdate."
    sleep 300
done

imagecount=0
for f in $(ls -tr ${indir}/*${date}*jpg)
do
    printf -v count "%04d" $imagecount
    ln -s $f ${date}/frame_$count.jpg
    let "imagecount += 1"
done

ffmpeg -i ${date}/frame_%04d.jpg -preset veryfast ${date}_daily.mp4
rm -rf ${date}

/usr/local/bin/aws s3 cp ${date}_daily.mp4 s3://lunt-security/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
