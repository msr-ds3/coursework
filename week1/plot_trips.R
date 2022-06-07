########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)
library(lubridate)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
trips %>% ggplot() + 
  geom_histogram(mapping = aes(x = tripduration)) + 
  scale_x_log10(label = comma)
trips %>% ggplot() + 
  geom_density(mapping = aes(x = tripduration)) + 
  scale_x_log10(label = comma)

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>% ggplot() + 
  geom_histogram(mapping = aes(x = tripduration, color = usertype)) + 
  scale_x_log10(label = comma)
trips %>% ggplot() + 
  geom_density(mapping = aes(x = tripduration, color = usertype, fill = usertype)) + 
  scale_x_log10(label = comma)

# plot the total number of trips on each day in the dataset
trips %>% mutate(ymd = as.Date(starttime)) %>% 
  group_by(ymd) %>% summarize(total_trips=n()) %>% 
  ggplot() + geom_point(aes(x = ymd, y = total_trips))

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  mutate(age = 2014-birth_year) %>%
  group_by(age, gender) %>%
  summarize(count = n()) %>%
  ggplot() +
  scale_y_continuous() + 
  geom_point(mapping = aes(x = age, y = count, color = gender))

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
  mutate(age = 2014-birth_year) %>%
  group_by(age, gender) %>%
  summarize(count = n()) %>%
  pivot_wider(names_from = gender, values_from = count) %>%
  mutate(ratio = Male/Female) %>%
  ggplot() +
  geom_point(mapping = aes(x = age, y = ratio))

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
  ggplot() +
  geom_line(mapping = aes(x = ymd, y = tmin))

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>% select(ymd,tmax,tmin) %>% 
  pivot_longer(names_to = "label", values_to = "temperature", cols = 2:3) %>% 
  ggplot() + geom_point(mapping = aes(x=ymd, y=temperature,color=label))

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  group_by(ymd, tmin) %>%
  summarize(total = n()) %>%
  ggplot() +
  geom_point(mapping = aes(x = tmin, y = total))

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  group_by(ymd) %>%
  summarise(total = n(), prcp = mean(prcp), tmin = mean(tmin)) %>%
  mutate(sub_prcp = prcp >= 0.5) %>%
  ggplot() + 
  geom_point(mapping = aes(x = tmin, y = total, color = sub_prcp))

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
  group_by(ymd) %>%
  summarise(total = n(), prcp = mean(prcp), tmin = mean(tmin)) %>%
  mutate(sub_prcp = prcp >= 0.5) %>%
  ggplot(mapping = aes(x = tmin, y = total, color = sub_prcp)) + 
  geom_point() + 
  geom_smooth()

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>%
  mutate(hour = hour(starttime)) %>%
  group_by(ymd, hour) %>%
  summarise(total_trips = n()) %>%
  group_by(hour) %>%
  summarise(avg = mean(total_trips), sd = sd(total_trips))

# plot the above
trips_with_weather %>%
  mutate(hour = hour(starttime)) %>%
  group_by(ymd, hour) %>%
  summarise(total_trips = n()) %>%
  group_by(hour) %>%
  summarise(avg = mean(total_trips), sd = sd(total_trips)) %>%
  ggplot() +
  geom_pointrange(aes(x = hour, y = avg, ymin = avg - sd, ymax = avg + sd))

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather %>%
  mutate(wday = wday(starttime)) %>%
  group_by(ymd, wday) %>%
  summarise(total_trips = n()) %>%
  group_by(wday) %>%
  summarise(avg = mean(total_trips), sd = sd(total_trips)) %>%
  ggplot() +
  geom_pointrange(aes(x = wday, y = avg, ymin = avg - sd, ymax = avg + sd))

