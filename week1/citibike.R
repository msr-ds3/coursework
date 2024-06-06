library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################
getwd()
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
trips |> mutate(across(birth_year,na_if,"\\N")) |> 
  summarise(max_birth_year = max(as.numeric(birth_year), na.rm = TRUE), min_birth_year = min (as.numeric(birth_year), na.rm = TRUE))

  # min = 1997
  # max = 1899

# use filter and grepl to find all trips that either start or end on broadway
trips |> 
    filter(grepl("Broadway",start_station_name) | grepl("Broadway", end_station_name))

# do the same, but find all trips that both start and end on broadway
trips |> 
  filter(grepl("Broadway",start_station_name) & grepl("Broadway", end_station_name))

# find all unique station names
trips |>
    distinct(start_station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
trips |> 
  group_by(gender) |> 
  mutate(tripduration_minutes = tripduration / 60) |>
  summarize(count = n(), mean_trip_time = mean(tripduration_minutes), sd_trip_time = sd(tripduration_minutes) )
  #gender   count mean_trip_time sd_trip_time
  #<fct>    <int>          <dbl>        <dbl>
  # 1 Unknown   6731          1741.        5566.
  #2 Male    176526           814.        5021.
  #3 Female   41479           991.        7115.

# do this all at once, by using summarize() with multiple arguments
    #done above

# find the 10 most frequent station-to-station trips
trips |> 
  group_by(start_station_name, end_station_name) |> 
  summarize(count =n()) |> 
  arrange(desc(count))

# find the top 3 end stations for trips starting from each start station
trips |>
  group_by(start_station_name, end_station_name) |> 
  summarize(count = n()) |> arrange(desc(count)) |>
  slice_head(n = 3)
  
# find the top 3 most common station-to-station trips by gender
trips |> 
  group_by(gender, start_station_name, end_station_name) |> 
  summarize(count = n()) |>
  arrange(desc(count)) |> 
  group_by(gender) |>
  slice_head(n=3)

# find the day with the most trips
trips |> 
  mutate(year_month_day = as.Date(starttime)) |> 
  group_by(year_month_day)|> 
  summarize( count = n()) |>
  arrange(desc(count)) |>
  slice_head(n=1)

# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips |>
  mutate(hours = hour(starttime)) |>
  group_by(hours) |> 
  summarize(average_trips = n() / n_distinct(as.Date(starttime))) |> 
  arrange(desc(average_trips))


# note ot myself
# after group_by(), any function such as summarize that will operate for each distinct group. therefore, n_distinct() provides how many days were for that particular day.
trips |> mutate(hours = hour(starttime)) |> group_by(hours) |> summarize( x = n_distinct(as.Date(starttime))) |> view()
