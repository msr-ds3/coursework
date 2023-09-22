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
ggplot(trips, aes(x = tripduration)) +
  geom_histogram(bins = 50, color = "black", fill = "lightblue") +
  labs(title = "Distribution of Trip Times",
       x = "Trip Duration (seconds)",
       y = "Frequency")

ggplot(trips, aes(x = tripduration)) +
  geom_density(color = "black", fill = "lightblue") +
  labs(title = "Distribution of Trip Times",
       x = "Trip Duration (seconds)",
       y = "Density")

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
  filter(tripduration <= 1e4) %>%
  ggplot(aes(x = tripduration, color = usertype, fill = usertype)) +
  geom_histogram(bins = 50, color = "black", alpha = 0.5, position = "identity") +
  labs(title = "Distribution of Trip Times by Rider Type",
       x = "Trip Duration (seconds)",
       y = "Frequency")

trips %>%
  filter(tripduration <= 1e4) %>%
  ggplot(aes(x = tripduration, color = usertype, fill = usertype)) +
  geom_density(color = "black", alpha = 0.5, position = "identity") +
  labs(title = "Distribution of Trip Times by Rider Type",
       x = "Trip Duration (seconds)",
       y = "Density")

# plot the total number of trips on each day in the dataset
trips %>%
  group_by(ymd) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = ymd, y = count)) +
  geom_line()

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  group_by(birth_year, gender) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = birth_year, y = count, color = gender, fill = gender)) +
  geom_bar(stat = 'identity', alpha = 0.5, position = "identity") +
  labs(title = "Total Number of Trips by Age and Gender",
       x = "Age",
       y = "Number of Trips")

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
  filter(gender != "Unknown") %>%
  group_by(birth_year) %>%
  count(gender) %>%
  pivot_wider(names_from = gender, values_from = n) %>%
  ggplot(aes(x = birth_year, y = Male/Female)) +
  geom_point() +
  labs(title = "Male to Female Trips by Age",
       x = "Age",
       y = "Ratio")

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
  ggplot(aes(x = date, y = tmin)) +
  geom_point()  +
  labs(title = "Minimum Temperature Over Each Day",
       x = "Day",
       y = "Min. Temp.")

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
  pivot_longer(names_to = "label", values_to = "temp", 5:6) %>%
  ggplot(aes(x = date, y = temp, color = label)) +
  geom_point()  +
  labs(title = "Minimum and Maximum Temperature Over Each Day",
       x = "Day",
       y = "Temp.")

########################################
# plot trip and weather data
########################################
# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  group_by(ymd) %>%
  summarize(count = n(), tmin = tmin[1]) %>%
  ggplot(aes(x = tmin, y = count)) +
  geom_point() +
  geom_smooth() +
  labs(x = "Min. Temp.",
       y = "Number of Trips")

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  group_by(ymd) %>%
  summarize(count = n(), tmin = tmin[1], substan_p = prcp[1] > 1) %>%
  ggplot(aes(x = tmin, y = count, color = substan_p)) +
  geom_point() +
  labs(x = "Min. Temp.",
       y = "Number of Trips")

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
  group_by(ymd) %>%
  summarize(count = n(), tmin = tmin[1], substan_p = prcp[1] > 1) %>%
  ggplot(aes(x = tmin, y = count, color = substan_p)) +
  geom_point() +
  geom_smooth() +
  labs(x = "Min. Temp.",
       y = "Number of Trips")

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>%
  mutate(hr = hour(starttime)) %>%
  group_by(hr, ymd) %>%
  count() %>%
  group_by(hr) %>%
  summarize(mean(n), sd(n))

# plot the above
trips_with_weather %>%
  mutate(hr = hour(starttime)) %>%
  group_by(hr, ymd) %>%
  count() %>%
  group_by(hr) %>%
  summarize(avg_num_trips = mean(n), sd_num_trips = sd(n)) %>%
  ggplot(aes(x = hr, y = avg_num_trips)) +
  geom_point()

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather %>%
  mutate(hr = hour(starttime)) %>%
  group_by(hr, ymd) %>%
  count() %>%
  mutate(dow = wday(ymd)) %>%
  group_by(hr, dow) %>%
  summarize(avg_num_trips = mean(n), sd_num_trips = sd(n), dow) %>%
  ggplot(aes(x = hr, y = avg_num_trips, color = as.factor(dow))) +
  geom_point()