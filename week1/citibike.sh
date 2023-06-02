#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
tail -n224736 201402-citibike-tripdata.csv | awk -F, '{stations[$4]=1} {stations[$8]=1} END { print length(stations) }'

# count the number of unique bikes
tail -n224736 201402-citibike-tripdata.csv | awk -F, '{bikes[$12]=1} END { print length(bikes) }'

# count the number of trips per day
## cut into the 2nd column (start time), pretend the string starts at the last occurence of '-' and ignore everything after the first space
## then sort the days, and count the unique how many times each day appears.
cut -d, -f2 201402-citibike-tripdata.csv | grep -Po '^.*-\K[^ ]*' | sort | uniq -c
## alternative solution to include the first part of the date
cut -d, -f2 201402-citibike-tripdata.csv | grep -o '^[^ ]*' | tr -d '"' | tail -n224736 | sort | uniq -c

# find the day with the most rides
cut -d, -f2 201402-citibike-tripdata.csv | grep -o '^[^ ]*' | tr -d '"' | tail -n224736 | sort | uniq -c | sort -r | head -n1

# find the day with the fewest rides
cut -d, -f2 201402-citibike-tripdata.csv | grep -o '^[^ ]*' | tr -d '"' | tail -n224736 | sort | uniq -c | sort | head -n1

# find the id of the bike with the most rides
cut -d, -f12 201402-citibike-tripdata.csv | tr -d '"' | tail -n224736 | sort | uniq -c | sort -r | head -n1

# count the number of rides by gender and birth year
cut -d, -f14,15 201402-citibike-tripdata.csv | tr -d '"' | tail -n224736 | sort | uniq -c

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cut -d, -f5 201402-citibike-tripdata.csv | grep '.*[0-9].*&.*[0-9].*' | wc -l

# compute the average trip duration
cut -d, -f1 201402-citibike-tripdata.csv | tr -d '"' | awk -F, '{total+=($1)} END { print total/NR }'