########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)
library(ggplot2)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load("trips.RData")


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
trips |> ggplot(aes(x = tripduration)) +
    geom_histogram() +
    scale_x_log10(label = comma) +
    xlab("num_trips") +
    ylab("trip_duration")

trips |> ggplot(aes(x = tripduration)) +
    geom_density(fill = "grey") +
    scale_x_log10(label = comma) +
    xlab("num_trips") +
    ylab("trip_duration")



# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips |> ggplot(aes(x = tripduration, color = usertype, fill = usertype)) +
    geom_histogram() +
    scale_x_log10(label = comma) +
    xlab("num_trips") +
    ylab("trip_duration")

trips |> ggplot(aes(x = tripduration, color = usertype, fill = usertype)) +
    geom_density() +
    scale_x_log10(label = comma) +
    xlab("num_trips") +
    ylab("trip_duration")


# plot the total number of trips on each day in the dataset

trips |>
    mutate(day = as.Date(starttime)) |>
    ggplot(aes(x = day)) +
    geom_histogram()

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips |>
    mutate(age = year(ymd) - birth_year) |>
    ggplot(aes(x = age, color = gender, fill = gender)) +
    geom_histogram()

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

trips |>
    mutate(age = year(ymd) - birth_year) |>
    group_by(age, gender) |>
    summarize(count = n()) |>
    pivot_wider(names_from = gender, values_from = count) |>
    ggplot(aes(x = age, y = Male / Female)) +
    geom_point() +
    scale_y_log10(label = comma) +
    scale_x_log10(label = comma)


########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather |> ggplot(aes(x = ymd, y = tmin)) +
    geom_point() +
    xlab("date") +
    ylab("minimum temperature")

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

weather |>
    pivot_longer(names_to = "max_min", values_to = "temperature", -c(date, prcp, snwd, snow, ymd)) |>
    ggplot(aes(x = date, y = temperature, color = max_min)) +
    geom_point()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by = "ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

trips_with_weather |>
    count(date, tmin) |>
    ggplot(aes(x = tmin, y = n)) +
    geom_point() +
    xlab("min_temp") +
    ylab("num_trips")

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
prcp_boundary <- weather |>
    summarize(prcp_mean = mean(prcp)) |>
    pull(prcp_mean)

trips_with_weather |>
    mutate(sub_prcp = ifelse(prcp > prcp_boundary, TRUE, FALSE)) |>
    count(date, sub_prcp, tmin) |>
    ggplot(aes(x = tmin, y = n)) +
    geom_point() +
    facet_wrap(~sub_prcp) +
    xlab("min_temp") +
    ylab("num_trips")


# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather |>
    mutate(sub_prcp = ifelse(prcp > prcp_boundary, TRUE, FALSE)) |>
    count(date, sub_prcp, tmin) |>
    ggplot(aes(x = tmin, y = n)) +
    geom_point() +
    geom_smooth() +
    facet_wrap(~sub_prcp, labeller = as_labeller(c("TRUE" = "substantial precipitation", "FALSE" = "Not substantial precipitation"))) +
    xlab("min_temp") +
    ylab("num_trips")

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_hours_stats <- trips |>
    mutate(hour = hour(starttime)) |>
    group_by(hour, ymd) |>
    summarize(num_trips = n()) |>
    summarize(avg_trips = mean(num_trips), std_trips = sd(num_trips)) |>
    head() |>
    View()

# plot the above
trips_hours_stats |>
    ggplot(aes(x = hour)) +
    geom_point(aes(y = avg_trips, color = "red")) +
    geom_point(aes(y = std_trips, color = "blue"))

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips |>
    mutate(day = wday(starttime), hour = hour(starttime)) |>
    group_by(hour, day, ymd) |>
    summarize(num_trips = n()) |>
    summarize(avg_trips = mean(num_trips), std_trips = sd(num_trips)) |>
    View()
