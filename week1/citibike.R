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

# find the earliest and latest birth years (see help for max and min to deal with NAs)
min(as.numeric(trips$birth_year)[!is.na(as.numeric(trips$birth_year))])
max(as.numeric(trips$birth_year)[!is.na(as.numeric(trips$birth_year))])

# use filter and grepl to find all trips that either start or end on broadway
filter(trips, grepl("Broadway", trips$start_station_name) | grepl("Broadway", trips$end_station_name))

# do the same, but find all trips that both start and end on broadway
filter(trips, grepl("Broadway", trips$start_station_name) & grepl("Broadway", trips$end_station_name))

# find all unique station names
unique(c(trips$start_station_name,trips$end_station_name))

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
summarise(group_by(trips, gender), count = n(), avg_trip_time = mean(tripduration)/60, sd_duration = sd(tripduration)/60)

# find the 10 most frequent station-to-station trips
trips <- mutate(trips, routes = paste(trips$start_station_name,trips$end_station_name, sep = " -- "))
trips %>%
  group_by(routes) %>%
  summarize(count=n()) %>%
  arrange(desc(count))

# find the top 3 end stations for trips starting from each start station
trips %>%
  group_by(start_station_name,end_station_name) %>%
  summarize(count=n()) %>%
  top_n(3) %>%
  arrange(desc(count))

# find the top 3 most common station-to-station trips by gender
trips %>%
  group_by(gender, routes) %>%
  summarize(count=n()) %>%
  top_n(3) %>%
  arrange(desc(count)) %>%
  arrange(gender)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips <- mutate(trips, day_date = as.Date(trips$starttime))
trips %>%
  group_by(day_date) %>%
  summarize(count=n()) %>%
  arrange(desc(count)) %>%
  top_n(1)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips <- mutate(trips, hours =hour(trips$starttime))
trips %>%
  group_by(hours) %>%
  summarize(count=n()/28) %>%
  arrange(desc(count)) %>%
  print(n = 24)
