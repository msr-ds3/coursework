#!/bin/bash

# filter original 1gram file googlebooks-eng-all-1gram-20120701-1.gz to only lines where the ngram exactly matches a year (18xx, 19xx, or 20xx, where x is a digit)
#   decompress the first using gunzip, zless, zcat or similar
zless googlebooks-eng-all-1gram-20120701-1.gz | grep -P '^((18[0-9]{2})|(19[0-9]{2})|(20[0-9]{2}))\t' > year_counts.tsv
#   then filter out rows that match using grep -E, egrep, awk, or similar
#   write results to year_counts.tsv
#awk -F '\t' '$1 ~ /^(18|19|20)[0-9]{2}\b/' googlebooks-eng-all-1gram-20120701-1 > year_counts.tsv