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
  filter(minutes < (60 * 48)) %>%  # limit to rides under 48 hours
  ggplot(aes(x = minutes, fill = usertype)) +
  geom_histogram(bins=100, position = "identity", alpha = 0.5) +
  scale_y_continuous(label = comma) +
  scale_x_log10(label = comma) +
  labs(x = "Minutes", y = "Number of trips")

trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(minutes < (60 * 48)) %>%  # limit to rides under 48 hours
  ggplot(aes(x = minutes)) +
  geom_density() +
  scale_y_continuous(label = comma) +
  scale_x_log10(label = comma) +
  labs(x = "Minutes", y = "Number of trips")


# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(minutes < (60 * 48)) %>%  # limit to rides under 48 hours
  ggplot(aes(x = minutes, fill = usertype)) +
  geom_histogram(bins=100, position = "identity", alpha = 0.5) +
  scale_y_continuous(label = comma) +
  scale_x_log10(label = comma) +
  labs(x = "Minutes", y = "Number of trips", fill = "User type")
  

trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(minutes < (60 * 48)) %>%  # limit to rides under 48 hours
  ggplot(aes(x = minutes, fill = usertype)) +
  geom_density(position = "identity", alpha = 0.5) +
  scale_y_continuous(label = comma) +
  scale_x_log10(label = comma) +
  labs(x = "Minutes", fill = "User type")


# plot the total number of trips on each day in the dataset
trips %>%
  ggplot(aes(x = ymd)) +
  geom_histogram(bins = 365) +
  scale_y_log10(label = comma) +
  labs(x = "Days", y = "Number of trips")

#trips %>%
  #count(ymd) %>%
  #ggplot(aes(x = ymd, y = n)) +
  #geom_bar(stat = "identity") +
  #scale_y_log10(label = comma) +
  #labs(x = "Days", y = "Number of trips")

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  mutate(age = (year(ymd) - birth_year)) %>%
  ggplot(aes(x = age, fill = gender)) +
  geom_histogram(bins = 115, position = "identity", alpha = 0.5) +  # the oldest person is 115
  scale_y_continuous(label = comma) +
  labs(x = "Age", y = "Number of trips")

#trips %>%
  #mutate(age = (year(ymd) - birth_year)) %>%
  #group_by(age, gender) %>%
  #summarize(n = n()) %>%
  #ggplot(aes(x = age, y = n)) +
  #geom_bar(stat = "identity") +  # the oldest person is 115
  #scale_y_continuous(label = comma) +
  #labs(x = "Age", y = "Number of trips")


# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
  mutate(age = (year(ymd) - birth_year)) %>%
  add_count(age, gender, name = 'gender_per_age') %>%
  select(age, gender, gender_per_age) %>% 
  unique() %>%
  pivot_wider(names_from = gender, values_from = gender_per_age) %>%
  mutate(ratio = Male/Female) %>%
  ggplot(aes(x = age, y = ratio)) +
  geom_point() +
  labs(x = "Age", y = "Ratio of male to female trips")


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
  pivot_longer(names_to = "temp_type", values_to = "temp", matches('^tm..')) %>%
  ggplot(aes(x = ymd, y = temp, color = temp_type)) +
  geom_point() + 
  geom_smooth() + 
  labs(x = "Day", y = "Temperature", color = "Temp type")

#weather %>%
  #ggplot(aes(x = ymd, y = tmin)) +
  #geom_point(color = 'blue') + 
  #geom_point(aes(x = ymd, y = tmax), color = 'red') +
  #labs(x = "Day", y = "Temperature")

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  group_by(ymd, tmin) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = tmin, y = count)) +
  geom_point() +
  scale_y_continuous(label = comma) +
  labs(x = "Minimum temperature", y = "Number of trips")

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  mutate(substantial_prcp = prcp > 0.5) %>%
  group_by(ymd, tmin, substantial_prcp) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = tmin, y = count, color = substantial_prcp)) +
  geom_point() +
  scale_y_continuous(label = comma) +
  labs(x = "Minimum temperature", y = "Number of trips")

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
  mutate(substantial_prcp = prcp > 0.5) %>%
  group_by(ymd, tmin, substantial_prcp) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = tmin, y = count, color = substantial_prcp)) +
  geom_point() +
  geom_smooth() +
  scale_y_continuous(label = comma) +
  labs(x = "Minimum temperature", y = "Number of trips")

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips %>%
  mutate(hour = hour(starttime)) %>%
  group_by(hour, ymd) %>%
  summarize(trips_per_hour_per_day = n()) %>%
  group_by(hour) %>%
  summarize(mean_trips_per_hour = mean(trips_per_hour_per_day), sd_trips_per_hour = sd(trips_per_hour_per_day))

# plot the above
trips %>%
  mutate(hour = hour(starttime)) %>%
  group_by(hour, ymd) %>%
  summarize(trips_per_hour_per_day = n()) %>%
  group_by(hour) %>%
  summarize(mean = mean(trips_per_hour_per_day), sd = sd(trips_per_hour_per_day)) %>%
  ggplot(aes(x = hour, y = mean)) +
  geom_point() +
  geom_errorbar(aes(ymin = mean-sd, ymax = mean+sd)) +
  scale_y_continuous(label = comma) + 
  labs(x = "Hour", y = "Number of trips")

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips %>%
  mutate(hour = hour(starttime), weekday = wday(starttime, label = TRUE)) %>%
  group_by(hour, ymd, weekday) %>%
  summarize(trips_per_hour_per_day = n()) %>%
  group_by(hour, weekday) %>%
  summarize(mean = mean(trips_per_hour_per_day), sd = sd(trips_per_hour_per_day)) %>%
  ggplot(aes(x = hour, y = mean, color = weekday)) + geom_point() +
  geom_errorbar(aes(ymin = mean-sd, ymax = mean+sd), alpha = 0.5) +
  scale_y_continuous(label = comma) + 
  labs(x = "Hour", y = "Avg number of trips", color = "Weekday")

trips %>%
  mutate(hour = hour(starttime), weekday = wday(starttime)) %>%
  mutate(weektype = ifelse(weekday == 1 | weekday == 7, "Weekend", "Workday")) %>%
  group_by(hour, ymd, weektype) %>%
  summarize(trips_per_hour_per_weektype = n()) %>%
  group_by(hour, weektype) %>%
  summarize(mean = mean(trips_per_hour_per_weektype), sd = sd(trips_per_hour_per_weektype)) %>%
  ggplot(aes(x = hour, y = mean, color = as.factor(weektype))) +
  geom_line() +
  geom_errorbar(aes(ymin = mean-sd, ymax = mean+sd), alpha = 0.5) +
  scale_y_continuous(label = comma) + 
  labs(x = "Hour", y = "Avg number of trips", color = "Week type")