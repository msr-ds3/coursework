########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)
library(ggplot2)
library(lubridate)
setwd("C:/Users/buka/Documents/coursework/week1")

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
View(trips)

trips %>%
  group_by(ymd) %>%
  ggplot( mapping = aes(x = starttime) ) +
  geom_histogram()

trips %>%
  group_by(ymd) %>%
  ggplot( mapping = aes(x = starttime) ) +
  geom_density()

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
  group_by(ymd) %>%
  ggplot( mapping = aes(x = starttime) ) +
  geom_histogram( aes(color = usertype) )

trips %>%
  group_by(ymd) %>%
  ggplot( mapping = aes(x = starttime) ) +
  geom_density( aes(color = usertype) )


# plot the total number of trips on each day in the dataset
trips %>%
  group_by(ymd) %>%
  ggplot( aes(ymd) ) +
  geom_histogram( bins = 365 )

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  group_by( birth_year ) %>%
  ggplot( aes(x=birth_year) ) +
  geom_histogram( stat="count", aes(color=gender) )

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
  mutate( age = (year(now()) - birth_year) ) %>%
  group_by( gender, age ) %>%
  summarize(total = n() ) %>%
  pivot_wider( names_from = gender, values_from = total ) %>%
  mutate( male_to_female = Male/Female ) %>%
  arrange( age ) %>%
  ggplot( aes(x=age, y=male_to_female) ) +
  geom_line()
  

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
  ggplot( aes(ymd, tmin) ) +
  geom_line()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
  pivot_longer( c("tmin", "tmax"), names_to = "extrema", values_to = "temp" ) %>%
  ggplot( aes(date, temp) ) +
  geom_point( aes(color = extrema) )
  

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  group_by(ymd) %>%
  summarise( min_ = min(tmin), c = n() ) %>%
  ggplot( aes(min_, c) ) +
  geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  mutate( big_prec = prcp >= 1 ) %>%
  group_by(ymd) %>%
  summarise( min_ = min(tmin), c = n() ) %>% # need to add big_prec here
  ggplot( aes(min_, c) ) +
  geom_point() +
  facet_wrap( ~big_prec )
  

# add a smoothed fit on top of the previous plot, using geom_smooth
  geom_smooth()

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>%
  mutate( hour = hour(starttime) ) %>%
  group_by( hour ) %>%
  summarise( avg = n()/365, sd = sqrt( cumsum( (n()-avg) * (n()-avg) ) / 7779880 ) ) %>% # ! change to not hard code
# plot the above
  ggplot( aes(hour, avg) ) +
  geom_ribbon( aes(ymin = avg - sd, ymax = avg + sd), fill = "lightblue") +
  geom_line()

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather %>%
  mutate( hour = hour(starttime), wd = wday(starttime, TRUE)) %>%
  group_by( hour ) %>%
  summarise( avg = n()/365, sd = sqrt( cumsum( (n()-avg) * (n()-avg) ) / 7779880 ) ) %>% # ! change to not hard code
  ggplot( aes(hour, avg) ) +
  geom_ribbon( aes(ymin = avg - sd, ymax = avg + sd), fill = "lightblue") +
  geom_line() + 
  facet_wrap( ~wd )

table2 %>% View
