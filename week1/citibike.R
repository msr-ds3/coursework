library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('coursework/week1/201402-citibike-tripdata.csv')

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
trips |> 
    summarize(num_trips=n())

# find the earliest and latest birth years (see help for max and min to deal with NAs)
trips |> 
    filter(birth_year != "\\N") |> 
    summarize(earliest_birth_year=min(birth_year, na.rm=F), latest_birth_year=max(birth_year))

# use filter and grepl to find all trips that either start or end on broadway
trips |> 
    filter(grepl("Broadway", start_station_name) | grepl("Broadway", end_station_name))

# do the same, but find all trips that both start and end on broadway
trips |> 
    filter(grepl("Broadway", start_station_name), grepl("Broadway", end_station_name))

# find all unique station names
#trips |> 
#   reframe(unique_stations=unique(start_station_name))
trips |> 
    gather("trip_type", "station_name", start_station_name, end_station_name) |>
    group_by(station_name) |> 
    filter(row_number() == 1) |> 
    select(station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
trips |> 
    group_by(gender) |> 
    summarize(num_trips=n(), average_trip_time=mean(tripduration) / 60, 
            trip_standard_deviation=sd(tripduration) / 60)

# find the 10 most frequent station-to-station trips
trips |> 
    group_by(start_station_name, end_station_name) |>
    summarize(num_stations=n()) |>
    arrange(desc(num_stations)) |>
    head(10)

# find the top 3 end stations for trips starting from each start station
trips |> 
    group_by(start_station_name, end_station_name) |>
    summarize(num_stations=n()) |>
    group_by(start_station_name) |>
    arrange(start_station_name, desc(num_stations)) |>
    filter(row_number() <= 3)
  
# find the top 3 most common station-to-station trips by gender
trips |> 
    group_by(start_station_name, end_station_name, gender) |>
    summarize(num_trips=n()) |>
    group_by(gender) |>
    arrange(gender, desc(num_trips)) |>
    filter(row_number() <= 3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips |> 
    mutate(trip_date=as.Date(starttime, format="%Y-%m-%d")) |> 
    group_by(trip_date) |>
    summarize(num_trips=n()) |>
    arrange(desc(num_trips)) |>
    head(1)
  

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips |>
    mutate(trip_hour=format(starttime, format="%H"), 
           trip_date=as.Date(starttime, format="%Y-%m-%d")) |> 
    group_by(trip_hour, trip_date) |>
    summarize(num_trips=n()) |>
    group_by(trip_hour) |>
    summarize(mean_num_trips=mean(num_trips)) |>
    arrange(desc(mean_num_trips))
    
trips |>
    gather("type", "time", starttime, stoptime) |>
    mutate(rider_change=ifelse(type=="starttime", 1, -1)) |>
    arrange(time) |>
    mutate(rider_total=cumsum(rider_change)) |>
    arrange(desc(rider_total)) |>
    slice_head(n=1)
