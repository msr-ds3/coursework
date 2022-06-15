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
fill = gende

########################################
# plot trip data
########################################
View(trips)

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
trips %>% ggplot(mapping = aes(x = tripduration)) + 
  geom_histogram() + 
  scale_x_log10(label = comma)
trips %>% ggplot(mapping = aes(x = tripduration)) + 
  geom_density(fill = 'grey') +
  scale_x_log10(label = comma)

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>% ggplot(mapping = aes(x = tripduration, color = gender)) + 
  geom_histogram(mapping = aes(fill = gender))+ 
  scale_x_log10(label = comma)
trips %>% ggplot(mapping = aes(x = tripduration, color = gender)) + 
  geom_density(mapping = aes(fill = gender))+ 
  scale_x_log10(label = comma)

# plot the total number of trips on each day in the dataset
trips %>% ggplot(mapping = aes(x = ymd)) + 
  geom_bar() + ylab('Total number of trips')

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>% mutate(age = 2014 - birth_year) %>% 
  ggplot(mapping = aes(x = age, fill = gender)) +
  geom_bar(alpha = 1/5) +
  ylab("Total number of trips")

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

trips %>% 
  mutate(age = 2014 - birth_year) %>% 
  group_by(age, gender) %>%
  summarize(count = n()) %>% 
  pivot_wider(names_from = gender, values_from = count) %>%
  mutate(ratio = Male / Female) %>%
  ggplot(mapping = aes(x = age, y = ratio)) +
  geom_point()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>% ggplot(mapping = aes(x = date, y = tmin)) +
  geom_point() + 
  theme(axis.text.x = element_text(angle = 90, size = 5))
#there's too many overlapping labels

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

weather %>%
  pivot_longer(c('tmin', 'tmax'), names_to = 'min_max', values_to = 'temp') %>%
  group_by(date, min_max) %>%
  ggplot(mapping = aes(x = date, color = min_max)) +
  geom_point(mapping = aes(y = temp)) + 
  xlab("Day") +
  ylab("Temperature")

########################################
# plot trip and weather data
########################################

library(lubridate)

# original weather dataframe had NA values for the ymd column so I created a new
# dataframe "weather1" with the correct ymd column

weather1 <- weather %>% mutate(ymd = as.Date(parse_datetime(date, '%Y-%m-%d')))

# join trips and weather
trips_with_weather <- inner_join(trips, weather1, by = "ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_by_date <- trips %>% group_by(ymd) %>% summarize(count = n())
mintempday <- inner_join(trips_by_date, weather1, by = 'ymd')
mintempday %>% ggplot(mapping = aes(x = tmin, y = count)) + geom_point() +
  ylab("Number of trips")

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
mintempday %>% mutate(sub_prcp = prcp>=0.3) %>% ggplot(mapping = aes(x = tmin, y = count, color = sub_prcp)) + 
  geom_point()

# add a smoothed fit on top of the previous plot, using geom_smooth
mintempday %>% mutate(sub_prcp = prcp>=0.3) %>% ggplot(mapping = aes(x = tmin, y = count)) + 
  geom_point(mapping = aes(color = sub_prcp)) +
  geom_smooth()

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>% 
  mutate(hour = hour(starttime)) %>%
  group_by(ymd, hour) %>% 
  summarize(num_trips = n()) %>%
  group_by(hour) %>% 
  summarize(average_trips = mean(num_trips),
            sd_trips = sd(num_trips))

# plot the above
trips_with_weather %>% 
  mutate(hour = hour(starttime)) %>%
  group_by(ymd, hour) %>% 
  summarize(num_trips = n()) %>%
  group_by(hour) %>% 
  summarize(average_trips = mean(num_trips),
            sd_trips = sd(num_trips)) %>%
  ggplot() +
  geom_point(mapping = aes(x = hour, y = average_trips, color = 'avg')) +
  geom_point(mapping = aes(x = hour, y = sd_trips, color = 'sd')) + 
  xlab("Hour of Day") +
  ylab("Num of Trips") +
  scale_color_manual("", 
                     breaks = c('avg', 'sd'), 
                     values = c('red', 'blue'))


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


