library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('./week1/201402-citibike-tripdata.csv')
trips

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
max(as.numeric(trips$birth_year), na.rm=TRUE)
min(as.numeric(trips$birth_year), na.rm=TRUE)
#min(as.numeric(trips[, "birth_year"]), na.rm=TRUE)


# use filter and grepl to find all trips that either start or end on broadway
nrow(filter(trips, grepl(".*Broadway.*", start_station_name) | grepl(".*Broadway.*", end_station_name)) )

# do the same, but find all trips that both start and end on broadway
nrow(filter(trips, grepl(".*Broadway.*", start_station_name) & grepl(".*Broadway.*", end_station_name)) )

# find all unique station names
union(trips$start_station_name, trips$end_station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
summarize(group_by(trips, gender), number_of_trips = n() , average_trip_time = mean(tripduration) / 60, sd_trip_time = sd(tripduration) /60)


# find the 10 most frequent station-to-station trips
group_by(trips, start_station_name, end_station_name) |>
    summarize(num_trips = n()) |>
    arrange(desc(num_trips)) |>
    head(10)



# find the top 3 end stations for trips starting from each start station
trips |>
    count(start_station_name, end_station_name) |>
    group_by(start_station_name) |>
    arrange(desc(n)) |>
    slice(1:3)

# find the top 3 most common station-to-station trips by gender

trips |>
    select(start_station_name, end_station_name, gender) |>
    count(start_station_name, end_station_name, gender) |>
    group_by(gender) |>
    arrange(desc(n)) |>
    slice(1:3)





# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips |>
    mutate(start_date_only = as.Date(starttime)) |>
    count(start_date_only) |>
    arrange(desc(n)) |>
    slice(1:1)


# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?

trips |>
    mutate(date_only = as.Date(starttime), hour_only = format(trips$starttime, "%H")) |>
    select(date_only, hour_only) |>
    group_by(hour_only) |>
    summarise(count_avg = n()/28) |>
    arrange(desc(count_avg))
