library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data


########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
 summarize(trips, count = n())

# find the earliest and latest birth years (see help for max and min to deal with NAs)
max(trips$birth_year, na.rm = FALSE)
#had issue with min that data model was not formatted with NA, instead it was \\N so figured out how to change it to NA so min could work   
#my partner had a better solution as.numeric(trips$birthyear) which will automatically cast all non numerics as NA so the following is silly and overdramatic and pointless                                    
trips <-  
    mutate(trips, birth_year
    = if_else(!str_detect(birth_year, 
    "^[0-9]+$"), "NA", birth_year))
min(trips$birth_year, na.rm = FALSE)

# use filter and grepl to find all trips that either start or end on broadway
filter(trips, grepl("Broadway", start_station_name)| grepl("Broadway", end_station_name))

# do the same, but find all trips that both start and end on broadway
filter(trips, grepl("Broadway", start_station_name) & grepl("Broadway", end_station_name))

# find all unique station names
trips |> distinct(start_station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
summarize(group_by(trips, gender), 
    count = n(), mean = mean(tripduration), 
    sd = sd(tripduration))

# find the 10 most frequent station-to-station trips
trips |> group_by(start_station_name, end_station_name) |>
     summarize(count = n()) |>
      arrange(desc(count)) |>
       head(n=10)

# find the top 3 end stations for trips starting from each start station
trips |> group_by(start_station_name, end_station_name) |>
    summarize(count = n()) |>
    group_by(start_station_name) |>
    arrange(desc(count)) |>
    mutate(rank = row_number()) |>
    filter(rank <=  3) |>
    arrange(start_station_name)
#Jake's solution: trips |> 
    #count(start_station_name, end_station_name) |>
    #group_by(start_station_name) |>
    #arrange(desc(n)) |>
    #slice(1:3)
    


# find the top 3 most common station-to-station trips by gender
trips |> group_by(start_station_name, end_station_name, gender) |>
     summarize(count = n()) |>
     arrange(desc(count))|>
     group_by(gender) |>
     mutate(rank = row_number()) |>
     filter(rank <=3) |>
     arrange(gender)


# find the day with the most trips
trips |> group_by(as_date(starttime)) |> summarize(count = n()) |> arrange(desc(count)) |> head(n=1)

# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)


# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips |> group_by(hour(starttime)) |> summarize(count =n(), average = count/n_distinct(as_date(starttime)))

trips |> group_by(hour(starttime)) |> summarize(count =n(), average = count/n_distinct(as_date(starttime))) |> arrange(average) |> tail(n=1)
