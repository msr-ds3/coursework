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
  ggplot(data = trips, mapping = aes(x = starttime)) +
    geom_histogram()

  ggplot(trips, mapping = aes(x = starttime)) + 
    geom_density(fill = "grey")
    

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
  ggplot(data = trips, mapping = aes(x = starttime, color = gender, fill = gender)) +
    geom_histogram()
  
  ggplot(trips, mapping = aes(x = starttime)) + 
    geom_density(mapping = aes(fill = gender))

# plot the total number of trips on each day in the dataset
  ggplot(trips, mapping = aes(x = ymd)) +
    geom_bar() +
    scale_y_continuous(label = comma) 

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
  trips %>% 
    mutate(age = 2014 - birth_year) %>%
    ggplot(mapping = aes(x = age, color = gender, fill = gender)) +
      geom_bar() +
      ylab('total number of trips') +
      xlab('age') +
      scale_y_continuous(label = comma)
  
  trips %>% filter(gender == 'Unknown') %>% filter(!is.na(birth_year)) %>% View

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
  weather %>% 
    ggplot(weather, mapping = aes(x = date, y = tmin)) +
    geom_point() +
    theme(axis.text.x = element_text(angle = 90, size = 5))


# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

########################################
# plot trip and weather data
########################################

# join trips and weather
  trips_with_weather <- inner_join(trips, weather, by="ymd")
  
  #(
  # was able to fix in the .Rdata
  # needed to modify weather to get ymd as a date (for some reason this did not work from the load_trips.R)
  #weather_ymd <- weather %>% mutate(ymd = as.Date(date, '%Y-%m-%d'))
  
  #trips_with_weather <- inner_join(trips, weather_ymd, by="ymd")
  #weather <- weather_ymd
  #)

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
  num_trips <- trips %>% group_by(ymd) %>% summarize(num_trips = n())
  num_trips_weather <- inner_join(num_trips, weather, by="ymd")
  
  num_trips_weather %>% 
    ggplot(mapping = aes(x = tmin, y = num_trips)) +
      geom_point() +
      scale_y_continuous(label = comma)

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
  num_trips_weather %>% 
    mutate(sub_precip = prcp >= 0.3) %>%
    ggplot(mapping = aes(x = tmin, y = num_trips, color = sub_precip)) +
      geom_point() +
      scale_y_continuous(label = comma)

# add a smoothed fit on top of the previous plot, using geom_smooth
  num_trips_weather %>% 
    mutate(sub_precip = prcp >= 0.3) %>%
    ggplot(mapping = aes(x = tmin, y = num_trips, color = sub_precip)) +
    geom_point() +
    geom_smooth() +
    scale_y_continuous(label = comma)

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
  hour_summ_by_day <- trips %>%
    mutate(hour = hour(starttime)) %>%
    group_by(hour, ymd) %>%
    summarize(num_trips = n()) 
  
  hours_sum <- hour_summ_by_day %>%
    group_by(hour) %>%
    summarize(average = mean(num_trips), sd = sd(num_trips))
  
# plot the above
  hours_summ %>%
    ggplot(mapping = aes(x = hour, y = average)) +
    geom_point()
  
  hours_summ %>%
    ggplot(mapping = aes(x = hour, y = sd)) +
    geom_point()

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
  
  