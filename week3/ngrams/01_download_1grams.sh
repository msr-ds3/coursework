#!/bin/bash

# use curl or wget to download the version 2 1gram file with all terms starting with "1", googlebooks-eng-all-1gram-20120701-1.gz
url=http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-1gram-20120701-1.gz
curl -o googlebooks-eng-all-1gram-20120701-1.gz $url
touch googlebooks-eng-all-1gram-20120701-1.gz
# update the timestamp on the resulting file using touch
# do not remove, this will keep make happy and avoid re-downloading of the data once you have it


#
#url=http://files.grouplens.org/datasets/movielens/ml-10m.zip

# download ratings zip file
#[ -f movielens_10M.zip ] || curl -o movielens_10M.zip $url
