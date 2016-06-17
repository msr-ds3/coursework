# count the number of unique stations
cut -f5 -d, 201402-citibike-tripdata.csv | sort | uniq | wc -l


# count the number of unique bikes
cut -f12 -d, 201402-citibike-tripdata.csv | sort | uniq | wc -l

# extract all of the trip start times
cut -f2 -d, 201402-citibike-tripdata.csv
or
cut -f2 -d, 201402-citibike-tripdata.csv | cut -d" " -f2 | tr -d '"' 

# count the number of trips per day
cut -f2 -d, 201402-citibike-tripdata.csv | cut -d" " -f1 | tr -d '"' | uniq -c


# find the day with the most rides
cut -f2 -d, 201402-citibike-tripdata.csv | cut -d" " -f1 | tr -d '"' | uniq -c | sort -n | tail -n1


# find the day with the fewest rides

cut -f2 -d, 201402-citibike-tripdata.csv | cut -d" " -f1 | tr -d '"' | uniq -c | sort -n | head -n2

# find the id of the bike with the most rides
cut -f12 -d, 201402-citibike-tripdata.csv | sort -n | uniq -c | sort -n | tail -n1


# count the number of riders by gender and birth year
awk -F, '{if ($15 ~ 1) men[$14]++; else if($15 ~ 2) women[$14]++;} 
END {print "women:"; for (key in women) print key"\t"women[key]; 
print "men:"; for (key in men) print key"\t"men[key];}' 201402-citibike-tripdata.csv 


# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
 cut -d, -f5 201402-citibike-tripdata.csv | grep ".*[0-9].*&.*[0-9].*" | wc -l 

# compute the average trip duration
cut -d, -f2,3 201402-citibike-tripdata.csv | tr , : | tr -d '"' | tr - : | tr " " : | awk -F: '{ if ($3 ~ $9) count[i++]=(($10*60*60)+($11*60)+$12)-(($5*60)+($4*60*60)+$6); else count[i++]=86400-(($4*60*60)+($5*60)+$6)+(($10*60*60)+($11*60)+$12);  } END { for (i in count) total += count[i]; result=total/(i); print result; }'

or other way
cut -d, -f2,3 201402-citibike-tripdata.csv | tr , : | tr -d '"' | tr - : | tr " " : | awk -F: '{ if ($3 ~ $9) count[i++]=(($10*60*60)+($11*60)+$12)-(($5*60)+($4*60*60)+$6); else count[i++]=86400-(($4*60*60)+($5*60)+$6)+(($10*60*60)+($11*60)+$12);  } END { for (i in count) total += count[i]; result=total/(i); print result; }'


