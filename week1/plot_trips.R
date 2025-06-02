########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)
library(lubridate)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################
library(ggplot2)

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration)) +
    geom_histogram(bins = 30) + 
    scale_x_log10()

ggplot(trips, aes(x = tripduration)) +
    geom_density(fill = "blue") + 
    scale_x_log10()

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)

ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) +
    geom_histogram() +
    scale_x_log10()

ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) +
    geom_density() +
    scale_x_log10()



# plot the total number of trips on each day in the dataset
trips |>
    mutate(date_only = as.Date(starttime)) |>
    ggplot(aes(x = date_only)) +
    geom_histogram(bins = 365)

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips |>
    mutate(age = year(Sys.Date()) - birth_year) |>
    group_by(gender, age) |>
    summarise(count_trip_by_age = n()) |>
    ggplot(aes(x = age, y = count_trip_by_age, color = gender, fill = gender)) +
    geom_area() +
    scale_y_log10() 


# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

trips |>
    mutate(age = year(Sys.Date()) - birth_year) |>
    select(gender, age) |>
    group_by(age, gender) |>
    summarize(count_gender_by_age = n()) |>
    pivot_wider(names_from = gender, values_from = count_gender_by_age) |>
    mutate(male_to_female = Male/Female) |>
    ggplot(aes(x = age, y = male_to_female)) +
    geom_point() +
    geom_smooth(se=FALSE)





########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

weather |>
    ggplot(aes(x = date, y = tmin)) +
    geom_point() 


# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

weather |>
    select(date, tmin, tmax) |>
    pivot_longer(names_to = "min_max", values_to = "temperature", -date) |>
    ggplot(aes(x = date, y = temperature, color = min_max)) +
    geom_point()


########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

trips_with_weather |>
    group_by(date, tmin) |>
    summarise(count_trip = n()) |>
    ggplot(aes(x = tmin, y = count_trip)) +
    geom_point()


# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

mean_prcp <- trips_with_weather |>
    summarise( mean_prcp = mean(prcp))

mean_prcp <- mean_prcp$mean_prcp

trips_with_weather |>
    mutate(is_substantial_prcp = prcp >= mean_prcp) |>
    group_by(date, tmin, is_substantial_prcp) |>
    summarise(count_trip = n()) |>
    ggplot(aes(x = tmin, y = count_trip, color = is_substantial_prcp)) +
    geom_point()




# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather |>
    mutate(is_substantial_prcp = prcp >= mean_prcp) |>
    group_by(date, tmin, is_substantial_prcp) |>
    summarise(count_trip = n()) |>
    ggplot(aes(x = tmin, y = count_trip, color = is_substantial_prcp)) +
    geom_point() +
    geom_smooth(method = "lm")



# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather |>
    mutate(hour = hour(starttime), date = as.Date(starttime)) |>
    group_by(date, hour) |>
    summarize(count = n()) |>
    group_by(hour) |>
    summarize(avg = mean(count), std = sd(count))

# plot the above
trips_with_weather |>
    mutate(hour = hour(starttime), date = as.Date(starttime)) |>
    group_by(date, hour) |>
    summarize(count = n()) |>
    group_by(hour) |>
    summarize(avg = mean(count), std = sd(count)) |>
    pivot_longer(cols = c(avg, std), names_to = "stat", values_to = "value") |>
    ggplot(aes(x = hour, y = value, color = stat, fill = stat)) +
    geom_col(position = "dodge")

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

trips_with_weather |>
    mutate(hour = hour(starttime), date = as.Date(starttime), day = wday(starttime, label = TRUE)) |>
    group_by(date, day, hour) |>
    summarize(count = n()) |>
    group_by(day, hour) |>
    summarize(avg = mean(count), std = sd(count)) |>
    pivot_longer(cols = c(avg, std), names_to = "stat", values_to = "value") |>
    ggplot(aes(x = hour, y = value, color = stat, fill = stat)) +
    geom_col(position = "dodge") +
    facet_wrap(~ day)


