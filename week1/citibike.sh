#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
cat 201402-citibike-tripdata.csv | cut -d,  -f5 | sort | uniq | wc -l

# count the number of unique bikes
cat 201402-citibike-tripdata.csv | cut -d,  -f5 | sort | uniq | wc -l

# count the number of trips per day
 cat 201402-citibike-tripdata.csv |cut -d,  -f2 | grep -o '.* ' | sort | uniq -c

# find the day with the most rides
cat 201402-citibike-tripdata.csv |cut -d,  -f2 | grep -o '^.* ' | sort | uniq -c | sort -nr | head -n1 | cut -d' 
' -f4

# find the day with the fewest rides
cat 201402-citibike-tripdata.csv |cut -d,  -f2 | grep -o '^.* ' | sort | uniq -c | sort -bn | head -n1 | awk '{print $2} 


# find the id of the bike with the most rides
cat 201402-citibike-tripdata.csv |cut -d,  -f12 | sort | uniq -c | sort -r | head -n1 | awk '{print $2}'

# count the number of rides by gender and birth year
cat 201402-citibike-tripdata.csv | cut -d, -f 14,15 | sort | uniq | wc -l

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cat 201402-citibike-tripdata.csv | cut -d, -f5 | grep '.*[0-9]+*.*&.*[0-9]+*' | wc -l

# compute the average trip duration
cat 201402-citibike-tripdata.csv | cut -d, -f1 | awk -F, '{sum += $1; count +=1} END {print sum/ count}'
