#!/bin/bash

# use curl or wget to download the version 2 1gram file with all terms starting with "1", googlebooks-eng-all-1gram-20120701-1.gz
url=http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-1gram-20120701-1.gz

#download the gz file
curl -O $url

# update the timestamp on the resulting file using touch
# do not remove, this will keep make happy and avoid re-downloading of the data once you have it
touch googlebooks-eng-all-1gram-20120701-1.gz
#sed -i -e 's/\r$//' scriptname.sh
#less to view the doanloaded file, press q to quit