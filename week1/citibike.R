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
# ans: 224736

# find the earliest and latest birth years (see help for max and min to deal with NAs)

# earliest birth year
trips %>% 
    select(birth_year) %>% 
    arrange(birth_year) %>% 
    filter(grepl("[0-9]", birth_year)) %>% 
    head(n=1)
# ans: 1899

trips %>% 
    select(birth_year) %>% 
    arrange(desc(birth_year)) %>% 
    filter(grepl("[0-9]", birth_year)) %>% 
    head(n=1)
# ans: 1997

# use filter and grepl to find all trips that either start or end on broadway
filter(trips, grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))

# do the same, but find all trips that both start and end on broadway
filter(trips, grepl('Broadway', start_station_name) & grepl('Broadway', end_station_name))

# find all unique station names
unique(select(trips, start_station_name))

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
trips %>%
    group_by(gender) %>%
    summarize(trips_by_gender=n())

trips %>%
    group_by(gender) %>%
    summarize(avg_trip_time_by_gender=mean(tripduration))

trips %>%
    group_by(gender) %>%
    summarize(sd_trip_time_by_gender=sd(tripduration))

# do this all at once, by using summarize() with multiple arguments
trips %>%
    group_by(gender) %>%
    summarize(
        trips_by_gender=n(),
        avg_trip_time_by_gender=mean(tripduration),
        sd_trip_time_by_gender=sd(tripduration)
    )

# find the 10 most frequent station-to-station trips
trips %>%
    group_by(start_station_name, end_station_name) %>%
    summarize(frequency=n()) %>%
    arrange(desc(frequency)) %>%
    head(n=10) %>%
    select(start_station_name, end_station_name, frequency) 

# find the top 3 end stations for trips starting from each start station
trips %>%
    group_by(start_station_name, end_station_name) %>%
    summarize(frequency=n()) %>%
    arrange(start_station_name, desc(frequency)) %>%
    mutate(rank=row_number()) %>%
    filter(rank<=3)

# find the top 3 most common station-to-station trips by gender
trips %>%
    group_by(gender, start_station_name, end_station_name) %>%
    summarize(frequency=n()) %>%
    group_by(gender) %>%
    arrange(gender, desc(frequency)) %>%
    mutate(rank=row_number()) %>%
    filter(rank<=3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>%
    mutate(date=as.Date(starttime)) %>%
    group_by(date) %>%
    summarize(frequency = n()) %>%
    filter(frequency == max(frequency))
    

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
trips %>%
   mutate(hour=hour(starttime)) %>%
   group_by(hour) %>%
   summarize(frequency=n(), num_dates=n_distinct(as.Date(starttime))) %>%
   mutate(avg_frequency=frequency/num_dates) %>%
   print(n = 24)

# what time(s) of day tend to be peak hour(s)?
# Peak hours are around 4pm-6pm
trips %>%
   mutate(hour=hour(starttime)) %>%
   group_by(hour) %>%
   summarize(frequency=n(), num_dates=n_distinct(as.Date(starttime))) %>%
   mutate(avg_frequency=frequency/num_dates) %>%
   arrange(desc(avg_frequency)) %>%
   head(n=3)