#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
$ cut -d, -f5 201402-citibike-tripdata.csv | sort | uniq | wc -l

# count the number of unique bikes
$ cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq | wc -l

# count the number of trips per day
$ cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | uniq -c | sort -n

# find the day with the most rides
$ cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | uniq -c | sort -nr| head -n1

# find the day with the fewest rides
 $ cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | uniq -c | sort -nr| tail -n2

# find the id of the bike with the most rides
$ cut -d, -f12 201402* | sort | uniq -c | sort -nr | head -n1

# count the number of rides by gender and birth year
cut -d, -f15,14 201402* | sort | uniq -c

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
$ cut -d, -f5 201402* | grep '[0-9].*[0-9]' | sort | uniq | wc -l


# compute the average trip duration
$ awk '{total += $1; count++ } END {print total/count }' 201402*

