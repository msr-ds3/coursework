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
  trips %>% 

# count the number of trips (= rows in the data frame)
  nrow()

# find the earliest and latest birth years (see help for max and min to deal with NAs)
  trips %>% 
   mutate(birth_year = na_if(birth_year, "\\N")) %>% 
   summarize(latest=max(birth_year, na.rm=T), earliest=min(birth_year, na.rm = TRUE))

# use filter and grepl to find all trips that either start or end on Broadway
  
  trips %>% filter(grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))

# do the same, but find all trips that both start and end on Broadway
  trips %>% filter(grepl('Broadway', start_station_name) & grepl('Broadway', end_station_name))
  
# find all unique station names
  trips %>% distinct(start_station_name)
  
# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with arguments  
  trips %>% 
   group_by(gender) %>% summarize(count = n(),
                                  average_trip_by_gender = mean(tripduration),
                                  sd_trip_by_gender = sd(tripduration))

# find the 10 most frequent station-to-station trips
  trips %>% 
  group_by(start_station_name,end_station_name) %>% summarize(count=n()) %>% arrange(count) %>% tail(10) 
  
  
# find the top 3 end stations for trips starting from each start station
  trips %>% 
  group_by(start_station_name,end_station_name) %>% summarize(count=n()) %>% arrange(start_station_name, desc(count)) %>% slice_head(n = 3)
  
# find the top 3 most common station-to-station trips by gender
  trips %>% 
  group_by(gender, start_station_name, end_station_name) %>% summ
  arize(count=n()) %>% arrange(gender, desc(count)) %>% group_by(gender) %>% slice_head(n=3) %>% view
  
# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
  trips %>% 
    group_by(as_date(starttime), as_date(stoptime)) %>% summarize(count=n()) %>% arrange(count) %>% tail(1)
  
# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
  trips %>% 
    mutate(hour = hour(starttime), date=as_date(starttime)) %>% group_by(hour, date) %>% summarize(count=n()) %>% summarize(average_per_hour =mean(count))

  trips %>% 
    mutate(hour = hour(starttime), date=as_date(starttime)) %>% group_by(hour, date) %>% summarize(count=n()) %>% summarize(average_per_hour =mean(count)) %>%  arrange(desc(average_per_hour)) %>%  head(1)
                    