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
nrow(trips)
count(trips)
summarize(trips, num_trips = n())

# find the earliest and latest birth years (see help for max and min to deal with NAs)
summarize(filter(trips, grepl('[0-9]', birth_year)), min_birth_year = min(birth_year))
summarize(trips, max_birth_year = max(birth_year))

# use filter and grepl to find all trips that either start or end on broadway
filter(trips, grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))

# do the same, but find all trips that both start and end on broadway
filter(trips, grepl('Broadway', start_station_name) & grepl('Broadway', end_station_name))

# find all unique station names
# Find all unique station names
unique(c(trips$start_station_name, trips$end_station_name))

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
trips %>% 
  group_by(gender) %>% 
  summarize(trips_by_gender = n(), 
            avg_trip_time_by_gender = mean(tripduration), 
            std_trip_time_by_gender = sd(tripduration))

# find the 10 most frequent station-to-station trips
trips %>% 
  count(start_station_name, end_station_name) %>%
  arrange(desc(n)) %>%
  head(10) 

# find the top 3 end stations for trips starting from each start station
trips %>%
  group_by(start_station_name) %>%
  count(end_station_name) %>%
  arrange(start_station_name, desc(n)) %>%
  group_by(start_station_name) %>%
  top_n(3)

# find the top 3 most common station-to-station trips by gender
trips %>%
  group_by(gender) %>%
  count(start_station_name = end_station_name) %>%
  arrange(gender, desc(n)) %>%
  group_by(gender) %>%
  top_n(3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>%
  mutate(date = as.Date(starttime)) %>%
  count(date) %>%
  arrange(desc(n)) %>%
  top_n(1)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
average_trips_by_hour <- trips %>%
  mutate(hour = hour(starttime)) %>%
  count(hour) %>%
  mutate(avg_trips_by_hour = mean(n))

# what time(s) of day tend to be peak hour(s)?
peak_hours <- average_trips_by_hour %>%
  filter(n == max(n))
