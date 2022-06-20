#!/bin/bash
# set a relative path for the citibike data
# (use current directory by default)
DATA_DIR=.

# change to the data directory
cd $DATA_DIR

# loop over each year/month
for year in 2020
do
    # note: remove '#' in line below to download all months
    for month in 02 01 03 04 05 06 07 08 09 10 11 12
    do

	# download the zip file
	# alternatively you can use wget if you don't have curl
	# wget $url
	url=https://s3.amazonaws.com/tripdata/${year}${month}-citibike-tripdata.csv.zip
	curl -O $url

	# define local file names
	file=`basename $url`
	csv=${file//.zip/}

	# unzip the downloaded file
	unzip -p $file > $csv

	# remove the zip file
	rm $file
    done
done