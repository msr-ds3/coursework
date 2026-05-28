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

# 1. count the number of trips (= rows in the data frame)
nrow(trips)
#Answer: 224736

# 2. find the earliest and latest birth years (see help for max and min to deal with NAs)
select(trips, birth_year) %>% 
    mutate(birth_year = na_if(birth_year, '\\N')) %>%
    summarize(min_birth_year = min(birth_year, na.rm = TRUE), max_birth_year = max(birth_year, na.rm = TRUE))

# 3. use filter and grepl to find all trips that either start or end on broadway
filter(trips, grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name)) 

# 4. do the same, but find all trips that both start and end on broadway
filter(trips, grepl('Broadway', start_station_name) & grepl('Broadway', end_station_name))

# 5. find all unique station names
unique(select(trips, end_station_name))

# 6. count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
trips %>%
    group_by(gender) %>%
    summarize(count = n(),
            mean_trip_duration = mean(tripduration),
            sd_trip_duration = sd(tripduration))

# 7. find the 10 most frequent station-to-station trips
trips %>% 
    select(start_station_name, end_station_name) %>% 
    group_by(start_station_name, end_station_name) %>%
    summarize(count = n()) %>%
    arrange(desc(count)) %>%
    head(n=10) %>%
    select(start_station_name, end_station_name)

# 8. find the top 3 end stations for trips starting from each start station
trips %>%
    group_by(start_station_name, end_station_name) %>%
    summarize(count = n()) %>%
    arrange(desc(count)) %>%
    slice(1:3) %>%
    select(start_station_name, end_station_name)

# 9. find the top 3 most common station-to-station trips by gender
trips %>%
    select(gender, start_station_name, end_station_name) %>%
    group_by(start_station_name, end_station_name, gender) %>%
    summarize(count = n()) %>%
    arrange(desc(count)) %>%
    group_by(gender) %>%
    slice(1:3) %>%
    select(start_station_name, end_station_name, gender)

# 10. find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>%
    mutate(day=floor_date(starttime, "day")) %>% 
    group_by(day) %>%
    summarize(count=n()) %>%
    arrange(desc(count)) %>%
    head(n=1) %>%
    select(day)

# 11. compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips %>%
    mutate(day_hour=hour(starttime)) %>% 
    group_by(day_hour) %>%
    select(day_hour) %>%
    summarize(count=n()) %>%
    group_by(day_hour, count) %>%
    summarize(mean_number_trips=mean(count)/28) %>%
    select(day_hour, mean_number_trips) %>%
    arrange(desc(mean_number_trips))