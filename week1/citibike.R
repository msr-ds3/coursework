library(tidyverse)
library(lubridate)


########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('201402-citibike-tripdata.csv')

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
summarize(trips, count = n())

# find the earliest and latest birth years (see help for max and min to deal with NAs)
trips %>% filter(grepl('[0-9]', birth_year)) %>% summarize(Max = max(birth_year))
trips %>% filter(grepl('[0-9]', birth_year)) %>% summarize(Min = min(birth_year))

# use filter and grepl to find all trips that either start or end on broadway
trips %>% filter(grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))

# do this all at once, by using summarize() with multiple arguments
trips %>% rips %>% filter(grepl('[0-9]', birth_year)) %>% summarize(MINIMUM = min(birth_year))

# do the same, but find all trips that both start and end on broadway
trips %>% filter(grepl('Broadway', start_station_name) , grepl('Broadway', end_station_name))

# find all unique station names
trips %>% group_by(start_station_name) %>% summarize()

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
trips %>% group_by(gender) %>% summarize(count = n(), avg_trip_time = mean(tripduration), sd_trip_time = sd(tripduration))

# find the 10 most frequent station-to-station trips
trips %>% group_by(start_station_name, end_station_name) %>% summarize(count = n()) %>% arrange(desc(count)) %>% head(10)

# find the top 3 end stations for trips starting from each start station
trips %>% group_by(start_station_name, end_station_name) %>% summarize(count = n()) %>% filter(rank(desc(count)) <= 3) %>% arrange(start_station_name, desc(count))

# find the top 3 most common station-to-station trips by gender
trips %>% group_by(gender, start_station_name, end_station_name) %>% summarize(count = n()) %>% group_by(gender) %>% arrange(desc(count)) %>% slice(1:3)
  
# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>% mutate(date = as.Date(starttime)) %>% group_by(date) %>% summarize(count = n()) %>% head(1)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips %>% mutate(ymd = floor_date(starttime, "day"), hour = hour(starttime)) %>% group_by(hour) %>% summarize(num_trips = n(), num_days = n_distinct(ymd), avg_trips = num_trips/num_days) %>% arrange(desc(avg_trips))  

