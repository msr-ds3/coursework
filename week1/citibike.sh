#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
# not very smart, needs to wc and modify the numbers
tail -n224736 201402-citibike-tripdata.csv|awk -F, '{counts[$4]++}{counts[$8]++} END {for (k in counts) print counts[k]"\t" k }' |wc -l



# count the number of unique bikes
#needs to remove 1 from the ans because the first row gives col info
cut -d, -f12 201402-citibike-tripdata.csv |sort -n|uniq -c|wc -l

# count the number of trips per day
 cut -d, -f2 201402-citibike-tripdata.csv | grep -o '^[^ ]*' | sort -n| uniq -c

# find the day with the most rides
 cut -d, -f2 201402-citibike-tripdata.csv | grep -o '^[^ ]*' | sort | uniq -c| sort -n| tail -n1
# find the day with the fewest rides
cut -d, -f2 201402-citibike-tripdata.csv | grep -o '^[^ ]*' | sort | uniq -c| sort -n | head -n2

# find the id of the bike with the most rides
cut -d, -f12 201402-citibike-tripdata.csv |sort | uniq -c |sort -n | tail -n1

# count the number of rides by gender and birth year
cut -d, -f15,14 201402-citibike-tripdata.csv |sort |uniq -c|sort -r

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cut -d, -f5 201402-citibike-tripdata.csv | grep -o ".*[0-9].*&.*[0-9].*"| wc -l

# compute the average trip duration
cut -d, -f1 201402-citibike-tripdata.csv | tr -d '"'|awk '{sum+=$1} END{print sum/NR}'