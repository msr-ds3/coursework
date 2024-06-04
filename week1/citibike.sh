#!/bin/bash
#
# add your solution after each of the 10 comments below
#

    #  1  tripduration
    #  2  starttime
    #  3  stoptime
    #  4  start station id
    #  5  start station name
    #  6  start station latitude
    #  7  start station longitude
    #  8  end station id
    #  9  end station name
    # 10  end station latitude
    # 11  end station longitude
    # 12  bikeid
    # 13  usertype
    # 14  birth year
    # 15  gender

# count the number of unique stations
cut -d, -f8 201402* | sort | uniq -c | wc -l

# count the number of unique bikes
cut -d, -f12 201402* | sort | uniq -c | wc -l

# count the number of trips per day
cut -d, -f2 201402* | cut -c1-10 | uniq -c | tail -n+2

# find the day with the most rides
cut -d, -f2 201402* | cut -c1-10 | uniq -c | tail -n+2 | sort -r | head -n1

# find the day with the fewest rides
cut -d, -f2 201402* | cut -c1-10 | uniq -c | tail -n+2 | sort | head -n1

# find the id of the bike with the most rides
cut -d, -f12 201402* | sort | uniq -c | sort -r | head -n1

# count the number of rides by gender and birth year
cut -d, -f14,15 201402* | sort | uniq -c

# count the number of trips that start on cross streets that both contain numbers 
# (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cut -d, -f5 201402-citibike-tripdata.csv | grep '[0-9].*[^0-9].*[0-9]' | wc -l

# compute the average trip duration
awk '{total += $1;freq += 1} END {print total/freq}' 201402*