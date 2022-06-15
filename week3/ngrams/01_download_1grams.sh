#!/bin/bash

# use curl or wget to download the version 2 1gram file with all terms starting with "1", googlebooks-eng-all-1gram-20120701-1.gz
DATA_DIR=.

cd $DATA_DIR

url=http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-3gram-20120701-1.gz
curl -0 $url

file=`basename $url`
csv=${file//.gz/}".csv"

unzip -p $file > $csv

rm $file

# update the timestamp on the resulting file using touch
# do not remove, this will keep make happy and avoid re-downloading of the data once you have it
touch googlebooks-eng-all-1gram-20120701-1.gz
