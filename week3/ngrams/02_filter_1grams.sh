#!/bin/bash

# filter original 1gram file googlebooks-eng-all-1gram-20120701-1.gz to only lines 
#where the ngram exactly matches a year (18xx, 19xx, or 20xx, where x is a digit)

#zless googlebooks-eng-all-1gram-20120701-1.gz | cut -f2 |grep "[12][089][0-9][0-9]" |sort -n -r|uniq -c

#   decompress the first using gunzip, zless, zcat or similar
#   then filter out rows that match using grep -E, egrep, awk, or similar
#   write results to year_counts.tsv

zless googlebooks-eng-all-1gram-20120701-1.gz |grep -E "^(18|19|20)[0-9][0-9]\s.*" > year_counts.tsv