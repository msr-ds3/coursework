#!/bin/bash
#
# downloads movielens rating data
#
# see http://grouplens.org/datasets/movielens/ for more info
#

url=https://files.grouplens.org/datasets/movielens/ml-10m.zip

# download ratings zip file
[ -f ml-10m.zip ] || curl --ssl-no-revoke -o ml-10m.zip $url

# uncompress zip file
if [ ! -f ratings.dat ]
    then
    unzip ml-10m.zip && mv ml-10M100K/* .
fi

# reformat to comma-separated file
[ -f ratings.csv ] || cat ratings.dat | sed 's/::/,/g' > ratings.csv

[ -f movies.tsv ] || cat movies.dat | sed 's/::/	/g' > movies.tsv
