library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('201402-citibike-tripdata.csv')

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# convert dates strings to datespwd
# trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))
na.rm

########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
nrow(trips)


# find the earliest and latest birth years (see help for max and min to deal with NAs)
trips %>% filter(birth_year != "\\N") %>% summarize( earliestBirthYear = min(birth_year), latestBirthYear = max(birth_year))

# use filter and grepl to find all trips that either start or end on broadway
trips %>% filter(grepl('Broadway', start_station_name) |
                 grepl('Broadway', end_station_name))

# do the same, but find all trips that both start and end on broadway
trips %>% filter(grepl('Broadway', start_station_name) &
                   grepl('Broadway', end_station_name))

# find all unique station names
unique(select(trips, start_station_name))
# other solution --> trips %>% distinct(start_station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
trips  %>% group_by(gender) %>% summarize(num_trips_by_gender = n(), 
                                avg_time = mean(tripduration), 
                                sd_time= sd(tripduration))

# find the 10 most frequent station-to-station trips
# select station id start, station id end 
# groupby
# count 
# unique
# head
group_by(trips, start_station_id, end_station_id) %>% summarize(count = n()) %>% arrange(desc(count)) %>% top_n(n=10)



# find the top 3 end stations for trips starting from each start station
# arrange(summarize(group_by(trips, start_station_id), count = n()), desc(count))
#filter(summarize(group_by(trips, start_station_id), count = n()), r
group_by(trips, start_station_id, end_station_id) %>% summarize(count = n()) %>% group_by(start_station_id) %>% top_n(n=3)

# find the top 3 most common station-to-station trips by gender
group_by(trips, gender, start_station_id, end_station_id) %>% summarize(count = n()) %>% arrange(desc(count)) %>% group_by(gender) %>% top_n(n=3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
mutate(trips, starttime = as.Date(starttime)) %>% group_by(starttime) %>% summarize(count = n()) %>% top_n(n=1)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
mutate(trips, starttime = substr(starttime, 11, 13)) %>% group_by(starttime) %>% summarize(count = mean(n()))
