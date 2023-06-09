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
trips_birthyear <- select(trips,birth_year)
View(trips_birthyear)
trips_birthyear_filter_n <- filter(trips_birthyear, birth_year !="\\N")
summarise(trips_birthyear_filter_n, max_birthyear = max(birth_year)) #Latest birth year
summarise(trips_birthyear_filter_n,min_birthyear = min(birth_year)) # Earliest Birth year

# use filter and grepl to find all trips that either start or end on broadway

trips_start_end_broadway <- filter(trips,grepl("Broadway",start_station_name)|grepl("Broadway",end_station_name))
View(trips_start_end_broadway)

# do the same, but find all trips that both start and end on broadway
trips_start_end_broadway_two <- filter(trips,grepl("Broadway",start_station_name) & grepl("Broadway",end_station_name))
View(trips_start_end_broadway_two)

# find all unique station names


trips_station <- c(trips$start_station_name, trips$end_station_name)
uniq_station_name <-unique(trips_station)
View(uniq_station_name)


# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments

trips_number_byGender <- trips %>% group_by(gender) %>% summarise(count= n(), average_tripTime = mean(tripduration),sd_tripTime = sd(tripduration))
View(trips_number_byGender)


# find the 10 most frequent station-to-station trips
trips_stationTostation <- paste(trips$start_station_name,trips$end_station_name, sep = " TO ")
View(trips_stationTostation)
trips_stationTostation_frequency <- table(trips_stationTostation)
View(trips_stationTostation_frequency)
trips_stationTostation_frequency_top10 <-head(sort(trips_stationTostation_frequency, decreasing = TRUE),10)
View(trips_stationTostation_frequency_top10)

# find the top 3 end stations for trips starting from each start station
top_3_endStation_eachStartStation <- trips %>% 
  group_by(start_station_name) %>%
  count(end_station_name) %>%
  arrange(start_station_name, desc(n)) %>%
  group_by(start_station_name) %>%
  top_n(3)
View(top_3_endStation_eachStartStation)

# find the top 3 most common station-to-station trips by gender
trips_gender_stations <- select(trips,gender,start_station_name,end_station_name)
common3_trips_gender <- mutate(trips_gender_stations, station_to_station = paste(trips$start_station_name,trips$end_station_name, sep = " TO ")) %>%
  group_by(gender) %>%
  count(station_to_station) %>%
  arrange(gender,desc(n)) %>%
  group_by(gender) %>%
  top_n(3)
View(common3_trips_gender)
  
# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips_starttime_withDays <- select(trips, starttime) %>%
mutate(trips_starttime_withDays, startDay = floor_date(starttime,"day"))
View(trips_starttime_withDays)
trips_Day_with_most_trips <- trips_starttime_withDays %>% count(startDay) %>%
  arrange(desc(n)) %>%
  top_n(1)
View(trips_Day_with_most_trips)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
trips_averageTrips_hour <- trips_starttime_withDays %>%
 mutate( hour = hour(starttime)) %>% 
  count(hour) %>%
  mutate (averageTrips_hour = mean(n))
View(trips_averageTrips_hour)

# what time(s) of day tend to be peak hour(s)?
trips_peak_hours <- trips_starttime_withDays %>%
  mutate( hour = hour(starttime)) %>% 
  count(hour) %>% arrange(desc(n)) %>%
  top_n(5)
View(trips_peak_hours)
