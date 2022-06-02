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
summarize(trips, count=n())

# find the earliest and latest birth years (see help for max and min to deal with NAs)
trips %>% 
  filter(birth_year != "\\N") %>%
  summarize(earliest = min(birth_year),
            latest = max(birth_year))

# use filter and grepl to find all trips that either start or end on broadway
filter(trips, grepl('Broadway', trips$start_station_name) | grepl('Broadway', trips$end_station_name)) 

# do the same, but find all trips that both start and end on broadway
filter(trips, grepl('Broadway', trips$start_station_name) & grepl('Broadway', trips$end_station_name)) 

# find all unique station names
unique(trips$start_station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
summarize(group_by(trips, gender), count = n(), mean_trip_time = mean(tripduration), SD_trip_time = sd(tripduration))

# find the 10 most frequent station-to-station trips
trips %>% 
  group_by(start_station_name, end_station_name) %>%
  summarize(count = n()) %>%
  arrange(count) %>% 
  tail(10)

# find the top 3 end stations for trips starting from each start station
trips %>%
  group_by(start_station_name, end_station_name) %>%
  summarize(count = n()) %>%
  group_by(start_station_name) %>%
  arrange(desc(count)) %>% 
  slice(1:3)

# find the top 3 most common station-to-station trips by gender
trips %>% 
  group_by(gender, start_station_name, end_station_name) %>%
  summarize(count = n()) %>% 
  group_by(gender) %>%
  arrange(desc(count)) %>% 
  slice(1:3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)


trips %>% 
  mutate(Date = substring(starttime, 1, 10)) %>% 
  group_by(Date) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count)) %>%
  head(1)
  

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?

trips %>% 
  mutate(Date = substring(starttime, 1, 10)) %>% 
  mutate(hour = substring(starttime, 12, 13)) %>%
  group_by(hour) %>% 
  summarize(count = n()) %>%
  arrange(desc(count)) %>% 
  View


trips %>% 
  mutate(Date = substring(starttime, 1, 10)) %>% 
  mutate(hour = substring(starttime, 12, 13)) %>%
  group_by(Date) %>% 
  summarize(count = n()) %>% 
  mutate(Avg_trip_per_hr = count/24) 
