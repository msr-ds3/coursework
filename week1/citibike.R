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
summarize(trips, number_of_trips = n())

# find the earliest and latest birth years (see help for max and min to deal with NAs)
#  birth_year_list <- select(trips, birth_year)
summarize(trips, max_birth_year = max(birth_year, na.rm = TRUE))
summarize(filter(trips, birth_year != "\\N"), min_birth_year = min(birth_year, na.rm = TRUE))

# use filter and grepl to find all trips that either start or end on broadway
broadway_start_or_end <- filter(trips, grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))
view(broadway_start_or_end)

# do the same, but find all trips that both start and end on broadway
broadway_start_and_end <- filter(trips, grepl('Broadway', start_station_name) & grepl('Broadway', end_station_name))
view(broadway_start_and_end)

# find all unique station names
unique(c(trips$start_station_name, trips$end_station_name))


# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
summarize(group_by(trips, gender), count = n(), avg_duration = mean(tripduration), sd_duration = sd(tripduration))

# find the 10 most frequent station-to-station trips
head(arrange(summarize(group_by(trips, start_station_name, end_station_name), count = n()), desc(count)), 10)


# find the top 3 end stations for trips starting from each start station
trips %>% count(end_station_name) %>% arrange(desc(n))%>% head(3)

# find the top 3 most common station-to-station trips by gender
trips %>% group_by(gender) %>% count(start_station_name, end_station_name) %>% arrange(gender, desc(n)) %>% top_n(3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>% mutate(date = as.Date(starttime)) %>% count(date) %>% arrange(n) %>% slice_tail()

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
trips %>% mutate(hour = format(starttime, format = "%H")) %>% add_count(hour, name = "trips_by_hour") %>% summarize(mean_trips_by_hour = mean(trips_by_hour))

# what time(s) of day tend to be peak hour(s)?
trips %>% mutate(hour = format(starttime, format = "%H")) %>% count(hour) %>% arrange(desc(n)) %>% head()

