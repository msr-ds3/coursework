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
  geom_bar(alpha = 1/5) +
  ylab('total number of trips') +
  xlab('age') +
  scale_y_continuous(label = comma)

trips %>% filter(gender == 'Unknown') %>%
  filter(!is.na(birth_year)) %>% View

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
ggplot(weather, mapping = aes(x = date, y = tmin)) +
  geom_point() 


# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

gather(weather, "temp", "tnums", 5:6) %>% 
  ggplot(aes(x=date, y=tnums, color=temp)) + 
  geom_point()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# needed to modify weather to get ymd as a date 
weather_ymd <- weather %>% mutate(ymd = as.Date(date, '%Y-%m-%d'))

trips_with_weather <- inner_join(trips, weather_ymd, by="ymd")
weather <- weather_ymd

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
num_trips <- trips %>% group_by(ymd) %>% summarize(num_trips = n())
num_trips_tmin <- inner_join(num_trips, weather, by="ymd")

num_trips_tmin %>% 
  ggplot(mapping = aes(x = tmin, y = num_trips)) +
  geom_point() +
  scale_y_continuous(label = comma)

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
num_trips_tmin %>% 
  mutate(sub_precip = prcp >= 0.3) %>%
  ggplot(mapping = aes(x = tmin, y = num_trips, color = sub_precip)) +
  geom_point() +
  scale_y_continuous(label = comma)

# add a smoothed fit on top of the previous plot, using geom_smooth
num_trips_tmin %>% 
  mutate(sub_precip = prcp >= 0.3) %>%
  ggplot(mapping = aes(x = tmin, y = num_trips, color = sub_precip)) +
  geom_point() +
  geom_smooth() +
  scale_y_continuous(label = comma)

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

trips_with_weather$hour <-hour(trips_with_weather$starttime)

summ_by_hour <- trips_with_weather %>% 
  group_by(ymd, hour) %>%
  summarize(count = n())

hours_summary <-group_by(summ_by_hour, hour) %>% 
  summarize(average_num_trips = mean(count), 
            sd_num_trips = sd(count))


# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

trips_with_weather %>%
  mutate(hour = hour(starttime), wday = wday(starttime)) %>%
  group_by(ymd, hour, wday) %>%
  summarize(num_trips = n()) %>%
  group_by(hour, wday) %>%
  summarize(average_trips = mean(num_trips),
            sd_trips = sd(num_trips)) %>%
  ggplot(mapping = aes(x = hour)) +
  geom_point(mapping = aes(y = average_trips, color = 'avg')) +
  geom_point(mapping = aes(y = sd_trips, color = 'sd')) +
  xlab("Hour of Day") +
  ylab("Num of Trips") +
  scale_color_manual("",
                     breaks = c('avg', 'sd'),
                     values = c('red', 'blue')) +
  facet_wrap(~ wday)
