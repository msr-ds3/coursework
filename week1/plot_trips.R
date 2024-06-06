########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
# Jenny said this meant duration, and to ignore anything after an hour
trips |> 
    filter(tripduration < 60*60) |>
    ggplot(aes(x=tripduration)) +
    geom_histogram()

trips |> 
    filter(tripduration < 60*60) |>
    ggplot(aes(x=tripduration)) +
    geom_density()
# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips |> 
    filter(tripduration < 60*60) |>
    ggplot(aes(x=tripduration, color=usertype, fill=usertype)) +
    geom_histogram()

trips |> 
    filter(tripduration < 60*60) |>
    ggplot(aes(x=tripduration, color=usertype, fill=usertype)) +
    geom_density()
# plot the total number of trips on each day in the dataset
trips |>
    group_by(ymd) |>
    summarize(count=n()) |>
    ggplot(aes(x=ymd, y=count)) +
    geom_point()
# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips |>
    mutate(age=year(ymd) - birth_year) |>
    group_by(age, gender) |>
    summarize(count=n()) |>
    ggplot(aes(x=age, y=count, color=gender)) +
    geom_point()
# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips |>
    mutate(age=year(ymd) - birth_year) |>
    group_by(age, gender) |>
    summarize(num_trips=n()) |>
    spread(gender, num_trips) |> 
    mutate(gender_ratio=Male/Female) |>
    ggplot(aes(age, gender_ratio)) +
    geom_point()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather |>
    ggplot(aes(x=ymd, y=tmin)) +
    geom_point()
# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather |>
    gather("type", "temp", tmax, tmin) |>
    ggplot(aes(x=ymd, y=temp, color=type)) +
    geom_line()
    
########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather |>
    group_by(ymd) |>
    summarize(num_trips=n(), tmin=mean(tmin)) |> 
    ggplot(aes(x=tmin, y=num_trips)) +
    geom_point()
# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
# https://weatherins.com/rain-guidelines/
# It seems that 0.1 is significant
trips_with_weather |>
    mutate(sig_prcp=prcp >= 0.1) |>
    group_by(ymd, sig_prcp) |>
    summarize(num_trips=n(), tmin=mean(tmin)) |> 
    ggplot(aes(x=tmin, y=num_trips, color=sig_prcp)) +
    geom_point()
# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather |>
    mutate(sig_prcp=prcp >= 0.1) |>
    group_by(ymd, sig_prcp) |>
    summarize(num_trips=n(), tmin=mean(tmin)) |> 
    ggplot(aes(x=tmin, y=num_trips, color=sig_prcp)) +
    geom_point() +
    geom_smooth()

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
# plot the above
trips_with_weather |>
    mutate(hour=hour(starttime)) |>
    group_by(ymd, hour) |>
    summarize(hour_trips=n()) |>
    group_by(hour) |>
    summarize(mean_trips=mean(hour_trips), std_trips=sd(hour_trips)) |>
    gather("type", "value", mean_trips, std_trips) |>
    ggplot(aes(x=hour, y=value)) +
    geom_line() +
    facet_wrap(~ type)

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather |>
    mutate(hour=hour(starttime), day_of_week=wday(ymd, label=T)) |>
    group_by(ymd, hour, day_of_week) |>
    summarize(hour_trips=n()) |>
    group_by(hour, day_of_week) |>
    summarize(mean_trips=mean(hour_trips), std_trips=sd(hour_trips)) |>
    gather("type", "value", mean_trips, std_trips) |>
    ggplot(aes(x=hour, y=value, color=day_of_week)) +
    geom_line() +
    facet_wrap(~ type)
