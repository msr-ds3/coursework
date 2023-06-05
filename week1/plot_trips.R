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
trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(tripduration < (60 * 72)) %>%  # limit to rides under 72 hours
  ggplot(aes(x = minutes)) +
  geom_histogram(bins=100) +
  scale_y_continuous(label = comma) +
  labs(x = "Minutes", y = "Number of trips")

trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(tripduration < (60 * 72)) %>%  # limit to rides under 72 hours
  ggplot(aes(x = minutes)) +
  geom_density() +
  scale_y_continuous(label = comma) +
  labs(x = "Minutes", y = "Number of trips")


# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(tripduration < (60 * 72)) %>%  # limit to rides under 72 hours
  ggplot(aes(x = minutes, color = gender)) +
  geom_histogram(bins=100) +
  scale_y_continuous(label = comma) +
  labs(x = "Minutes", y = "Number of trips")

trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(tripduration < (60 * 72)) %>%  # limit to rides under 72 hours
  ggplot(aes(x = minutes, color = gender)) +
  geom_density() +
  scale_y_continuous(label = comma) +
  labs(x = "Minutes", y = "Number of trips")


# plot the total number of trips on each day in the dataset
trips %>%
  ggplot(aes(x = ymd)) +
  geom_histogram(bins = 365*12) +
  scale_y_log10(label = comma) +
  labs(x = "Days", y = "Number of trips")

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  mutate(age = (year(ymd) - birth_year)) %>%
  ggplot(aes(x = age, color = gender)) +
  geom_histogram(bins = 115) +  # the oldest person is 115
  scale_y_log10(label = comma) +
  labs(x = "Age", y = "Number of trips")

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)


########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
  ggplot(aes(x = ymd, y = tmin, color = tmin)) +
  geom_point() + 
  labs(x = "Day", y = "Minimum temperature")

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
  ggplot(aes(x = ymd, y = tmin)) +
  geom_point(color = 'blue') + 
  geom_point(aes(x = ymd, y = tmax), color = 'red') +
  labs(x = "Day", y = "Temperature")

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  count(tmin) %>%
  ggplot(aes(x = tmin, y = n)) +
  geom_point() +
  geom_smooth() + ####
  scale_y_continuous(label = comma) +
  labs(x = "Minimum temperature", y = "Number of trips")

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  mutate(substantial_prcp = prcp > 0.5) %>%
  ggplot(aes(x = substantial_prcp)) +
  geom_histogram() + 
  labs(x = "Minimum temperature", y = "Number of trips")

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
  mutate(substantial_prcp = prcp > 0.5) %>%
  ggplot(aes(x = prcp, y = substantial_prcp)) +
  geom_point() + 
  geom_smooth() + 
  labs(x = "Minimum temperature", y = "Number of trips")

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_hour <- trips %>%
  mutate(hour = hour(starttime)) %>%
  add_count(hour, name = "trips_per_hour") #%>%
  #summarize(mean_trips_per_hour = mean(trips_per_hour), sd_trips_per_hour = sd(trips_per_hour))

# plot the above
trips_hour %>%
  ggplot(aes(x = hour)) +
  geom_histogram(bins = 24) +
  scale_y_continuous(label = comma) + 
  geom_hline(aes(yintercept = mean(trips_per_hour)), linetype = "dashed") +
  geom_hline(aes(yintercept = sd(trips_per_hour)), linetype = "dashed") +
  labs(x = "Hour", y = "Number of trips")

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_hour_week <- trips_hour %>%
  mutate(weekday = wday(starttime))

trips_hour_week %>%
  group_by(weekday) %>%
  ggplot(aes(x = hour, color = weekday)) +
  geom_histogram(bins = 24*7) +
  scale_y_continuous(label = comma) + 
  labs(y = "Number of trips")

monday_trips_plot <- ggplot(filter(trips_hour_week, weekday == 1), aes(x = hour)) +
  geom_histogram(bins = 24, color = 'red') +
  scale_y_continuous(label = comma) + 
  labs(x = "Hour", y = "Number of trips")

tuesday_trips_plot <- ggplot(filter(trips_hour_week, weekday == 2), aes(x = hour)) +
  geom_histogram(bins = 24, color = 'orange') +
  scale_y_continuous(label = comma) + 
  labs(x = "Hour", y = "Number of trips")

wednesday_trips_plot <- ggplot(filter(trips_hour_week, weekday == 3), aes(x = hour)) +
  geom_histogram(bins = 24, color = 'yellow') +
  scale_y_continuous(label = comma) + 
  labs(x = "Hour", y = "Number of trips")

thursday_trips_plot <- ggplot(filter(trips_hour_week, weekday == 4), aes(x = hour)) +
  geom_histogram(bins = 24, color = 'green') +
  scale_y_continuous(label = comma) + 
  labs(x = "Hour", y = "Number of trips")

friday_trips_plot <- ggplot(filter(trips_hour_week, weekday == 5), aes(x = hour)) +
  geom_histogram(bins = 24, color = 'blue') +
  scale_y_continuous(label = comma) + 
  labs(x = "Hour", y = "Number of trips")

saturday_trips_plot <- ggplot(filter(trips_hour_week, weekday == 6), aes(x = hour)) +
  geom_histogram(bins = 24, color = 'purple') +
  scale_y_continuous(label = comma) + 
  labs(x = "Hour", y = "Number of trips")

sunday_trips_plot <- ggplot(filter(trips_hour_week, weekday == 7), aes(x = hour)) +
  geom_histogram(bins = 24, color = 'magenta') +
  scale_y_continuous(label = comma) + 
  labs(x = "Hour", y = "Number of trips")