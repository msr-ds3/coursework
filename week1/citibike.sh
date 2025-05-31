#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
cut -d, -f4 201402-citibike-tripdata.csv |sort | uniq -c | wc -l

# count the number of unique bikes
cut -d, -f12 201402-citibike-tripdata.csv |sort | uniq -c | wc -l

# count the number of trips per day
 cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1|sort| uniq -c

# find the day with the most rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1|sort| uniq -c|sort -r| head -1

# find the day with the fewest rides
$  cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1|sort| uniq -c|sort| tail -n+2| head -1

# find the id of the bike with the most rides
cut -d, -f12 201402-citibike-tripdata.csv| sort | uniq -c |sort -r| head -1

# count the number of rides by gender and birth year
cut -d',' -f14,15 201402-citibike-tripdata.csv | tail -n +2 | sort | uniq -c| 

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
awk -F, 'NR > 1 {print $5}' 201402-citibike-tripdata.csv | grep '[0-9].*&.*[0-9]' | wc -l




