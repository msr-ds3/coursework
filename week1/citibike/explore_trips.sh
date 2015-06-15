#!/bin/bash
#
# description:
#   explores the citibike data on the command line
#
# usage:
#   will run as a script (./explore.sh), but better
#   as a guide/reference
#
# requirements:
#
# author: jmh
#

# what does the data set look like?

# list file sizes in human readable form
ls -talh

# look at the first line
head -n1 201402-citibike-tripdata.csv

# look at the first 10 lines
head 201402-citibike-tripdata.csv

# scroll interactively from the beginning of the file
less 201402-citibike-tripdata.csv

# look at the last 10 lines
tail 201402-citibike-tripdata.csv

# count the number of lines in this file
wc -l 201402-citibike-tripdata.csv

# the same, but for all tripdata files
wc -l *-citibike-tripdata.csv

# extract rider gender in column 15
# limit to first 10 lines
cut -d, -f15 201402-citibike-tripdata.csv | head

# find the earliest birth year in column 14
cut -d, -f14 201402-citibike-tripdata.csv | sort | head

# find the latest birth year in column 14
cut -d, -f14 201402-citibike-tripdata.csv | sort | tail

# find all trips either starting or ending on broadway
grep Broadway 201402-citibike-tripdata.csv

# count all trips that start and end on broadway
cut -d, -f5,9 201307-citibike-tripdata.csv | grep 'Broadway.*Broadway' | wc -l

# find all stations along broadway
cut -d, -f5 201402-citibike-tripdata.csv | grep Broadway | sort | uniq

# find the latest birth year in column 14, limiting to lines with a number
cut -d, -f14 201402-citibike-tripdata.csv | grep '[0-9]' | sort | tail

# count trips by gender
cut -d, -f15 201402-citibike-tripdata.csv | sort | uniq -c

# convert comma-separated file to tab-separated file
cat 201402-citibike-tripdata.csv | tr , '\t' > 201402-citibike-tripdata.tsv

# find the 10 most frequent station-to-station trips
cut -f5,9 201402-citibike-tripdata.tsv | sort | uniq -c | sort -nr | head

# show column header with numbers
head -n1 201307-citibike-tripdata.csv | tr , '\n' | cat -n

# use awk to count all trips that start and end on broadway
awk -F, '$5 ~ /Broadway/ && $9 ~ /Broadway/' 201307-citibike-tripdata.csv | wc -l

# count trips by gender, avoiding sort
time awk -F, '{counts[$15]++} END {for (gender in counts) print counts[gender]"\t"gender}' 201307-citibike-tripdata.csv
