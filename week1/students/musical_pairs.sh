#!/bin/bash

# check for the md5sum command
# if installed with coreutils, will have "g" in front of it
if [ `which md5sum` ]
then
    md5_cmd=md5sum
elif [ `which gmd5sum` ]
then
    md5_cmd=gmd5sum
else
    echo "Please install md5sum"
    exit 1
fi

# check for the shuf command
# if installed with coreutils, will have "g" in front of it
if [ `which shuf` ]
then
    shuf_cmd=shuf
elif [ `which gshuf` ]
then
    shuf_cmd=gshuf
else
    echo "Please install shuf"
    exit 1
fi

# use the date to set a random seed for the shuf command
# note: apparently shuf uses the initial bytes of the file
# so hash the date to get a random first character in the file
date +"%Y%m%d" | $md5_cmd > /tmp/ymd; ls *.txt | $shuf_cmd --random-source=/tmp/ymd | awk '{print; if (NR % 2 == 0) print "--------"}' | sed 's/\.txt$//'
