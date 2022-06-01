#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
cut -d, -f4 201402-citibike-tripdata.csv | sort | uniq | wc -l
# count the number of unique bikes
cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq | wc -l
# count the number of trips per day
cut -d, -f2 201402-citibike-tripdata.csv | cut -c2-11 | sort | uniq -c
# find the day with the most rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -c2-11 | sort | uniq -c | cort -nr | head -n1 | cut -c3-7
# find the day with the fewest rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -c2-11 | sort | grep '[0-9]' | uniq -c | sort -nr | tail -n1 | cut -c3-7
# find the id of the bike with the most rides
cut -d, -f12 201402-citibike-tripdata.csv | sort | grep '[0-9]' | uniq -c | sort -nr | head -n1
# count the number of rides by gender and birth year
cut -d, -f14,15 201402-citibike-tripdata.csv | grep '[0-9]'| sort | uniq -c
# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cut -d, -f5 201402-citibike-tripdata.csv | grep '.*[0-9].*&.*[0-9]' | wc -l
# compute the average trip duration
cut -d, -f1 201402-citibike-tripdata.csv | tr -d '"' | awk '{sum += $1; count++} END { print sum/count }'
#adapted from https://linuxconfig.org/calculate-column-average-using-bash-shell#:~:text=%20%20%201%20One%20way%20to%20do,%3D%20%242%3B%20count%20%7D%20END%20%7B...%20More%20