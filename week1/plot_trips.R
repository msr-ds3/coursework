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
  filter(tripduration <= 3600) %>%
  ggplot() +
  geom_histogram(aes(x=tripduration/60), bins=20) + 
  scale_x_log10(label=comma) + 
  scale_y_log10(label=comma) + 
  xlab("trip length") + 
  ylab("# of riders")


trips %>%
  filter(tripduration <= 3600) %>%
  ggplot() +
  geom_density(aes(x=tripduration/60), fill="grey") + 
  scale_x_log10(label=comma) + 
  scale_y_log10(label=comma) + 
  xlab("trip length") + 
  ylab("# of riders")

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
  #filter(tripduration <= 3600) %>%
  ggplot() + 
  geom_histogram(aes(x=tripduration/60, fill=usertype)) + 
  scale_x_log10(label=comma) + 
  scale_y_log10(label=comma) + 
  xlab("trip length") + 
  ylab("# of riders") + 
  facet_wrap(~usertype)

trips %>%
  #filter(tripduration <= 3600) %>%
  ggplot() +
  geom_density(aes(x=tripduration/60, color=usertype)) + 
  scale_x_log10(label=comma) + 
  #scale_y_log10(label=comma) + 
  xlab("trip length") + 
  ylab("# of riders") + 
  facet_wrap(~ usertype)

# plot the total number of trips on each day in the dataset
trips %>%
  ggplot() +
  geom_histogram(aes(x=ymd)) + 
  scale_y_continuous(label=comma) 

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  ggplot() + 
  geom_histogram(aes(x=2014-birth_year, fill=gender), bins=60) + 
  xlab("age") + 
  ylab("# of riders")

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)



########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
  ggplot() + 
  geom_point(aes(x=ymd, y=tmin))


# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the average minimum temperature by day, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  group_by(tmin, ymd) %>%
  summarize(num_trips = n()) %>% 
  ggplot() + 
  geom_point(aes(x=tmin, y=num_trips))
  
# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  mutate(substantial_parcipitation = ifelse(prcp>mean(prcp), TRUE, FALSE)) %>%
  group_by(tmin, ymd, substantial_parcipitation) %>%
  summarize(num_trips = n()) %>%
  ggplot() +
  geom_point(aes(x=tmin, y=num_trips)) + 
  facet_wrap(~substantial_parcipitation)
# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
  mutate(substantial_parcipitation = ifelse(prcp>mean(prcp), TRUE, FALSE)) %>%
  group_by(tmin, ymd, substantial_parcipitation) %>%
  summarize(num_trips = n()) %>%
  ggplot() +
  geom_point(aes(x=tmin, y=num_trips)) + 
  geom_smooth(aes(x=tmin, y=num_trips)) + 
  facet_wrap(~substantial_parcipitation)
# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>%
  group_by(ymd, hour = hour(starttime)) %>%
  summarize(num_trips = n()) %>%
  group_by(hour) %>%
  summarize(avg = mean(num_trips), stand_deviation = sd(num_trips))

# plot the above

#plotting hour vs mean
trips_with_weather %>%
  group_by(ymd, hour = hour(starttime)) %>%
  summarize(num_trips = n()) %>%
  group_by(hour) %>%
  summarize(avg = mean(num_trips), stand_deviation = sd(num_trips)) %>%
  ggplot(aes(x=hour, y=avg))  +
  geom_line() +
  geom_ribbon(aes(ymin = avg - stand_deviation, ymax = avg + stand_deviation, fill = "red"), alpha=0.25)
              
  #geom_line(aes(x=hour, y=stand_deviation, color="blue")) 


#plotting hour vs sd
trips_with_weather %>%
  group_by(ymd, hour = hour(starttime)) %>%
  summarize(num_trips = n()) %>%
  group_by(hour) %>%
  summarize(avg = mean(num_trips), stand_deviation = sd(num_trips)) %>%
  ggplot() + 
  geom_line(aes(x=hour, y=stand_deviation)) 


# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

#By day of the week
trips_with_weather %>%
  group_by(ymd, weekday = wday(starttime)) %>%
  summarize(num_trips = n()) %>%
  group_by(weekday) %>%
  summarize(avg = mean(num_trips), stand_deviation = sd(num_trips)) %>%
  ggplot() + 
  geom_line(aes(x=weekday, y=stand_deviation)) 

#By day of the week
trips_with_weather %>%
  mutate(weekday = as.factor(wday(starttime))) %>%
  group_by(ymd, hour = hour(starttime), weekday) %>%
  summarize(num_trips = n()) %>%
  group_by(hour, weekday) %>%
  summarize(avg = mean(num_trips), stand_deviation = sd(num_trips)) %>%
  ggplot() + 
  geom_line(aes(x=hour, y=stand_deviation, color=weekday))

#By day of the week
trips_with_weather %>%
  mutate(weekday = as.factor(wday(starttime))) %>%
  group_by(ymd, hour = hour(starttime), weekday) %>%
  summarize(num_trips = n()) %>%
  group_by(hour, weekday) %>%
  summarize(avg = mean(num_trips), stand_deviation = sd(num_trips)) %>%
  ggplot() + 
  geom_line(aes(x=hour, y=stand_deviation, color=weekday)) + 
  facet_wrap(~weekday) 


#By weekday vs weekday 
trips_with_weather %>%
  mutate(DayType=ifelse(wday(starttime)<6, "Weekday", "Weekend")) %>%
  group_by(ymd, wday) %>%
  group_by(DayType) %>%
  summarize(num_trips = n()) %>%
  group_by(weekday) %>%
  summarize(avg = mean(num_trips), stand_deviation = sd(num_trips)) %>%
  ggplot() + 
  geom_line(aes(x=weekday, y=stand_deviation)) 
  
