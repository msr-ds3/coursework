#!/bin/bash
#
# add your solution after each of the 10 comments below
#
# count the number of unique stations
cut -d, -f4 201402-citibike-tripdata.csv | sort | uniq | wc
# count the number of unique bikes
cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq | wc
# count the number of trips per day
# 1st solution
cut -d, -f2 201402-citibike-tripdata.csv | grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" | sort | uniq -c
#2nd solution
cut -d, -f2 201402-citibike-tripdata.csv | cut -d" " -f1 | sort | uniq -c
# find the day with the most rides
cut -d, -f2 201402-citibike-tripdata.csv | grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" | uniq -c | sort | tail -n1
# find the day with the fewest rides
cut -d, -f2 201402-citibike-tripdata.csv | grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" | uniq -c | sort | head -n1
# find the id of the bike with the most rides
 cut -d, -f12 201402-citibike-tripdata.csv| sort | uniq -c | sort | tail -n1
# count the number of rides by gender and birth year
cut -d, -f14,15 201402-citibike-tripdata.csv | sort | uniq -c
# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
$ cut -d, -f5 201402-citibike-tripdata.csv | grep '.*[0-9].*&.*[0-9].*'
# compute the average trip duration

# sum of all the seconds in the column
total=$(cat 201402* | awk -F, '{s+=$1} END {print s}')
# total number of trips
totalTrips=$(cut -d, -f1 201402-citibike-tripdata.csv | wc -l)
# average trips duration in second
echo $(($total / $totalwTrips))


