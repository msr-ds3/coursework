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
#reference https://www.datasciencemadesimple.com/get-maximum-value-of-a-column-in-r-2/
#https://stackoverflow.com/questions/652136/how-can-i-remove-an-element-from-a-list
max(trips$birth_year)
trips$birth_year[trips$birth_year != "\\N"] %>% min()
# use filter and grepl to find all trips that either start or end on broadway
#source https://stackoverflow.com/questions/34914173/using-grepl-to-extract-a-value-from-text-across-multiple-columns
filter(trips, grepl('.*Broadway.*', start_station_name) | grepl('.*Broadway.*', end_station_name))
# do the same, but find all trips that both start and end on broadway
filter(trips, grepl('.*Broadway.*', start_station_name) & grepl('.*Broadway.*', end_station_name))
# find all unique station names
# reference  https://www.r-bloggers.com/2021/12/how-to-find-unique-values-in-r/#:~:text=To%20find%20unique%20values%20in%20a%20column%20in%20a%20data,duplicate%20values%20in%20the%20data.
unique(trips$start_station_name)
# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
group_by(trips, gender) %>%
 summarize(count = n(), avg_trip_time = mean(tripduration), std_dev = sd(tripduration))
# find the 10 most frequent station-to-station trips
#reference https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/arrange
# https://www.tutorialspoint.com/find-the-count-of-unique-group-combinations-in-an-r-data-frame
count(trips, start_station_name, end_station_name) %>%
 arrange(desc(n)) %>%
 head(10)
# find the top 3 end stations for trips starting from each start station
# https://www.statology.org/dplyr-slice/
count(trips, start_station_name, end_station_name) %>%
 group_by(start_station_name) %>%
  arrange(start_station_name, desc(n)) %>%
   slice(1:3)

# find the top 3 most common station-to-station trips by gender
group_by(trips, gender) %>%
 count(start_station_name, end_station_name) %>%
  arrange(gender, desc(n))
   %>% slice(1:3)
# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
mutate(trips, date_self = substr(trips$starttime, 1, 10)) %>%
 group_by(date_self) %>%
 count() %>%
 arrange(desc(n)) %>%
 head(1)
# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
mutate(trips, hour_self = substr(trips$starttime, 12, 13)) %>% 
group_by(hour_self) %>% 
summarize(avg = mean(n())) %>% 
arrange(desc(avg))
