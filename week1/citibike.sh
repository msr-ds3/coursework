#!/bin/bash

# count the number of unique stations
printf 'unique stations: '
cut -d, -f4 201402* | sort | uniq -c | wc -l

# count the number of unique bikes
printf 'unique bikes: '
cut -d, -f12 201402* | sort | uniq -c | wc -l

# count the number of trips per day
echo number of trips/day:
cut -d, -f2 201402* | cut -d" " -f1 | sort | uniq -c

# find the day with the most rides
printf 'day with most rides: '
cut -d, -f2 201402* | cut -d" " -f1 | uniq -c | sort | tail -n1

# find the day with the fewest rides
echo 'day with fewest rides: '
cut -d, -f2 201402* | cut -d" " -f1 | uniq -c | sort | head -n2

# find the id of the bike with the most rides
printf 'bikeid with most rides: '
cut -d, -f12 201402* | sort | uniq -c | sort | tail -n1 | cat

# count the number of rides by gender and birth year
echo '\n number of rides by birthyear/gender:'
cut -d, -f14,15 201402-citibike-tripdata.csv | sort | uniq -c

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
printf 'number of trips starting at number inersecections: '
cut -d, -f5 201402* | grep '.*[0-9].*&.*[0-9].*' | wc -l

# compute the average trip duration
total=$(cat 201402* | awk -F, '{s+=$1} END {print s}')
count=$(cat 201402* | wc -l)
echo average: $(($total/$count)) seconds

# bring down to one line ?