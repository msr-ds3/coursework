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

# count the number of trips (= rows in the data frame) 224736, summarize(trips, count = n()) 

# find the earliest and latest birth years (see help for max and min to deal with NAs) 1997  as.numeric(trips$birth_year) then get min(birth_year na.rm=TRUE) 1899 

# use filter and grepl to find all trips that either start or end on broadway filter(trips, grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))

# do the same, but find all trips that both start and end on broadway filter(trips, grepl('Broadway', start_station_name) , grepl('Broadway', end_station_name))

# find all unique station names trips |> distinct(start_station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments 
#gender   count avg_trip_time sd_trip_time
 # <fct>    <int>         <dbl>        <dbl>
#1 Unknown   6731         1741.        5566.
#2 Male    176526          814.        5021.
#3 Female   41479          991.        7115.

# find the 10 most frequent station-to-station trips View(trips |> group_by(start_station_name, end_station_name) |> summarize(count = n()) |> arrange(desc(count) |> head(n=10))

# find the top 3 end stations for trips starting from each start station view( trips |> group_by(start_station_name, end_station_name) |> summarize(count = n()) |> group_by(start_station_name) |> arrange(desc(count)) |> mutate(rank = row_number()) |> filter(rank <=3))

# find the top 3 most common station-to-station trips by gender view(trips |> group_by(start_station_name, end_station_name, gender) |> summarize(count = n()) |> arrange(desc(count))|> group_by(gender) |> mutate(rank = row_number()) |> filter(rank <=3) |> arrange(gender))

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package) trips_date <- trips |> mutate(date = as.Date(trips$starttime, "%m/%d/%y"))
#view( trips_date |> group_by(date) |> summarize(count = n()) |> arrange(desc(count)) |> head(n=1) )


# compute the average number of trips taken during each of the 24 hours of the day across the entire month
trips_hours <- trips |> mutate(hour = hour(trips$starttime))
view( trips_hours |> group_by(hour) |> summarize(count=n(), mean=count/28)) #you could also do days_in_month(trips$starttime) or something for each month
# what time(s) of day tend to be peak hour(s)?
trips_hours <- trips |> mutate(hour = hour(trips$starttime))
view(trips_hours)
view( trips_hours |> group_by(hour) |> summarize(count=n()) |> arrange(desc(count)))

