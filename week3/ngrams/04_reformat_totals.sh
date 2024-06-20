#!/bin/bash

# reformat total counts in googlebooks-eng-all-totalcounts-20120701.txt to a valid csv
#   use tr, awk, or sed to convert tabs to newlines
#   write results to total_counts.csv


#!/bin/bash

# Reformat total counts in googlebooks-eng-all-totalcounts-20120701.txt to a valid CSV
# Convert tab-separated values to comma-separated format and add headers

awk 'BEGIN {OFS=","; print "Year","TotalCounts","PageCount","BookCount"} {split($0, a, "\t"); for (i in a) {split(a[i], b, ","); print b[1], b[2], b[3], b[4];}}' googlebooks-eng-all-totalcounts-20120701.txt > total_counts.csv

