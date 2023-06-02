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
summarize(trips, n())

# find the earliest and latest birth years (see help for max and min to deal with NAs)
summarize(trips, max(birth_year, na.rm = TRUE))
summarize(filter(trips, birth_year != "\\N"), min(birth_year, na.rm = TRUE))

# use filter and grepl to find all trips that either start or end on broadway
trips_on_broadway <- trips %>%
  filter(grepl("Broadway", start_station_name) | grepl("Broadway", start_station_name))

# do the same, but find all trips that both start and end on broadway
strict_trips_on_broadway <- trips %>%
  filter(grepl("Broadway", start_station_name) & grepl("Broadway", start_station_name))

# find all unique station names
unique(c(trips$start_station_name, trips$end_station_name))
  
# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
trips %>% 
  group_by(gender) %>%
  summarize(count = n(),
            mean_duration_by_min = mean(tripduration) / 60,
            sd_duration_by_min = sd(tripduration) / 60)


# do this all at once, by using summarize() with multiple arguments
summarize(group_by(trips, gender), average_trip_time_by_gender = mean(tripduration), trip_time_sd = sd(trips$tripduration), count = n())

# find the 10 most frequent station-to-station trips
trips %>%
  group_by(start_station_name, end_station_name)%>%
  summarize(count = n())%>%
  arrange(desc(count)) %>%
  head(10)

# find the top 3 end stations for trips starting from each start station
trips %>%
  group_by(end_station_name, start_station_name) %>%
  summarize(count = n()) %>%
  arrange(desc(count)) %>%
  head(3)

# find the top 3 most common station-to-station trips by gender
trips %>%
  group_by(gender, start_station_name, end_station_name) %>%
  summarize(count = n())%>%
  arrange(desc(count))%>%
  group_by(gender) %>%
  slice_head(n=3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>%
  mutate(date = as.Date(starttime)) %>%
  group_by(date) %>%
  summarize(trips_count = n()) %>%
  arrange(desc(trips_count)) %>%
  head(1)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?

trips %>%
  mutate(date = as.Date(starttime)) %>%
  group_by(hour = hour(starttime)) %>%
  summarize(avg_trips = mean(n()))