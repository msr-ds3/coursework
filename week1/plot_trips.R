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
ggplot(trips, aes(x=tripduration)) +
    scale_x_log10(label = comma) +
    geom_histogram(bins = 200)

ggplot(trips, aes(x=tripduration)) +
    scale_x_log10(label = comma) +
    geom_density(fill = "blue")

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x=tripduration, colour=usertype, fill=usertype)) +
    scale_x_log10(label = comma) +
    geom_histogram(bins = 50) +
    facet_wrap(~ usertype)

ggplot(trips, aes(x=tripduration, colour=usertype, fill=usertype)) +
    scale_x_log10(label = comma) +
    geom_density()

# plot the total number of trips on each day in the dataset
trips %>%
    mutate(day = floor_date(starttime, unit = "day")) %>%
    ggplot(aes(x=day)) +
    geom_bar(fill = '#9797c0')

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
    mutate(age = 2014 - birth_year) %>%
    ggplot(aes(x = age, fill = gender)) +
    geom_bar(alpha = 1/5, position = "identity")

trips %>%
    mutate(age = 2014 - birth_year) %>%
    group_by(age, gender) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = age, y = count, colour = gender)) +
    geom_point() +
    geom_smooth()

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

# uses pivot_wider() for monday


########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
ggplot(weather, aes(x = date, y = tmin)) +
    geom_point(colour='#618695')

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

# reshaping data

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
# x = min temp y = number of trips
trips_with_weather %>%
    group_by(tmin, date) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = tmin, y = count)) +
    geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

# AVG MEAN PRECIP: 0.0936
trips_with_weather %>% 
    mutate(is_substantial = (prcp > 0.0936)) %>%
    group_by(tmin, date, is_substantial) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = tmin, y = count, colour = is_substantial)) +
    geom_point()

trips_with_weather %>% 
    mutate(is_substantial = (prcp > 0.0936)) %>%
    group_by(tmin, date, is_substantial) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = tmin, y = count, colour = is_substantial)) +
    geom_point() +
    geom_smooth(method = "lm")

trips_with_weather %>% 
    mutate(is_substantial = (prcp > 0.0936)) %>%
    group_by(tmin, date, is_substantial) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = tmin, y = count)) +
    geom_point( colour = 'purple') +
    facet_wrap(~ is_substantial)

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>% 
    mutate(is_substantial = (prcp > 0.0936)) %>%
    group_by(tmin, date, is_substantial) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = tmin, y = count)) +
    geom_point( colour = 'purple') +
    facet_wrap(~ is_substantial) +
    geom_smooth(method = "lm")

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>%
    mutate(hour = hour(starttime)) %>%
    group_by(date, hour) %>%
    summarize(count=n()) %>%
    group_by(hour) %>%
    arrange(hour) %>%
    summarize(avg = mean(count), sd = sd(count)) %>%
    view() 

# plot the above
trips_with_weather %>%
    mutate(hour = hour(starttime)) %>%
    group_by(date, hour) %>%
    summarize(count=n()) %>%
    group_by(hour) %>%
    summarize(avg = mean(count), sd = sd(count)) %>%
    ggplot(aes(x = hour, y = avg)) +
    geom_pointrange(aes(ymin = avg - sd, ymax = avg + sd)) +
    coord_flip()

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips %>%
    mutate(date = as.Date(starttime), day_of_week = wday(date)) %>%
    group_by(date, day_of_week) %>%    
    summarize(count=n()) %>%
    group_by(day_of_week) %>%
    summarize(avg = mean(count), sd = sd(count)) %>%
    ggplot(aes(x = day_of_week, y = avg)) +
    geom_pointrange(aes(ymin = avg - sd, ymax = avg + sd)) +
    coord_flip()


