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

trips %>%
  nrow()

# find the earliest and latest birth years (see help for max and min to deal with NAs)

trips %>% 
  mutate(birth_year = as.numeric(birth_year)) %>%
  summarize(earliest_birth_year = min(birth_year, na.rm = TRUE), latest_birth_year = max(birth_year, na.rm = TRUE)) %>%
  View

# use filter and grepl to find all trips that either start or end on broadway

trips %>%
  filter(grepl('Broadway & .*', start_station_name) | grepl('.* & Broadway', end_station_name)) %>%
  View

# do the same, but find all trips that both start and end on broadway

trips %>%
  filter(grepl('Broadway & .*', start_station_name) & grepl('.* & Broadway', end_station_name)) %>%
  View

# find all unique station names

trips %>%
  distinct(start_station_name) %>%
  View

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments

trips %>%
  group_by(gender) %>%
  summarize(number_of_trips = n(), average_trip_time = mean(tripduration), standard_deviation = sd(tripduration)) %>%
  View

# find the 10 most frequent station-to-station trips

trips %>%
  group_by(start_station_name, end_station_name) %>%
  summarize(count = n()) %>%
  arrange(desc(count)) %>%
  head(10) %>%
  View

# find the top 3 end stations for trips starting from each start station

trips %>%
  group_by(start_station_name, end_station_name) %>%
  summarize(count = n()) %>%
  arrange(start_station_name, desc(count)) %>%
  top_n(n = 3) %>%
  View

# find the top 3 most common station-to-station trips by gender

trips %>%
  group_by(start_station_name, end_station_name, gender) %>%
  summarize(count = n()) %>%
  arrange(gender, desc(count)) %>%
  group_by(gender) %>%
  top_n(n = 3) %>%
  View

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)

trips %>%
  mutate(only_date = as.Date(starttime)) %>%
  group_by(only_date) %>%
  summarize(count = n()) %>%
  arrange(desc(count)) %>%
  head(1) %>%
  View

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?

trips %>%
  mutate(date = as.Date(starttime), hour_of_the_day = hour(starttime)) %>%
  group_by(date, hour_of_the_day) %>%
  summarize(count = n()) %>%
  group_by(hour_of_the_day) %>%
  summarize(average_trips = mean(count)) %>%
  arrange(desc(average_trips)) %>%
  head(1) %>%
  View


