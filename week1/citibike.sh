#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations

unique_stations=$(cut -d, -f4 201402-citibike-tripdata.csv | sort | uniq -c | awk 'NR!=1' | wc -l)
echo -e "Number of unique stations: $unique_stations \n"



# count the number of unique bikes

unique_bikes=$(cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq -c | awk 'NR!=1' | wc -l)
echo -e "Number of unique bikes: $unique_bikes \n"



# count the number of trips per day

trips_day=$(awk -F, 'NR!=1 {counts[substr($2, 2, 10)]++} END {for (k in counts) print k"\t" counts[k]}' 201402-citibike-tripdata.csv | sort )
echo -e "Number of trips in each day are: \n$trips_day \n"



# find the day with the most rides

most_rides=$(cut -d, -f2 201402-citibike-tripdata.csv | cut -d" " -f1 | sort | uniq -c | sort -nr | head -n1)
echo -e "The day with most rides is: $most_rides \n"



# find the day with the fewest rides

least_rides=$(cut -d, -f2 201402-citibike-tripdata.csv | cut -d" " -f1 | sort | uniq -c | sort -n | awk 'NR==2')
echo -e "The day with the fewest rides is: $least_rides \n"



# find the id of the bike with the most rides

bike_most_rides=$(cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq -c | sort -nr | head -n1)
echo -e "The bike id with most rides is: $bike_most_rides \n"



# count the number of rides by gender and birth year

birth_gender=$(cut -d, -f15,14 201402-citibike-tripdata.csv | sort | uniq -c | grep -v "birth" )
echo -e "The number of rides by gender and birth year are: \n$birth_gender \n"



# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)

cross_nums=$(awk -F"," '$5 ~ /[0-9].*&.*[0-9]/' 201402-citibike-tripdata.csv | wc -l)
echo -e "The number of trips that start on cross streets that both contain numbers is: $cross_nums \n"



# compute the average trip duration

avg_trips=$( awk -F\" 'NR!=1 {sum+=$2} END {print (sum/NR)/60}' 201402-citibike-tripdata.csv)
echo -e "The average trip duration is: $avg_trips \n"
