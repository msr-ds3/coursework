########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)
library(lubridate)
library(cowplot)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')
########################################


########################################
# plot trip data

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
summary(trips$tripduration)

hist1 <- trips %>%
  ggplot(aes(x = tripduration/60)) +
  geom_histogram(bins = 100, color='red', fill = 'red', alpha = 0.4) + 
  scale_x_continuous(limits = c(0, 120), breaks = pretty_breaks(n=6)) +
  scale_y_continuous(label = comma, breaks = pretty_breaks(n=8)) +
  labs(x = "Trip duration in minutes", y="no. of trips", title = "Trip times across all rides")

dense1 <- trips %>%
  ggplot(aes(x = tripduration/60)) +
  geom_density(color= 'blue', fill = 'blue', alpha = 0.4) + 
  scale_x_continuous(limits = c(0, 120), breaks = pretty_breaks(n=12)) +
  scale_y_continuous(label = comma, breaks = pretty_breaks(n=8)) +
  labs(x = "Trip duration in minutes", title = "Trip times across all rides")

plot_grid(hist1, dense1, ncol = 1)



# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
hist2 <- trips %>%
  ggplot(aes(x = tripduration/60, fill = usertype, color = usertype, alpha = 0.7)) +
  geom_histogram(bins=60) +
  xlim(0, 60) +
  scale_y_continuous(label=comma) +
  facet_wrap(~ usertype, scale = 'free_y') +
  labs(x = "Trip duration in minutes", title = "Trip times across all rides")

dense2 <- trips %>%
  ggplot(aes(x = tripduration/60, fill = usertype)) +
  geom_density() +
  xlim(0, 60) +
  facet_wrap(~ usertype) +
  labs(x = "Trip duration in minutes", title = "Trip times across all rides")

plot_grid(hist2, dense2, ncol = 1)


# plot the total number of trips on each day in the dataset
trips %>%
  group_by(ymd) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = ymd, y= count)) +
  geom_point(aes(color = factor(month(ymd), levels= 1:12, labels = month.name))) + 
  geom_smooth() + 
  labs(x = "day", y = "no. of trips", title = "No. of trips in each day", color = "month") 


# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  select(birth_year, gender) %>%
  mutate(age = 2014 - birth_year) %>%
  count(age, gender) %>%
  filter(!(n > 1250 & gender == 'Unknown')) %>%
  ggplot(aes(x = age, y = n)) +
  geom_line(aes(color = gender)) +
  geom_point(aes(color = gender)) + 
  scale_y_continuous(label=comma) + 
  facet_wrap(~ gender, ncol = 1, scales = 'free') 
  

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the spread() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered spread() yet)
trips %>%
  select(gender, birth_year) %>%
  mutate(age = 2014 - birth_year) %>%
  group_by(age, gender) %>% 
  summarise(count = n()) %>%
  pivot_wider(names_from = gender, values_from = count) %>% 
  ggplot(aes(x = age, y = Male/Female)) +
  geom_point() +
  geom_line() +
  geom_smooth()
  



########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
  ggplot(aes(x=ymd, y = tmin)) +
  geom_point(aes(color = factor(month(ymd), levels= 1:12, labels = month.name))) + 
  geom_smooth() +
  labs(x = 'days', y = 'min_temperature', color = 'Month')



# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the gather() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
  select(ymd, tmax, tmin) %>%
  pivot_longer(cols = c("tmax", "tmin"), names_to = "temperature_type", values_to = "temperature") %>%
  ggplot(aes(x = ymd, y = temperature, color = temperature_type)) +
  geom_point() +
  geom_smooth()



########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  select(tmin, ymd) %>%
  group_by(ymd, tmin) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = tmin, y = count)) + 
  geom_point(aes(size = count, color = tmin))


# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  select(tmin, ymd, prcp) %>%
  mutate(prcp_test = prcp > 0.1) %>% 
  group_by(ymd, tmin, prcp_test) %>%
  summarise(count = n()) %>%
  ungroup() %>%
  ggplot(aes(x = tmin, y = count, color = prcp_test)) + 
  geom_point() +
  facet_wrap(~ prcp_test) +

# add a smoothed fit on top of the previous plot, using geom_smooth
  geom_smooth()

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
avg_sd_trips <- trips %>%
  select(starttime, ymd) %>%
  mutate(hour = hour(starttime)) %>%
  group_by(hour) %>%
  count(ymd) %>%
  summarise(avg = mean(n), sd = sd(n)) 
  
# plot the above
avg_sd_trips %>%
  pivot_longer(cols = c("avg", "sd"), names_to = "metric", values_to = "val") %>%
  ggplot(aes(x = hour, y = val, color = metric, size = val)) +
  geom_point()


# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips %>%
  select(ymd, starttime) %>%
  mutate(day = wday(ymd), hour = hour(starttime)) %>%
  group_by(hour, day) %>%
  count(ymd) %>%
  summarize(avg = mean(n), sd = sd(n)) %>% 
  mutate(day = factor(day, levels = c(1, 2, 3, 4, 5, 6, 7), labels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))) %>%
  pivot_longer(cols = c("avg", "sd"), names_to = "metric", values_to = "val") %>%
  ggplot(aes(x = hour, y= val, color = metric, size = val)) + 
  geom_point() + 
  facet_wrap(~ day, scale = 'free_y')
