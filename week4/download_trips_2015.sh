#!/bin/bash
#
# description:
#   fetches trip files from the citibike site http://www.citibikenyc.com/system-data
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

# change to the data directory
cd $DATA_DIR

# loop over each year/month
for year in 2015
do

    # download the zip file
    # alternatively you can use wget if you don't have curl
    # wget $url
    url=https://s3.amazonaws.com/tripdata/${year}-citibike-tripdata.zip
    curl -O $url

    # unzip the year's data
    unzip ${year}-citibike-tripdata.zip

    # move files out of subdirectories to current directory
    # getting rid of the annoying _1 in the filenames
    for f in ${year}-citibike-tripdata/*/*.csv
    do
	new_file=`basename ${f//_1/}`
	mv $f $new_file
    done

    # remove the zip file
    rm ${year}-citibike-tripdata.zip
done
