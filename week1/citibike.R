library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('201402-citibike-tripdata.csv')

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# convert dates strings to dates
# trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))


########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
trips %>% summarize(count = n())

# find the earliest and latest birth years (see help for max and min to deal with NAs)
trips %>% 
  filter(birth_year != "\\N") %>% 
  summarize(min = min(birth_year), 
            max = max(birth_year)) 

# use filter and grepl to find all trips that either start or end on broadway
trips %>% 
  filter(grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))

# do the same, but find all trips that both start and end on broadway
trips %>% 
  filter(grepl('Broadway', start_station_name) & grepl('Broadway', end_station_name))

# find all unique station names
unique(trips$start_station_name) 
trips %>% distinct(start_station_name) %>% View

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
summarize(group_by(trips, gender), 
          count = n(), 
          average_trip_time = mean(tripduration), 
          sd_time = sd(tripduration))

# find the 10 most frequent station-to-station trips
trips %>% select(start_station_name, end_station_name) %>% 
  group_by(start_station_name, end_station_name) %>% 
  summarize(count = n()) %>% 
  arrange(count) %>% tail(10) 

# find the top 3 end stations for trips starting from each start station
group_by(trips, start_station_name, end_station_name) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count)) %>% 
  mutate(rank = row_number()) %>% 
  filter(rank <= 3) %>% 
  arrange(start_station_name)

# find the top 3 most common station-to-station trips by gender
group_by(trips, gender, station_to_station = paste(start_station_name, end_station_name)) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count)) %>% 
  mutate(rank = row_number()) %>% 
  filter(rank <= 3) %>%
  arrange(gender)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>% 
  mutate(date = as.Date(starttime)) %>% 
  group_by(date) %>%
  summarize(count = n()) %>%
  summarize(max = max(count))

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?

# for this, I could not figure out a better way to count up the number of rides per hour per day 
# so I assigned a new column num_trips = 1 across the entire table to count each day as one trip
# and then I summed this row for each hour and divided by 28 (the number of days is Feb 2014)
trips %>% 
  mutate(hour = hour(starttime), num_trip = 1) %>% 
  group_by(hour) %>%
  summarize(average = round(sum(num_trip) / 28)) %>%
  arrange(desc(average))

  #Hour 17:00 (5:00 PM) tends to be the peak hour with 800 rides
  #Hours 16:00 - 18:00 (4:00 PM - 6:00 PM) tend to be peak hours 

# this also works without having to search the number of days in the month
trips %>% 
  mutate(date = as.Date(starttime), hour = hour(starttime), num_trip = 1) %>% 
  group_by(hour) %>%
  summarize(num_days = n_distinct(date), average = round(sum(num_trip) / num_days)) %>%
  arrange(desc(average)) 
  
         
         