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
  geom_histogram(bins = 100) +
  scale_x_log10(label = comma)
ggplot(trips, aes(x = tripduration)) +
  geom_density(fill = "grey") +
  scale_x_log10(label = comma)
# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) + 
  geom_histogram(bins = 100) + 
  scale_x_log10(label = comma)
ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) + 
  geom_density() + scale_x_log10(label = comma)

# plot the total number of trips on each day in the dataset
trips %>% 
  group_by(ymd) %>% 
  summarize(num_trips = n()) %>% 
  ggplot(aes(x = ymd, y = num_trips)) + 
  geom_point() + 
  xlab('Day') + 
  ylab('Number of Trips')
# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>% 
  mutate(age = 2022 - birth_year) %>% 
  group_by(age, gender) %>% 
  summarize (num_trips =n()) %>% 
  ggplot(aes(x = age, y = num_trips, color = gender)) + 
  geom_point() + 
  xlab('Age') + 
  scale_y_log10(label = comma)
# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
  group_by(birth_year,gender) %>%
  summarize(count = n()) %>%
  spread(gender, count) %>%
  mutate(ratio = Male/Female) %>%
  ggplot(aes(x = 2022-birth_year, y = ratio)) +
  geom_point()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
ggplot(weather, aes(x = date, y = tmin)) +
  geom_point()
# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
gather(weather, "temp", "tnums", 5:6) %>% ggplot(aes(x=date, y=tnums, color=temp)) + geom_point()
########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
group_by(trips_with_weather, tmin) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x=count, y=tmin)) +
  geom_point()
# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
mutate(trips_with_weather, heavy_weather = prcp >= .5) %>% 
  group_by(tmin, heavy_weather) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x=count, y=tmin, color = heavy_weather)) +
  geom_point()
# add a smoothed fit on top of the previous plot, using geom_smooth
mutate(trips_with_weather, heavy_weather = prcp >= 1.5) %>% 
  group_by(tmin, heavy_weather) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x=count, y=tmin, color = heavy_weather)) + 
  geom_smooth()
# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
library(lubridate)

mutate(trips_with_weather, hourly = hour(starttime)) %>%
  group_by(ymd, hourly) %>%
  summarise( count = n()) %>% 
  group_by(hourly) %>% 
  summarise(avg = mean(count), std = sd(count))
# plot the above
mutate(trips_with_weather, hourly = hour(starttime)) %>%
  group_by(ymd, hourly) %>%
  summarise( count = n()) %>%
  group_by(hourly) %>%
  summarise(avg = mean(count), std = sd(count)) %>%
  ggplot() +
  geom_line(aes(x = hourly, y = avg, color = "avg")) +
  geom_line(aes(x = hourly, y = std, color = "std"))
# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
mutate(trips_with_weather, hourly = hour(starttime), day_of_week = wday(ymd)) %>%
  group_by(day_of_week, ymd, hourly) %>%
  summarise( count = n()) %>% 
  group_by(day_of_week, hourly) %>%
  summarise(avg = mean(count), std = sd(count)) %>%
  ggplot() +
  geom_line(aes(x = hourly, y = avg, color = "avg")) +
  geom_line(aes(x = hourly, y = std, color = "std")) +
  facet_wrap( ~day_of_week)