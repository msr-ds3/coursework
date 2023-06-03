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
 
head(trips)
head(weather)

########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(tripduration < (60 * 72)) %>%  # limit to rides under 72 hours
  ggplot(aes(x = minutes)) +
  geom_histogram(bins=100) +
  labs(x = "Minutes per trip")

trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(tripduration < (60 * 72)) %>%  # limit to rides under 72 hours
  ggplot(aes(x = minutes)) +
  geom_density() +
  labs(x = "Minutes per trip")

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
# Histogram of trip times by rider type
trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(tripduration < (60 * 72)) %>%  # limit to rides under 72 hours
  ggplot(aes(x = minutes, fill = usertype)) +
  geom_histogram(bins=100) +
  labs(x = "Minutes per trip", fill = "Rider type")

# Density plot of trip times by rider type
trips %>%
  mutate(minutes = tripduration/60) %>%
  filter(tripduration < (60 * 72)) %>%  # limit to rides under 72 hours
  ggplot(aes(x = minutes, fill = usertype)) +
  geom_density() +
  labs(x = "Minutes per trip", fill = "Rider type")
# plot the total number of trips on each day in the dataset
trips %>%
  mutate(date = as.Date(starttime)) %>%
  group_by(date) %>%
  summarize(trips = n()) %>%
  ggplot(aes(x = date, y = trips)) +
  geom_line() +
  labs(x = "Date", y = "Total trips")


# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  mutate(age = year(ymd) - birth_year) %>%
  group_by(age, gender) %>%
  summarize(trips = n()) %>%
  ggplot(aes(x = age, y = trips, color = gender)) +
  geom_line() +
  labs(x = "Age", y = "Total trips", color = "Gender")

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>% 
  mutate(age = year(ymd) - birth_year) %>%
  filter(age <= 100) %>%
  group_by(age, gender) %>%
  summarize(count = n()) %>%
  pivot_wider(names_from = gender, values_from = count ) %>%
  mutate(ratio = Male / Female) %>%
  ggplot(aes(x = age, y = ratio), color = gender) +
  geom_bar(stat= 'identity')

  


########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
  group_by(ymd) %>%
  ggplot(aes(x= ymd, y = tmin)) +
  geom_line()


# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>% 
  select(tmin, tmax, ymd) %>%
  pivot_longer(names_to = "min_max" , values_to = "temperature" , 1:2) %>%
  ggplot(aes(x = ymd, y = temperature, color = min_max)) +
  geom_line()
  


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
  ggplot(aes(x = ymd, y = tmin)) +
  geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  mutate(substantial_precipitation = prcp >= 1) %>%
  group_by(ymd, tmin,  substantial_precipitation ) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = ymd, y = tmin )) +
  geom_point()

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
  mutate(substantial_precipitation = prcp >= 1) %>%
  group_by(ymd, tmin,  substantial_precipitation ) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = ymd, y = tmin )) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_y_log10(label = comma)

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>%
  mutate(hour_date = hour(starttime)) %>%
  group_by(hour_date) %>%
  summarize(count = n()) %>%
  summarize(avg_trips = mean(count), std_deviation = sd(count))

# plot the above
trips_with_weather %>%
  mutate(hour_date = hour(starttime)) %>%
  group_by(hour_date, tmin) %>%
  summarize(count = n(), avg_trips = mean(count), std_deviation = sd(count)) %>%
  ggplot(aes(x = hour_date, y = tmin )) +
  geom_line()


# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather %>%
  mutate(week_day = wday(starttime)) %>%
  group_by(week_day, tmin) %>%
  summarize(count = n(), avg_trips = mean(count), std_deviation = sd(count)) %>%
  ggplot(aes(x = week_day, y = tmin )) +
  geom_line()
