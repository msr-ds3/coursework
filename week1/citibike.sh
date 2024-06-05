#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
tail -n +2 201402-citibike-tripdata.csv | cut -d, -f2 | cut -d' ' -f1 | sort | uniq | wc -l

# count the number of unique bikes
cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq | wc -l
# count the number of trips per day
tail -n +2 201402-citibike-tripdata.csv | cut -d, -f2 |cut -d' ' -f1 | uniq -c | sort -n
cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | uniq -c | sort -n  

# find the day with the most rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | uniq -c | sort -n | tail -1
# find the day with the fewest rides
tail -n +2 201402-citibike-tripdata.csv | cut -d, -f2 |cut -d' ' -f1 | uniq -c | sort -n | head -1
# find the id of the bike with the most rides
cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq -c | sort | tail -1
# count the number of rides by gender and birth year
tail -n +2 201402-citibike-tripdata.csv | cut -d, -f14,15 | sort | uniq -c
# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cut -d, -f5 201402-citibike-tripdata.csv | grep '[0-9].*&.*[0-9]'| sort | uniq -c | sort -n | wc -l
# compute the average trip duration
awk -F, '{sum += $1; count++} END {if(count>0) print sum / count}' 201402-citibike-tripdata.csv
# compute the variance of the trip duration


# what if the mean is 10^12?

awk -F, '
{
    n++
    delta = $1 - mean
    mean += delta / n
    delta2 = $1 - mean
    M2 += delta * delta2
} 
END {
    if (n > 1) {
        variance = M2 / (n - 1)
        print variance
    }
}
' 201402-citibike-tripdata.csv



