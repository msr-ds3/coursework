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
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration)) +
    geom_histogram() +
    scale_x_log10(label = comma) +
    xlab('Trip Duration') +
    ylab('Frequency')
    

ggplot(trips, aes(x = tripduration)) +
    geom_density(fill="grey") +
    scale_x_log10(label = comma) +
    xlab('Trip Duration') +
    ylab('Frequency')

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips) + 
    geom_histogram(aes(x = tripduration, color = usertype, fill=usertype)) +
    scale_x_log10(label = comma) +
    xlab('Trip Duration') +
    ylab('Frequency')

ggplot(trips) + 
    geom_density(aes(x = tripduration, color = usertype, fill=usertype)) +
    scale_x_log10(label = comma) +
    xlab('Trip Duration') +
    ylab('Frequency')


# plot the total number of trips on each day in the dataset
trips |> mutate(Date = as.Date(starttime)) |>
    ggplot() + 
    geom_histogram(aes(x = Date)) 


# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips |> mutate(age = 2025-birth_year) |>
    ggplot() + 
    geom_histogram(aes(x = age, color = gender, fill=gender)) +
    scale_x_log10(label = comma)

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
# Example: Summarize, reshape, and plot ratio by age

# Thank you octopilot
trips |> 
    mutate(age = 2025 - birth_year) |> 
    group_by(age, gender) |> 
    summarize(n = n(), .groups = "drop") |> 
    tidyr::pivot_wider(names_from = gender, values_from = n, values_fill = 0) |> 
    mutate(ratio = Male / Female) |> 
    ggplot(aes(x = age, y = ratio)) +
    geom_line() +
    labs(x = "Age", y = "Male to Female Trip Ratio")


########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
ggplot(weather, aes(x = date, y = tmin)) +
    geom_point() +
    xlab('Day') +
    ylab('Minimum Temperature')

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
# Reshape with pivot_longer
weather_long <- weather %>%
  pivot_longer(
    cols = c(tmin, tmax),
    names_to = "temp_type",
    values_to = "temperature"
  )
  
  View(weather_long )
  
  ggplot(weather_long, aes(x = date, y = temperature, color = temp_type)) +
  geom_point()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
num_trips <- trips |> mutate(ymd = as.Date(starttime)) |> group_by(ymd) |> summarize(count=n())
num_trips_weather<- inner_join(num_trips, weather, by="ymd")

ggplot(num_trips_weather, aes(x=tmin, y=count)) +
  geom_point() +
  xlab('Minimum Temperature') +
  ylab('Number of Trips')
  

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
mutate(num_trips_weather, significant_prcp=ifelse(prcp >= .05, T,F)) |> 
ggplot(aes(x=tmin, y=count)) +
  geom_point() +
  facet_wrap(~ significant_prcp) +
  xlab('Minimum Temperature') +
  ylab('Number of Trips')

# add a smoothed fit on top of the previous plot, using geom_smooth
mutate(num_trips_weather, significant_prcp=ifelse(prcp >= .05, T,F)) |> 
ggplot(aes(x=tmin, y=count)) +
  geom_point() +
  facet_wrap(~ significant_prcp) +
  geom_smooth() +
  xlab('Minimum Temperature') +
  ylab('Number of Trips')


# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
date_hour_counts    <- trips |> mutate(hour = hour(starttime), date = as.Date(starttime)) |>  group_by(date, hour)  |> count(date, hour)
count_mean_sd       <- date_hour_counts |> group_by(hour) |> summarize(avg = mean(n), std=sd(n)) 
count_mean_sd

# plot the above
long_count_mean_sd  <- count_mean_sd  %>%
  pivot_longer(
    cols = c(avg, std),
    names_to = "stat_type",
    values_to = "stat"
  )
    
  ggplot(long_count_mean_sd, aes(x =hour, y = stat, color = stat_type)) +
  geom_point()

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
date_hour_counts        <- trips |> mutate(hour = hour(starttime), date = as.Date(starttime)) |>  group_by(date, hour)  |> count(date, hour)
DAY_date_hour_counts    <- date_hour_counts |> mutate(day=wday(date)) 
View(DAY_date_hour_counts)
DAY_count_mean_sd       <- DAY_date_hour_counts |> group_by(day) |> summarize(avg = mean(n), std=sd(n)) 
View(DAY_count_mean_sd)

# plot the above
DAY_long_count_mean_sd  <- DAY_count_mean_sd  %>%
  pivot_longer(
    cols = c(avg, std),
    names_to = "stat_type",
    values_to = "stat"
  )
    
  ggplot(DAY_long_count_mean_sd, aes(x =day, y = stat, color = stat_type)) +
  geom_point()
