#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
cut -d, -f4 201402-citibike-tripdata.csv | sort | uniq | head -n-1 | wc -l

# count the number of unique bikes
cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq | head -n-1 | wc -l

# count the number of trips per day
cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1  | sort | uniq -c | head -n-1

# find the day with the most rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | uniq -c |sort -nr | head -n1
 

# find the day with the fewest rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | uniq -c | sort | tail -n+2 | head -n1

# find the id of the bike with the most rides
cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq -c | sort -nr | head -n1
    

# count the number of rides by gender and birth year
cut -d, -f15,14 201402-citibike-tripdata.csv | sort | uniq -c | head -n-2
 

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cut -d, -f5 201402-citibike-tripdata.csv | grep ".*[0-9].*&.*[0-9].*" | wc -l



# compute the average trip duration
cat 201402-citibike-tripdata.csv | cut -d, -f1 |tail -n +2|cut -d'"' -f2| awk '{count +=1; sum+=$1;} END {print sum/count}'

