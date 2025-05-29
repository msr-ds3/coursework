library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('week1/201402-citibike-tripdata.csv')

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
trips |> summarize(count = n())

# find the earliest and latest birth years (see help for max and min to deal with NAs)
trips |> summarize(min_birth_year = min(as.numeric(birth_year), na.rm=T))

# use filter and grepl to find all trips that either start or end on broadway
trips_or_broadway <- trips |> filter(grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))

# do the same, but find all trips that both start and end on broadway
trips_and_broadway <- trips |> filter(grepl('Broadway', start_station_name), grepl('Broadway', end_station_name)) |> view()

# find all unique station names
stations_unique <- unique(c(select(trips, start_station_name), select(trips, end_station_name)))

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments

trips |>
    group_by(gender) |>
     summarize(num_trips = n(),
            mean_trip_length = mean(tripduration, na.rm=TRUE)/60,
            sd_trip_length = sd(tripduration, na.rm=TRUE)/60)

# find the 10 most frequent station-to-station trips
trips |> group_by(start_station_name, end_station_name) |> summarize(count = n()) |> arrange(desc(count)) |> head(10)


# find the top 3 end stations for trips starting from each start station
trips |> count(start_station_name, end_station_name) |> group_by(start_station_name) |> arrange(desc(n)) |> slice(1:3)


# find the top 3 most common station-to-station trips by gender
trips |> count(gender, start_station_name, end_station_name) |> group_by(gender) |> arrange(desc(n)) |> slice(1:3)


# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips |> select(starttime, stoptime) |> mutate(startday=floor_date(starttime, unit = "day"),
                                                 endday=floor_date(stoptime, unit = "day"))


# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
