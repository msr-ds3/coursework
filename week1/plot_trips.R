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
view(trips)

########################################
# plot trip data
########################################
sample <- head(trips)

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
ggplot(sample, aes(x = tripduration)) +
  geom_histogram(bins = 20, color = 'black', fill = 'lightblue')+
  labs(title = "Distribution of Trip Times - Histogram",
    x = "Trip Duration (seconds)",
    y = "Frequency")
  
ggplot(sample, aes(x = tripduration)) +
  geom_density(color = 'black', fill = 'lightblue')+
  labs(title = "Distribution of Trip Times - Density",
     x = "Trip Duration (seconds)",
     y = "Density")

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
  filter(tripduration <= 1e4) %>%
ggplot(aes(x = tripduration, color = usertype, fill = usertype)) +
  geom_histogram(bins = 50, color = 'black', alpha = 0.5, position = "identity")+
  labs(title = "Distribution of Trip Times by Rider Type - Histogram",
     x = "Trip Duration (seconds)",
     y = "Frequency")

trips %>%
  filter(tripduration <= 1e4) %>%
  ggplot(aes(x = tripduration, color = usertype, fill = usertype )) +
  geom_density(color = 'black', alpha = 0.5, position = "identity")+
  labs(title = "Distribution of Trip Times by Rider Type - Density",
       x = "Trip Duration (seconds)",
       y = "Frequency")

# plot the total number of trips on each day in the dataset
# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)


# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

# add a smoothed fit on top of the previous plot, using geom_smooth

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
