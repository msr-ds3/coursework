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
count(trips)

# find the earliest and latest birth years (see help for max and min to deal with NAs)
trips %>% summarize(max(birth_year))
trips %>% filter(grepl('[0-9]',birth_year)) %>% summarize(min(birth_year))

# use filter and grepl to find all trips that either start or end on broadway
trips %>% filter(grepl('Broadway',start_station_name) | grepl('Broadway',end_station_name))

# do the same, but find all trips that both start and end on broadway
trips %>% filter(grepl('Broadway',start_station_name) & grepl('Broadway',end_station_name))

# find all unique station names
trips %>% select(start_station_name) %>% unique()

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
trips %>% group_by(gender) %>% summarize(n(), mean(tripduration), sd(tripduration))

# find the 10 most frequent station-to-station trips
trips %>% group_by(start_station_name, end_station_name) %>% summarize(total_trips = n()) %>% arrange(desc(total_trips)) %>% head(10) 

# find the top 3 end stations for trips starting from each start station
trips %>% group_by(start_station_id, end_station_id) %>% summarize(total_trips = n()) %>% filter(rank(desc(total_trips)) <= 3) %>% arrange(start_station_name, desc(total_trips))

# find the top 3 most common station-to-station trips by gender
group_by(trips, gender, start_station_id, end_station_id) %>% summarize(count = n()) %>% arrange(desc(count)) %>% group_by(gender) %>% top_n(n=3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips%>% mutate(date = as.Date(starttime))%>% group_by(date)%>% summarise(count=n()) %>% arrange(desc(count) )%>% head(1)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips %>% mutate(date = as.Date(starttime), hour = hour(starttime)) %>% group