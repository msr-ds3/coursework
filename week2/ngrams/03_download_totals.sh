#!/bin/bash

# use curl or wget to download the version 2 of the total counts file, googlebooks-eng-all-totalcounts-20120701.txt

# update the timestamp on the resulting file using touch
# do not remove, this will keep make happy and avoid re-downloading of the data once you have it
touch googlebooks-eng-all-totalcounts-20120701.txt
