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

trips %>%
  View

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)

ggplot(trips, aes(x = tripduration / 60)) +
  geom_histogram(bins = 50) +
  scale_x_log10(label = comma) +
  scale_y_continuous(label = comma)

ggplot(trips, aes(x = tripduration / 60)) +
  geom_density(fill = "gray") +
  scale_x_log10(label = comma)

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)

trips %>% 
  ggplot(aes(x = tripduration / 60)) +
  geom_histogram(aes(color = usertype, fill = usertype)) +
  scale_x_log10(label = comma) +
  scale_y_continuous(label = comma)

trips %>%
  ggplot(aes(x = tripduration / 60)) +
  geom_density(aes(color = usertype, fill = usertype)) +
  scale_x_log10(label = comma) +
  scale_y_continuous(label = comma)

# plot the total number of trips on each day in the dataset

trips %>%
  group_by(ymd) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = ymd, y = count)) +
  geom_line()
  
# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  mutate(age = (year(ymd) - birth_year)) %>%
  group_by(age, gender) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = age, y = count, color = gender)) +
  geom_line() +
  ylim(0, 300000)


# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the spread() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered spread() yet)

trips %>%
  mutate(age = year(ymd) - birth_year) %>%
  group_by(age, gender) %>%
  summarize(count = n()) %>%
  pivot_wider(names_from = gender, values_from = count) %>%
  ggplot(aes(x = age, y = Male/Female)) +
  geom_point(aes(size = Male + Female)) +
  geom_smooth(method = "lm") +
  xlim(c(18, 65)) +
  ylim(c(0, 10))

########################################
# plot weather data
########################################

weather %>%
  View

# plot the minimum temperature (on the y axis) over each day (on the x axis)

weather %>%
  ggplot(aes(x = ymd, y = tmin)) +
  geom_line()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the gather() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

weather %>% 
  pivot_longer(c(tmin, tmax), names_to = "min_max", values_to = "temp") %>%
  ggplot(aes(x = ymd, y = temp, color = min_max)) +
  geom_point()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

trips_with_weather %>%
  group_by(ymd, tmin) %>%
  summarise(count = n()) %>%
  ggplot(mapping = aes(x = tmin, y = count)) +
  geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

trips_with_weather_graph <- trips_with_weather %>%
  mutate(substantial_prcp = prcp > mean(prcp) + 2 * sd(prcp)) %>%
  group_by(ymd, tmin, substantial_prcp) %>%
  summarize(count = n()) %>%
  ggplot(mapping = aes(x = tmin, y = count, color = substantial_prcp)) +
  geom_point()

# add a smoothed fit on top of the previous plot, using geom_smooth

trips_with_weather_graph +
  geom_smooth()

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

avg_and_sd_trips <- trips %>%
  mutate(hour = hour(starttime)) %>%
  group_by(ymd, hour) %>%
  summarize(num_trips_per_hour = n()) %>%
  group_by(hour) %>%
  summarize(avg_num_trips_by_hour = mean(num_trips_per_hour), sd_num_trips_by_hour = sd(num_trips_per_hour))

# plot the above

avg_and_sd_trips %>%
  ggplot(aes(x = hour, y = avg_num_trips_by_hour)) +
  geom_line() +
  geom_ribbon(aes(x = hour, 
                  ymin = avg_num_trips_by_hour - sd_num_trips_by_hour, 
                  ymax = avg_num_trips_by_hour + sd_num_trips_by_hour, 
                  alpha = 0.1))

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

trips %>%
  mutate(day_of_week = wday(ymd)) %>% 
  group_by(ymd, day_of_week) %>%
  summarize(num_trips_per_day_of_week = n()) %>%
  group_by(day_of_week) %>%
  summarize(avg_num_trips_per_day_of_week = mean(num_trips_per_day_of_week), 
            sd_num_trips_per_day_of_week = sd(num_trips_per_day_of_week)) %>%
  ggplot(aes(x = day_of_week, y = avg_num_trips_per_day_of_week)) +
  geom_line() +
  geom_ribbon(aes(x = day_of_week,
                  ymin = avg_num_trips_per_day_of_week - sd_num_trips_per_day_of_week,
                  ymax = avg_num_trips_per_day_of_week + sd_num_trips_per_day_of_week,
                  alpha = 0.1))
