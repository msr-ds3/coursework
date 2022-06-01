#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
    echo "unique stations"
    cut -d, -f4 201402-citibike-tripdata.csv | grep '[0-9]' | sort | uniq | wc -l
    #329
    #or can use f8 - end station id

# count the number of unique bikes
    echo "unique bikes"
    cut -d, -f12 201402-citibike-tripdata.csv | grep '[0-9]' | sort | uniq | wc -l
    #5699

# count the number of trips per day
    echo "trips per day"
    cut -d, -f2 201402-citibike-tripdata.csv | grep '[0-9]' | cut -c1-11 | uniq -c

# find the day with the most rides
    echo "day most rides"
    cut -d, -f2 201402-citibike-tripdata.csv | grep '[0-9]' | cut -c1-11 | uniq -c | sort -nr | head -n1

# find the day with the fewest rides
    echo "day least rides"
    cut -d, -f2 201402-citibike-tripdata.csv | grep '[0-9]' | cut -c1-11 | uniq -c | sort -nr | tail -n1

# find the id of the bike with the most rides
    echo "bike id most rides"
    cut -d, -f12 201402-citibike-tripdata.csv | grep '[0-9]' | sort | uniq -c | sort -nr | head -n1

# count the number of rides by gender and birth year
    echo "number of rides by gender and brith year"
    cut -d, -f14,15 201402-citibike-tripdata.csv | grep '[0-9]' | sort | uniq -c

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
    echo "number of trips starting on cross streets both containing numbers"
    cut -d, -f5 201402-citibike-tripdata.csv | grep '[0-9].*&.*[0-9]' | sort | uniq -c

# compute the average trip duration
    echo "average trip duration"
    cut -d, -f1 201402-citibike-tripdata.csv | tr -d '"' | grep '[0-9]' | awk -F, '{sum += $1} END {print sum/NR}'