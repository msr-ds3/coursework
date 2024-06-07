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
trips %>% filter(tripduration < 3600) %>% 
  ggplot(mapping = aes(x = tripduration)) + 
  scale_y_continuous(label = comma) +
  geom_histogram() +
  xlab('Trip Duration') +
  ylab('Number of Trips')

trips %>% filter(tripduration < 3600) %>% 
  ggplot(mapping = aes(x = tripduration)) + 
  scale_y_continuous(label = comma) +
  geom_density() +
  xlab('Trip Duration') +
  ylab('Number of Trips')

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>% filter(tripduration < 3600) %>% 
  ggplot(mapping = aes(x = tripduration, color=usertype, fill = usertype)) + 
  scale_y_continuous(label = comma) +
  geom_histogram() +
  xlab('Trip Duration') +
  ylab('Number of Trips')

trips %>% filter(tripduration < 3600) %>% 
  ggplot(mapping = aes(x = tripduration, color=usertype, fill = usertype)) + 
  scale_y_continuous(label = comma) +
  geom_density() +
  xlab('Trip Duration') +
  ylab('Number of Trips')

# plot the total number of trips on each day in the dataset
trips %>% 
  mutate(date = as_date(ymd)) %>% 
  group_by(date) %>% 
  summarize(count = n()) %>% 
  ggplot(mapping = aes(x = date, y =count)) + geom_point() +
  xlab('Date (Y/M/D)') +
  ylab('Number of Trips')

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>% 
  mutate(age = 2024 - birth_year) %>% group_by(age, gender) %>% 
  summarize(count = n()) %>% 
  filter(age < 99) %>% 
  ggplot(mapping= aes(x=age, y=count, color=gender, fill=gender)) + 
  scale_y_continuous(label = comma) + 
  geom_point() +
  xlab('Age') +
  ylab('Number of Trips')

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>% group_by(tmin, ymd) %>% summarize(count =n()) %>% 
  ggplot(mapping = aes(y=tmin, x=ymd)) + 
  geom_point() +
  xlab('Date (Y/M/D)') +
  ylab('Minimum Temperature')

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
trips_with_weather %>% 
  group_by(tmin, ymd) %>% 
  summarize(count=n()) %>% 
  ggplot(mapping=aes(x=tmin, y=count)) + 
  scale_y_continuous(label = comma) +
  geom_point() +
  xlab('Minimum Temperature') +
  ylab('Number of Trips')

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

#---original implementation---
# substantial <- quantile(trips_with_weather$prcp, .95) %>% unname()

trips_with_weather %>%  
  mutate(heavy_perc = ifelse(prcp >= unname(quantile(trips_with_weather$prcp, .95)), "T",
                             ifelse(prcp < substantial, "F", "no")), .before = 1) %>%
  group_by(tmin, ymd, heavy_perc) %>% 
  summarize(count=n()) %>% 
  ggplot(mapping=aes(x=tmin, y=count, color=heavy_perc)) + 
  scale_y_continuous(label = comma) +
  geom_point() +
  xlab('Minimum Temperature') +
  ylab('Number of Trips')

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%  
  mutate(heavy_perc = ifelse(prcp >= substantial, "T",
                             ifelse(prcp < substantial, "F", "no")), .before = 1) %>%
  group_by(tmin, ymd, heavy_perc) %>% 
  summarize(count=n()) %>% 
  ggplot(mapping=aes(x=tmin, y=count, color=heavy_perc)) + 
  scale_y_continuous(label = comma) +
  geom_point() + geom_smooth() +
  xlab('Minimum Temperature') +
  ylab('Number of Trips')

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>% 
  mutate(hour=hour(starttime)) %>% 
  group_by(hour, ymd) %>% 
  summarize(count=n()) %>% 
  summarize(average_per_hour=mean(count),  sd_per_hour=sd(count)) 

# plot the above
trips_with_weather %>% 
  mutate(hour=hour(starttime)) %>% 
  group_by(hour, ymd) %>% 
  summarize(count=n()) %>% 
  summarize(average_per_hour=mean(count),  sd_per_hour=sd(count))   %>% 
  ggplot(aes(x=hour, y = average_per_hour)) + 
  geom_pointrange(mapping = aes(ymin=average_per_hour-sd_per_hour, 
                                ymax=average_per_hour+sd_per_hour)) +
  xlab('Time of Day') +
  ylab('Average/Standard Deviation')


# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather %>% 
  mutate(hour=hour(starttime), day=wday(ymd, label=TRUE), .before = 1) %>% 
  group_by(ymd, hour, day) %>% 
  summarize( count=n()) %>% 
  group_by(hour, day) %>% 
  summarize(average_per_hour=mean(count),  sd_per_hour=sd(count))  %>% 
  ggplot(aes(x=hour, y = average_per_hour)) + 
  geom_pointrange(mapping = aes(ymin=average_per_hour-sd_per_hour, 
                                ymax=average_per_hour+sd_per_hour)) +
  facet_wrap(~day) +
  xlab('Time of Day') +
  ylab('Average/Standard Deviation') 
