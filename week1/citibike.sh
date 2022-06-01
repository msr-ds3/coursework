#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
 cat 201402-citibike-tripdata.csv | cut -d, -f4 | sort -n| uniq| head -n -1| wc -l


# count the number of unique bikes
 cat 201402-citibike-tripdata.csv | cut -d, -f12 |sort -n|uniq|head -n -1|wc -l 

 
# count the number of trips per day
cat 201402-citibike-tripdata.csv | cut -d, -f2| cut -d' ' -f1|sort -n|uniq -c|head -n -1


# find the day with the most rides
cat 201402-citibike-tripdata.csv | cut -d, -f2| cut -d' ' -f1|sort -n|uniq -c|head -n -1|sort -nr|head -n1


# find the day with the fewest rides
cat 201402-citibike-tripdata.csv | cut -d, -f2| cut -d' ' -f1|sort -n|uniq -c|head -n -1|sort -n|head -n1


# find the id of the bike with the most rides
cat 201402-citibike-tripdata.csv | cut -d, -f12 | sort -n| uniq -c | head -n -1 | sort -nr | head -n1



# count the number of rides by gender and birth year
cat 201402-citibike-tripdata.csv | cut -d, -f14,15|sort -n|uniq -c|head -n -2|less


# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cat 201402-citibike-tripdata.csv | cut -d, -f5 |grep "[0-9].*&.*[0-9]"|wc -l



# compute the average trip duration
cat 201402-citibike-tripdata.csv | cut -d, -f1 |tail -n +2|cut -d'"' -f2| awk '{count += 1; sum += $1;} END {print sum/count}'
