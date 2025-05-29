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
summarize(trips, count=n())

# find the earliest and latest birth years (see help for max and min to deal with NAs)
trips <- read_csv('201402-citibike-tripdata.csv', na = c("", "\\N")) # clean up \N to NAs
# can also typecast it to numeric where it will coerce the NAs

summarize(trips, min_year = min(birth_year, na.rm = TRUE), max_year = max(birth_year, na.rm = TRUE))


# use filter and grepl to find all trips that either start or end on broadway
select(trips, start_station_name, end_station_name) |> 
    filter(grepl('.*Broadway.*', start_station_name) | 
    grepl('.*Broadway.*', end_station_name))

# do the same, but find all trips that both start and end on broadway
select(trips, start_station_name, end_station_name) |> 
    filter(grepl('.*Broadway.*', start_station_name) &
    grepl('.*Broadway.*', end_station_name))

# find all unique station names
trips |> distinct(start_station_name)
# old school way
unique(trips$start_station_name)   

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
trips |> group_by(gender) |>  
    summarize( count = n(), average_duration = mean(tripduration) /60, 
    sd_duration = sd(tripduration)/60)

# find the 10 most frequent station-to-station trips
trips %>%  count(start_station_name, end_station_name, sort = TRUE) |> head(10)
    |> select(start_station_name, end_station_name)

# find the top 3 end stations for trips starting from each start station
trips |> group_by(start_station_name) |> count(end_station_name, sort = TRUE) |> slice_max(n, n = 3)


# find the top 3 most common station-to-station trips by gender
trips |> group_by(gender) |> count(end_station_name, sort = TRUE) |> slice_max(n, n = 3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips |> mutate(date = as.Date(starttime)) |> count(date, sort =TRUE) |> head(1) |> select(date)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
date_hour_counts <- trips |> mutate(hour = hour(starttime), date = as.Date(starttime)) |>  group_by(date, hour)  |> count(date, hour)
avg_rides_per_hour <- date_hour_counts |> group_by(hour) |> summarize(avg = mean(n)) #--> avgerage rides per hour

# peak hour --> 17th hour
avg_rides_per_hour |> arrange(avg) |> tail(1)
