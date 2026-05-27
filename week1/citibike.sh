#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations 
cat 201402-citibike-tripdata.csv | cut -d, -f4 | sort -n | uniq | wc -l
# ANSWER: 330

# count the number of unique bikes
cat 201402-citibike-tripdata.csv | cut -d, -f12 | sort -n | uniq | wc -l
# ANSWER: 5700

# count the number of trips per day
cat 201402-citibike-tripdata.csv | cut -d, -f2 | cut -d' ' -f1 | sort | uniq -c
# ANSWER: the output (29)

# find the day with the most rides
cat 201402-citibike-tripdata.csv | cut -d, -f2 | cut -d' ' -f1 | sort | uniq -c | sort -r | head -5
# ANSWER: Feb 02

# find the day with the fewest rides
cat 201402-citibike-tripdata.csv | cut -d, -f2 | cut -d' ' -f1 | sort | uniq -c | sort | head -5
# ANSWER: Feb 13

# find the id of the bike with the most rides
cat 201402-citibike-tripdata.csv | cut -d, -f12 | sort | uniq -c | sort -r | head -5
# ANSWER: 20837

# count the number of rides by gender and birth year
cat 201402-citibike-tripdata.csv | cut -d, -f14,15 | sort | uniq -c | sort
# ANSWER: output (142 results)

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cat 201402-citibike-tripdata.csv | cut -d, -f5 | grep ".*[0-9].*&.*[0-9].*" | sort | uniq -c | sort -n
# ANSWER: output (99 results)

# compute the average trip duration
awk -F, 'BEGIN {sum = 0; trips = 0} {total += $1; trips++} END {print total/trips}' 201402-citibike-tripdata.csv
# ANSWER: 874.516