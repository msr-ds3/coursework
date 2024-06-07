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
  filter(tripduration< 3600) %>% ggplot(mapping = aes(x=tripduration)) + geom_histogram()
  
  trips %>% 
  filter(tripduration< 3600) %>% ggplot(mapping = aes(x=tripduration)) + geom_density()

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
  trips %>% 
  filter(tripduration< 3600) %>% ggplot(mapping = aes(x=tripduration, color = usertype, fill = usertype)) + geom_histogram()
  
  trips %>% 
  filter(tripduration< 3600) %>% ggplot(mapping = aes(x=tripduration, color = usertype, fill = usertype)) + geom_density()
  
# plot the total number of trips on each day in the dataset
  trips %>% 
  mutate(date = as_date(ymd)) %>% 
  ggplot(mapping = aes(x = date)) + geom_histogram()
  
# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>% 
  mutate(age = 2024 - birth_year) %>% group_by(age, gender) %>% 
  summarize(count = n()) %>% 
  ggplot(mapping =aes(x = age,y = count, color=gender,fill=gender)) + geom_point()
  
  
# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>% 
  mutate(age = 2024 - birth_year) %>% group_by(age, gender) %>% 
  summarize(count = n()) %>%
  pivot_wider(names_from = gender,values_from = count) %>% 
  group_by(age, Male, Female) %>% 
  mutate(ratio= (Male/Female)) %>% 
  ggplot(mapping= aes(x=age,y = ratio)) + geom_point()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>% 
  ggplot(mapping =aes(x=date,y=tmin)) 

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
  pivot_longer(names_to = "Temperature",values_to = "count", 5:6) %>%
  ggplot(mapping = aes(x=date,y = count, color =Temperature)) + geom_point()


########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  group_by(tmin, ymd) %>% summarize(count=n()) %>% 
  ggplot(mapping =aes(x=tmin,y = count)) + geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
# add a smoothed fit on top of the previous plot, using geom_smooth
    sprec <- quantile(trips_with_weather$prcp, .95) %>% unname()
    trips_with_weather %>% 
      mutate(substantialprec = ifelse(prcp<sprec, "F",
                                      ifelse(prcp>=sprec, "T", "no"))) %>% 
      group_by(tmin,ymd,substantialprec) %>% summarize(count = n()) %>% 
      ggplot(mapping = aes(x=tmin,y=count,color = substantialprec)) + geom_point()
               

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
