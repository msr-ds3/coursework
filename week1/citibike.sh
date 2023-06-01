#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
cut -d, -f4,8 201402-citibike-tripdata.csv | tr ',' '\n' | sort | uniq | wc -l

# count the number of unique bikes
cut -d, -f12 201402-citibike-tripdata.csv | tr ',' '\n' | sort | uniq | wc -l

# count the number of trips per day
cut -d, -f4,8 201402-citibike-tripdata.csv | tr ',' '\n' | sort | uniq | wc -l
# create a numbered list of columns, translating commas to newlines and adding line numbers
awk -F, '2014-02-28' 201402-citibike-tripdata.csv | wc -l
# find the day with the most rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -d ' ' -f1 | sort | uniq -c | sort | tail -n1
# find the day with the fewest rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -d ' ' -f1 | sort | uniq -c | sort | head -n2 | tail -n1
# find the id of the bike with the most rides
cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq -c | sort | tail -n1
# count the number of rides by gender and birth year

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)


# compute the average trip duration
