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
sample <- head(trips)

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
trips %>%
  filter(tripduration <= 1e4) %>%
  ggplot(aes(x = tripduration)) +
  geom_histogram(bins = 20, color = 'black', fill = 'lightblue')+
  scale_x_log10()+
  labs(title = "Distribution of Trip Times - Histogram",
    x = "Trip Duration (seconds)",
    y = "Frequency")

trips %>%
  filter(tripduration <= 1e4) %>%
  ggplot(aes(x = tripduration)) +
  geom_density(color = 'black', fill = 'lightblue')+
  scale_x_log10()+
  labs(title = "Distribution of Trip Times - Density",
     x = "Trip Duration (seconds)",
     y = "Density")

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
  filter(tripduration <= 1e4) %>%
ggplot(aes(x = tripduration, color = usertype, fill = usertype)) +
  geom_histogram(bins = 40, color = 'black', alpha = 0.5, position = "identity")+
  scale_x_log10()+
  labs(title = "Distribution of Trip Times by Rider Type - Histogram",
     x = "Trip Duration (seconds)",
     y = "Frequency")

trips %>%
  filter(tripduration <= 1e4) %>%
  ggplot(aes(x = tripduration, color = usertype, fill = usertype )) +
  geom_density(color = 'black', alpha = 0.5, position = "identity")+
  scale_x_log10()+
  labs(title = "Distribution of Trip Times by Rider Type - Density",
       x = "Trip Duration (seconds)",
       y = "Frequency")

# plot the total number of trips on each day in the dataset
trips %>% group_by(ymd) %>% summarize(count = n()) %>%
ggplot(aes(x = ymd, y = count)) +
  geom_line()

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  ggplot(aes(x = birth_year, color = gender, fill = gender)) +
  scale_y_log10()+
  geom_histogram(bins = 40, color = 'black', alpha = 0.5, position = "identity")


# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

trips %>% filter(gender != "Unknown") %>% group_by(birth_year) %>% count(gender) %>%
  pivot_wider(names_from = 'gender', values_from = 'n') %>%
  ggplot(aes(x = birth_year, y = Male/Female)) +
  geom_point()
  

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
  ggplot(aes(x = date(date), y = tmin)) +
  geom_point()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

weather %>%
  pivot_longer(names_to = "type", values_to = "temp", 5:6) %>%
  ggplot(aes(x = date(date), y = temp, color = type)) +
  geom_point()

########################################
# plot trip and weather data
########################################

# join trips and weather
  trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  group_by(date) %>%
  summarize(count = n(), tmin = tmin[1]) %>%
  ggplot(aes(x = tmin, y = count)) +
  geom_point() +
  geom_smooth()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  group_by(date) %>%
  summarize(count = n(), tmin = tmin[1], subs_precipitation = prcp[1]>1.0) %>%
  ggplot(aes(x = tmin, y = count, color = subs_precipitation)) +
  geom_point()


# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
  group_by(date) %>%
  summarize(count = n(), tmin = tmin[1], subs_precipitation = prcp[1]>1.0) %>%
  ggplot(aes(x = tmin, y = count, color = subs_precipitation)) +
  geom_point() +
  geom_smooth()


# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>%
  mutate(hour = hour(starttime)) %>% group_by(hour, ymd) %>% count() %>% group_by(hour) %>% summarize(mean(n), sd(n))
                                                                            
# plot the above
trips_with_weather %>%
  mutate(hour = hour(starttime)) %>% group_by(hour, ymd) %>% count() %>% group_by(hour) %>% summarize(avg_num_trips = mean(n), sd_num_trips = sd(n)) %>%
  ggplot(aes(x = hour, y = avg_num_trips)) +
  geom_point() +
  geom_errorbar(aes(ymin = avg_num_trips - sd_num_trips, ymax = avg_num_trips + sd_num_trips), width = .2, position = position_dodge(0.05))

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather %>%
  mutate(hour = hour(starttime)) %>% 
  group_by(hour, ymd) %>% 
  count() %>% 
  mutate(dow = wday(ymd)) %>%
  group_by(hour, dow) %>% 
  summarize(avg_num_trips = mean(n), sd_num_trips = sd(n), dow) %>%
  ggplot(aes(x = hour, y = avg_num_trips, color = as.factor(dow))) +
  geom_point()
  # geom_errorbar(aes(ymin = avg_num_trips - sd_num_trips, ymax = avg_num_trips + sd_num_trips), width = .2, position = position_dodge(0.05))