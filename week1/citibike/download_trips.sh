#!/bin/bash
#
# description:
#   fetches trip files from the citibike site http://www.citibikenyc.com/system-data
#   e.g., https://s3.amazonaws.com/tripdata/201307-citibike-tripdata.zip
#
# usage: ./download_trips.sh
#
# requirements: curl or wget
#
# author: jake hofman
#

# set a relative path for the citibike data
# (use current directory by default)
DATA_DIR=.

# get a list of all trip data file urls
# alternatively you can use wget instead if you don't have curl
# urls=`wget -O - 'http://www.citibikenyc.com/system-data' | grep tripdata.zip | cut -d'"' -f2`
urls=`curl 'http://www.citibikenyc.com/system-data' | grep tripdata.zip | cut -d'"' -f2`

# change to the data directory
cd $DATA_DIR

# loop over each month
for url in $urls
do
    # download the zip file
    # alternatively you can use wget if you don't have curl
    # wget $url
    curl -O $url

    # define local file names
    file=`basename $url`
    csv=${file//.zip/}".csv"

    # unzip the downloaded file
    unzip -p $file > $csv

    # remove the zip file
    rm $file
done
