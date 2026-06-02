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

# 1. plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
trips %>%
    mutate(minutes = tripduration/60) %>%
    filter(minutes <= 720) %>%
    group_by(minutes) %>%
    summarize(trip_duration_counts = n()) %>%
    ggplot(aes(x = minutes)) +
    geom_histogram(bins = 30) +
    xlab('Trip Duration (minutes)')

trips %>%
    mutate(minutes = tripduration/60) %>%
    filter(minutes <= 720) %>%
    group_by(minutes) %>%
    summarize(trip_duration_counts = n()) %>%
    ggplot(aes(x = minutes)) +
    geom_density(fill = "grey") +
    xlab('Trip Duration (minutes)') +
    ylab('Density')

# 2. plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
    mutate(minutes = tripduration/60) %>%
    filter(minutes <= 720) %>%
    group_by(usertype, minutes) %>%
    summarize(trip_duration_counts = n()) %>%
    ggplot(aes(x = minutes, fill = usertype)) +
    geom_histogram(bins = 30, position = "dodge") +
    xlab('Trip Duration (minutes)')

trips %>%
    mutate(minutes = tripduration/60) %>%
    filter(minutes <= 720) %>%
    group_by(usertype, minutes) %>%
    summarize(trip_duration_counts = n()) %>%
    ggplot(aes(x = minutes, color = usertype, fill = usertype)) +
    geom_density(alpha = .5) +
    xlab('Trip Duration (minutes)')

# 3. plot the total number of trips on each day in the dataset
trips %>%
    mutate(day = mday(starttime)) %>%
    ggplot(aes(x = day)) +
    geom_bar() +
    scale_y_continuous(label = comma) +
    xlab('Trips By Day')
    
# 4. plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
    mutate(age = year(starttime) - birth_year) %>%
    filter(age <= 90) %>%
    ggplot(aes(x = age, color = gender, fill = gender)) +
    geom_histogram(bins = 50, position = "dodge") +
    scale_y_continuous(label = comma) +
    xlab('Trips By Age')

# 5. plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
    mutate(age = year(starttime) - birth_year) %>%
    filter(age <= 90, gender != "Unknown") %>% 
    group_by(gender, age) %>%
    summarise(count = n()) %>%
    pivot_wider(names_from = gender, values_from = count) %>%
    mutate(ratio = Male / Female) %>%
    ggplot(aes(x = age, y = ratio)) + 
    geom_point() + 
    ylab('ratio (male to female riders)')

########################################
# plot weather data
########################################
# 6. plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
    ggplot(aes(x = ymd, y = tmin)) +
    geom_point() +
    ylab('minimum temperature')

# 7. plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
    pivot_longer(names_to = "min_max", values_to = "temp", 5:6) %>%
    ggplot(aes(x = ymd, y = temp, color = min_max)) +
    geom_point() 

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# 8. plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%  
    mutate(day=round_date(starttime, "day")) %>%
    group_by(day) %>%
    summarise(num_trips = n(), min_temp = min(tmin)) %>%
    ggplot(aes(x=min_temp, y=num_trips)) +
    geom_point() + 
    ylab("Number of trips (per day)") + 
    xlab("Minimum temperature (per day)")

# 9. repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%  
    mutate(day=round_date(starttime, "day")) %>%
    group_by(day) %>%
    summarise(num_trips = n(), min_temp = min(tmin), total_prcp = sum(prcp)) %>%
    mutate(significant_precipitation = total_prcp >= 2) %>%
    ggplot(aes(x=min_temp, y=num_trips, color=significant_precipitation)) +
    geom_point() + 
    ylab("Number of trips (per day)") + 
    xlab("Minimum temperature (per day)")

# 10. add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%  
    mutate(day=round_date(starttime, "day")) %>%
    group_by(day) %>%
    summarise(num_trips = n(), min_temp = min(tmin), total_prcp = sum(prcp)) %>%
    mutate(significant_precipitation = total_prcp >= 2) %>%
    ggplot(aes(x=min_temp, y=num_trips, color=significant_precipitation)) +
    geom_point() + 
    geom_smooth() +
    ylab("Number of trips (per day)") + 
    xlab("Minimum temperature (per day)")

# 11. compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips %>%
    mutate(day_hour=hour(starttime)) %>% 
    group_by(day_hour, ymd) %>%
    summarize(count=n()) %>%
    summarize(mean_number_trips=mean(count), sd_trips = sd(count))

# 12. plot the above
trips %>%
    mutate(hour=hour(starttime)) %>% 
    group_by(hour, ymd) %>%
    summarize(count=n()) %>%
    summarize(mean_number_trips=mean(count), sd_trips = sd(count)) %>%
    ggplot(aes(x=hour, y=mean_number_trips)) + 
    geom_pointrange(aes(ymin=mean_number_trips- sd_trips, ymax = mean_number_trips+sd_trips))

# 13. repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips %>%
    mutate(hour=hour(starttime), day = wday(ymd)) %>% 
    group_by(hour, day) %>%
    summarize(count=n()) %>%
    group_by(hour, day) %>%
    summarize(mean_number_trips=mean(count), sd_trips = sd(count)) %>%
    ggplot(aes(x=hour, y=mean_number_trips)) + 
    geom_pointrange(aes(ymin=mean_number_trips- sd_trips, ymax = mean_number_trips+sd_trips)) +
    facet_wrap(~day)
