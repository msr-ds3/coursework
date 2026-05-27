#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
# cut -d, -f4,8 201402-citibike-tripdata.csv | tr , '\n' | sort | uniq | wc -l
# Answer: 331 (-2 for headers)

# count the number of unique bikes
# cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq | wc -l 
# Answer: 5700

# count the number of trips per day
# cat 201402-citibike-tripdata.csv | cut -d, -f2 | cut -d'-' -f3 | cut -d' ' -f1 | sort | uniq -c | head -n28
# Answer: 
#   12771 01
#   13816 02
#    2600 03
#    8709 04
#    2746 05
#    7196 06
#    8495 07
#    5986 08
#    4996 09
#    6846 10
#    8343 11
#    8580 12
#     876 13
#    3609 14
#    2261 15
#    3003 16
#    4854 17
#    5140 18
#    8506 19
#   11792 20
#    8680 21
#   13044 22
#   13324 23
#   12922 24
#   12830 25
#   11188 26
#   12036 27
#    9587 28

# find the day with the most rides
# cut -d, -f2 201402-citibike-tripdata.csv | cut -d'-' -f3 | cut -d' ' -f1 | sort | uniq -c | sort -nr | head -n1 | tr ' ' '\n' | tail -n1
# Answer: 02

# find the day with the fewest rides
# cut -d, -f2 201402-citibike-tripdata.csv | cut -d'-' -f3 | cut -d' ' -f1 | sort | uniq -c | sort -nr | head -28 | sort -n | head -n1 | tr ' ' '\n' | tail -n1
# Answer: 13

# find the id of the bike with the most rides
# cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq -c | sort -nbr | head -n1 | tr ' ' '\n' | tail -n1
# Answer: 20837

# count the number of rides by gender and birth year
# cut -d, -f14,15 201402-citibike-tripdata.csv | sort -bn | uniq -c

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
# cut -d, -f5 201402-citibike-tripdata.csv | grep '[0-9].*&.*[0-9]' | wc -l
# Answer: 90549


# compute the average trip duration
# awk -F, '1 ~ /[0-9]*/{counts[0]++; duration[0]+=$1} END {print(duration[0]/counts[0])}' 201402-citibike-tripdata.csv
# Answer: 874.516
