#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
cut -d, -f4,8 201402-citibike-tripdata.csv | tr , "\n" | grep '[0-9]' | sort | uniq -c | wc -l

# count the number of unique bikes
cut -d, -f12 201402-citibike-tripdata.csv | grep '[0-9]' | sort | uniq -c | wc -l

# count the number of trips per day
cut -d, -f2 201402-citibike-tripdata.csv | cut -d- -f3 | cut -d' ' -f1 | sort | uniq -c

# find the day with the most rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -d- -f3 | cut -d' ' -f1 | uniq -c | sort -nr | head -n1

# find the day with the fewest rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -d- -f3 | cut -d' ' -f1 | grep '[0-9]' | uniq -c | sort -n | head -n1

# find the id of the bike with the most rides
cut -d, -f12 201402-citibike-tripdata.csv | grep '[0-9]' | sort | uniq -c | sort -nr | head -n1

# count the number of rides by gender and birth year
cut -d, -f15,14 201402-citibike-tripdata.csv | grep '[0-9]' | sort | uniq -c

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cut -d, -f5 201402-citibike-tripdata.csv | grep '[0-9].*&.*[0-9]' | wc -l

# compute the average trip duration
awk -F, '{sum+=$3-$2 n++} END { print "Average = ",sum/n}' 201402-citibike-tripdata.csv