library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('./week1/201402-citibike-tripdata.csv')

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
print(nrow(trips))


# find the earliest and latest birth years (see help for max and min to deal with NAs)
 birth_year_col <- as.numeric(birth_year_col)
 birth_year_col <- na.omit(birth_year_col)
 min(birth_year_col)
 max(birth_year_col)

# use filter and grepl to find all trips that either start or end on broadway
filter(trips, grepl("Broadway", start_station_name) | grepl("Broadway", end_station_name))

# do the same, but find all trips that both start and end on broadway
filter(trips, grepl("Broadway", start_station_name) & grepl("Broadway", end_station_name))

# find all unique station names

 stations <- paste(trips$start_station_name, trips$end_station_name)
 unique_stations <- unique(stations)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments

trips %>% group_by(gender) %>% summarize(count =n(), mean = mean(tripduration), std = sd(tripduration))


# find the 10 most frequent station-to-station trips
trips %>% 
group_by(start_station_name, end_station_name) 
%>% summarize(frequency = n()) %>% arrange(desc(frequency)) %>% slice_head(n = 10)

# find the top 3 end stations for trips starting from each start station
 trips %>% group_by(start_station_name, end_station_name) %>% summarize(count = n()) %>% group_by(start_station_name) %>%  arrange(desc(count)) %>% slice_head(n=3)
# find the top 3 most common station-to-station trips by gender
trips %>% group_by(start_station_name, end_station_name) %>% 
group_by(gender) %>% summarize(frequency = n()) %>% arrange(desc(frequency)) %>%
 slice_head(n =3)
# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)

trips %>% group_by(as.Date(starttime)) %>% summarize(frequency = n()) %>% ar$
slice_head(n =1)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?

trips %>% mutate( hours = hour(starttime)) %>% 
    group_by(hours) %>% summarise(count = n(), day_in_month_count = days_in_month(starttime), avg = count /  day_in_month_count)

trips %>% mutate( hours = hour(starttime)) %>% 
    group_by(hours) %>% summarise(count = n()) %>%  arrange(desc(count)) %>% slice(1)
