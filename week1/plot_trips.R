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

# all duration
trips %>%
  ggplot(aes(x = tripduration/60)) +
  geom_histogram( bins= 20)+
  scale_x_log10(label = comma)+
  scale_y_log10(label = comma) + 
  xlab("trips length") +
  ylab("# trips")

# less than or equal to hour
trips %>%
  filter(tripduration <= 3600) %>%
  ggplot(aes(x = tripduration/60)) +
  geom_histogram( bins= 20)+
  scale_x_log10(label = comma)+
  scale_y_log10(label = comma) + 
  xlab("trips length") +
  ylab("# trips")

trips %>%
  filter(tripduration <= 3600) %>%
  ggplot(aes(x = tripduration/60)) +
  geom_density()+
  scale_x_log10(label = comma)+
  scale_y_log10(label = comma) + 
  xlab("trips length") +
  ylab("# trips")


# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)

# histogram with facet
trips %>%
  ggplot(aes(x = tripduration/60, fill = usertype)) +
  geom_histogram( bins= 20)+
  scale_x_log10(label = comma)+
  scale_y_log10(label = comma) + 
  xlab("trips length") +
  ylab("# trips") +
  facet_wrap(~ usertype, scale = "free_y")


# density plot with facet
trips %>%
  ggplot(aes(x = tripduration/60, color = usertype)) +
  geom_density()+
  scale_x_log10(label = comma)+
  # scale_y_log10(label = comma) + 
  xlab("trips length") +
  ylab("# trips") +
  facet_wrap(~ usertype, scale = "free_y")

# plot the total number of trips on each day in the dataset
trips %>%
  ggplot(aes(x = ymd))+
  geom_histogram() +
  scale_y_continuous(label = comma)

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  ggplot(aes(x = 2014 - birth_year, fill = gender))+
  geom_histogram() +
  scale_y_continuous(label = comma) +
  ylab("Age")

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
  mutate(age = 2014 - birth_year) %>%
  group_by(gender, age) %>%
  summarise(count = n()) %>%
  pivot_wider( names_from = gender, values_from = count) %>%
  mutate(ratio = Male / Female) %>%
  ggplot(aes(x = age, y= ratio)) +
  geom_point()


########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
  ggplot(aes(x=ymd, y = tmin))+
  geom_point() 


# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

weather %>%
  pivot_longer(names_to = "type", values_to = "value", c(tmin, tmax)) %>% 
  ggplot(aes(x = ymd, y = value, color = type)) +
  geom_point()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  group_by(tmin, ymd) %>%
  summarise(count = n())%>%
  ggplot(aes(x = tmin, y= count)) +
  geom_point()
  
# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  mutate (sub_prcp = ifelse(prcp > mean(prcp), TRUE, FALSE)) %>% 
  group_by(tmin, ymd, sub_prcp) %>%
  summarise(count = n())%>%
  ggplot(aes(x = tmin, y= count)) +
  geom_point() +
  facet_wrap(~sub_prcp)

# add a smoothed fit on top of the previous plot, using geom_smooth

trips_with_weather %>%
  mutate (sub_prcp = ifelse(prcp > mean(prcp), TRUE, FALSE)) %>% 
  group_by(tmin, ymd, sub_prcp) %>%
  summarise(count = n())%>%
  ggplot(aes(x = tmin, y= count)) +
  geom_point() +
  facet_wrap(~sub_prcp) + 
  geom_smooth()
# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>%
  mutate(hour = hour(starttime)) %>%
  group_by(ymd, hour) %>%
  summarise(count = n()) %>% 
  group_by(hour) %>%
  summarise(avg_count = mean(count), sd_count = sd(count)) %>%
  view()

# plot the above

# for average
trips_with_weather %>%
  mutate(hour = hour(starttime)) %>%
  group_by(ymd, hour) %>%
  summarise(count = n()) %>% 
  group_by(hour) %>%
  summarise(avg_count = mean(count), sd_count = sd(count)) %>%
  ggplot(aes(x = hour, y= avg_count)) +
  geom_line()+
  geom_ribbon(aes(ymin = avg_count - sd_count, ymax = avg_count + sd_count, fill = "green"), alpha= 0.25) 
# 
# #for standard deviation
# 
# trips_with_weather %>%
#   mutate(hour = hour(starttime)) %>%
#   group_by(ymd, hour) %>%
#   summarise(count = n()) %>%
#   group_by(hour) %>%
#   summarise(avg_count = mean(count), sd_count = sd(count)) %>%
#   ggplot() +
#   geom_line(aes(x = hour, y= sd_count, color = "red"))
# 

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

trips_with_weather %>%
  mutate(hour = hour(starttime), day = as.factor(wday(starttime))) %>%
  group_by(ymd, hour, day) %>%
  summarise(count = n()) %>%
  group_by(hour, day) %>%
  summarise(avg_count = mean(count), sd_count = sd(count)) %>% 
  ggplot() +
  geom_line(aes(x = hour, y= avg_count, color= "red")) +
  geom_line(aes(x = hour, y= sd_count, color= "blue")) +
  facet_wrap(~ day) +
  xlab("Hour of the day")+
  ylab("AVerage & standard deviation ")

