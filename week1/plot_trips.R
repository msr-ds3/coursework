########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load("trips.RData")


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration)) +
  geom_histogram() +
  scale_x_log10(label = comma)
labs(title = "Histogram of Trip Durations", x = "Trip Duration (minutes)", y = "Number of Trips")

ggplot(trips, aes(x = tripduration)) +
  geom_density(fill = "grey") +
  scale_x_log10(label = comma)
labs(title = "Histogram of Trip Durations", x = "Trip Duration (minutes)", y = "Number of Trips")


# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) +
  geom_histogram() +
  scale_x_log10(label = comma)
labs(title = "Histogram of Trip Durations", x = "Trip Duration (minutes)", y = "Number of Trips")

ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) +
  geom_density() +
  scale_x_log10(label = comma)
labs(title = "Histogram of Trip Durations", x = "Trip Duration (minutes)", y = "Number of Trips")



# plot the total number of trips on each day in the dataset
# 1. Extract just the date from the starttime column
trips %>%
  mutate(date = as.Date(starttime)) %>%
  ggplot() +
  geom_histogram(aes(x = date)) +
  labs(
    title = "Total Number of Trips per Day",
    x = "Date",
    y = "Number of Trips"
  )

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  mutate(age = year(ymd) - birth_year) %>%
  ggplot(aes(x = age, color = gender, fill = gender)) +
  geom_histogram()

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
ggplot(weather, aes(x = as.Date(ymd), y = tmin)) +
  geom_point()


# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by = "ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

trips %>%
  mutate(date = as.Date(starttime)) %>%
  group_by(date) %>%
  summarise(num_trips = n())

weather <- weather %>%
  mutate(date = as.Date(date))

trips_with_weather <- inner_join(trips_by_day, weather, by = "date")

ggplot(trips_with_weather, aes(x = tmin, y = num_trips)) +
  geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

borderline <- weather %>%
  summarize(prcp_mean = mean(prcp)) %>%
  pull(prcp_mean)


trips_with_weather %>%
  mutate(sub_prcp = ifelse(prcp > borderline, TRUE, FALSE)) %>%
  count(date, sub_prcp, tmin) %>%
  ggplot(aes(x = tmin, y = n)) +
  geom_point() +
  facet_wrap(~sub_prcp, labeller = as_labeller(c("TRUE" = "Substanrtial", "FALSE" = "Non-Substantial"))) +
  xlab("min_temp") +
  ylab("num_trips")



# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
  mutate(sub_prcp = ifelse(prcp > borderline, TRUE, FALSE)) %>%
  count(date, sub_prcp, tmin) %>%
  ggplot(aes(x = tmin, y = n)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~sub_prcp, labeller = as_labeller(c("TRUE" = "Substanrtial", "FALSE" = "Non-Substantial"))) +
  xlab("min_temp") +
  ylab("num_trips")

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
library(lubridate)


hourly_summary <- trips %>%
  mutate(
    hour = hour(starttime),
    day = as.Date(starttime)
  ) %>%
  group_by(hour, day) %>%
  summarize(trip_count = n(), .groups = "drop") %>%
  group_by(hour) %>%
  summarize(
    average = mean(trip_count),
    standDev = sd(trip_count)
  )

hourly_summary



# plot the above






# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
