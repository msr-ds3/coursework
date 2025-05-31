#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
#$ cut -d , -f4 201402-citibike-tripdata.csv | sort | uniq | wc -l
#330


# count the number of unique bikes
#$ cut -d , -f12 201402-citibike-tripdata.csv | sort | uniq | wc -l
#5700

# count the number of trips per day
# $ cut -d , -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | sort | uniq -c | sort | head -n2
#       1 starttime
#     876 2014-02-13

# find the day with the most rides
 #$cut -d , -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | sort | uniq -c | sort -r | head -n1
 # 13816 2014-02-02


# find the day with the fewest rides
#$cut -d , -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | sort | uniq -c | sort | head -n2

# find the id of the bike with the most rides
#$cut -d , -f12 201402-citibike-tripdata.csv | sort | uniq -c | sort -r | head -n1

# count the number of rides by gender and birth year
#$ cut -d, -f15,14 201402-citibike-tripdata.csv | sort | uniq -c | sort -r

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
# $ cut -d, -f5 201402-citibike-tripdata.csv | tail -n +2 | grep -E '.*[0-9].*&.*[0-9].*' | wc -l
# 90549

# compute the average trip duration
#  awk -F, {sum += $1; count++} END {print sum/count}' 201402-citibike-tripdata.csv 
# 874.516


#running average script for first 1000 lines
# $ head -n 1000 201402-citibike-tripdata.csv | awk '{ 
#   window[NR % 3] = $1
#   if (NR >= 3) {
#     print (window[(NR-1)%3] + window[(NR-2)%3] + window[(NR-3)%3]) / 3
#   }
# }'

#MUSICAL CHAIR  in python
# import random

# names = ["Alou", "Srijana", "Sara", "Drishya", "Dereck", "Ahmed",
#          "Aisha", "Vaishnavi", "Naomi", "Sofia", "Ye", "Vanessa"]

# random.shuffle(names)

# for i in range(0, 12, 2):
#     print(f"{names[i]} & {names[i+1]}")

