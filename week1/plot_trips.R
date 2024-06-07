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
  filter(tripduration < 3600) %>% 
  ggplot(aes( x = tripduration )) +
  geom_histogram()

trips %>% 
  filter(tripduration < 3600) %>% 
  ggplot(aes( x = tripduration )) +
  geom_density()


# plot the distribution of trip plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>% 
  filter(tripduration < 3600) %>% 
  ggplot(aes(x = tripduration, fill = usertype)) +
  geom_histogram()
trips %>% 
  filter(tripduration < 3600) %>% 
  ggplot(aes(x = tripduration, fill = usertype)) +
  geom_density()

# plot the total number of trips on each day in the dataset
trips %>% 
  mutate(ymd = date(starttime)) %>% group_by(ymd) %>% 
  summarize(count = n()) %>% 
  ggplot(aes(x = ymd, y = count)) + 
  geom_smooth()

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>% 
  mutate(age = 2014 - birth_year) %>% group_by(age, gender) %>% 
  summarize(count = n()) %>% 
  ggplot(aes(x = age, y = count, group = gender) ) + 
  geom_line(aes(group = gender, color = gender)) + 
  scale_y_continuous(label = comma) +
  coord_cartesian(ylim = c(0,300000))

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
  mutate(age = 2014 - birth_year) %>%
  group_by(age, gender) %>%
  summarize(count = n()) %>% 
  pivot_wider(names_from = gender, values_from = count ) %>% 
  mutate( ratio = Male / Female ) %>% 
  ggplot(aes( x = age, y =ratio))+
  geom_point()


  ggplot() +
  geom_histogram(aes(x = age, color = ))

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>% 
  ggplot(aes(x = ymd, y = tmin)) +
  geom_point()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
weather %>% 
  ggplot() +
  geom_point(aes(x = ymd, y = tmax), color = "red") +
  geom_point(aes(x = ymd, y = tmin), color = "blue")
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>% 
  pivot_longer(
    col = c(tmin,tmax),
    names_to = "tmax_and_min",
    values_to = "temp") %>% 
  ggplot(aes(x = ymd, y = temp, color = tmax_and_min ))+
  geom_smooth()
########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>% 
  group_by(ymd) %>% 
  summarize(count = n(), min = min(tmin)) %>% 
  ggplot(aes(x= min, y = count))+
  geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>% 
  mutate(sub_p = case_when(
    prcp >= 0.59 ~ "T",
    prcp < 0.59 ~ "F")) %>%
  group_by(ymd, sub_p) %>% 
  summarize(count = n(), min = min(tmin)) %>% 
  ggplot(aes(x= min, y = count, color = sub_p))+
  geom_point()

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>% 
  mutate(sub_p = case_when(
    prcp >= 0.59 ~ "T",
    prcp < 0.59 ~ "F")) %>%
  group_by(ymd, sub_p) %>% 
  summarize(count = n(), min = min(tmin)) %>% 
  ggplot(aes(x= min, y = count, color = sub_p))+
  geom_point() + 
  geom_smooth()

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>% 
  mutate(hours = hour(starttime)) |>
  group_by(ymd,hours) |> 
  summarize(trips_taken = n()) %>% 
  group_by(hours) %>% 
  summarize(avg_trips = mean(trips_taken),
            st_trips_taken= sd(trips_taken))

# plot the above
trips_with_weather %>% 
  mutate(hours = hour(starttime)) %>% 
  group_by(ymd,hours) %>%  # focusing on data for hours of specific day
  summarize(trips_taken = n()) %>% 
  group_by(hours) %>% # to calculate st.deviation, we grouped by hours
  summarize(avg_trips = mean(trips_taken),
            st_trips_taken= sd(trips_taken)) %>% 
  pivot_longer(cols = c(avg_trips,st_trips_taken),
               names_to = "avg_and_stdev",
               values_to = "number_of_trips") %>% 
  ggplot()+
  geom_point( aes(x = hours, y = number_of_trips, color = avg_and_stdev))   # blue = mean
  geom_point( aes(x = hours, y = st_trips_taken, color ="red")) # red = st.deviation
  
trips_with_weather %>% 
  mutate(hours = hour(starttime)) %>% 
  group_by(ymd, hours) %>%  # focusing on data for hours of specific day
  summarize(trips_taken = n()) %>% 
  group_by(hours) %>% # to calculate st.deviation, we grouped by hours
  summarize(avg_trips = mean(trips_taken),
            st_trips_taken= sd(trips_taken)) %>%
  ggplot(aes(x = hours, y = avg_trips)) +
  geom_ribbon(aes(ymin = avg_trips - st_trips_taken, 
                  ymax = avg_trips + st_trips_taken))+
  geom_line()
  
# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather %>% 
  mutate(hours = hour(starttime), weekdays = wday(starttime)) %>% 
  group_by(ymd,hours,weekdays) %>%  
  summarize(trips_taken = n()) %>% 
  group_by(hours, weekdays) %>% 
  summarize(avg_trips = mean(trips_taken),
            st_trips_taken= sd(trips_taken)) %>% 
  ggplot(aes(x = hours, y = avg_trips, color = as.factor(weekdays)))+
  geom_line()
