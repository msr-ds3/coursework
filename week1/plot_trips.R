########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(lubridate)
library(scales)
library(ggplot2)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')
trips

########################################
# plot trip data
########################################


# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
trips %>% ggplot(mapping = aes(x = starttime)) + geom_histogram(color = "blue", fill = "lightblue")
trips %>% ggplot(mapping = aes(x = starttime)) + geom_density(color = "blue", fill = "lightblue")

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>% ggplot(mapping = aes(x = starttime)) + geom_histogram(mapping = aes (color = usertype, fill = usertype))
trips %>% ggplot(mapping = aes(x = starttime)) + geom_density(mapping = aes( color = usertype, fill = usertype))

# plot the total number of trips on each day in the dataset
trips %>% ggplot() + stat_count(mapping = aes(x =  substr(starttime, 9, 10), fill = substr(starttime, 9, 10)), alpha = 1/2) +
 xlab("day") + ylab("tot_trips")

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>% ggplot() + stat_count(mapping = aes(x =  2014 - birth_year, color = gender, fill = gender), alpha = 1/3) +
  xlab("age") + ylab("tot_trips") 

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
#trips %>% filter(birth_year, gender) + summarize(group_by(birth_year) + 
#  + ggplot() + geom_histogram(mapping = aes(x =))

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

weather %>% ggplot(mapping = aes(x = substr(date, 9, 10), y = tmin)) + geom_point() + xlab("day") +
  theme(axis.text.x = element_text(angle = 90, size = 4)) + facet_wrap(~substr(date, 6, 7))

# plot the minimum temperature and maximum temweatherperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
tw <- inner_join(summarize(group_by(trips, ymd), num_trips = n()), weather, by="ymd")
tw %>% ggplot() + geom_point(mapping = aes(x = tmin, y = num_trips, color = ymd))


# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
tw %>% 
  mutate(subst = ifelse(prcp >= 0.3, "TRUE", "FALSE")) %>%
  ggplot(mapping = aes(x = tmin, y = num_trips, color = ymd, shape = subst)) +
  geom_point()

# add a smoothed fit on top of the previous plot, using geom_smooth
tw %>% 
  mutate(subst = ifelse(prcp >= 0.3, "TRUE", "FALSE")) %>%
  ggplot(mapping = aes(x = tmin, y = num_trips, color = ymd, shape = subst)) +
  geom_point() +
  geom_smooth()

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trip_by_hr <- mutate(trips, hour = hour(starttime)) %>% group_by(hour) %>% summarize(count = mean(n())) %>% arrange(desc(count))

# plot the above
trip_by_hr %>% ggplot() + geom_point(mapping = aes(x = hour, y = count))

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trip_by_day_hr <- mutate(trips, day = wday(starttime), hour = hour(starttime)) %>% group_by(hour, day) %>% summarize(count = mean(n())) %>% arrange(desc(count))
trip_by_day_hr %>% ggplot() + geom_point(mapping = aes(x = hour, y = count)) + facet_wrap(~day)
