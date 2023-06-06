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
  group_by(tripduration) %>%
  summarize(count = n()) %>%
  ggplot(aes(x=tripduration)) +
  geom_histogram()

    # modified histogram with log
    trips %>%
      ggplot(aes(x = tripduration)) +
      geom_histogram(bins = 10)+ scale_x_log10()

# density plot
trips %>%
  group_by(tripduration) %>%
  filter(tripduration <= 100000) %>%
  summarize(count = n()) %>%
  ggplot(aes(x=tripduration)) +
  geom_density() +
  scale_x_log10(label = comma) 

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
# histogram
trips %>%
  filter(tripduration < 10000) %>%
  ggplot(aes(x=tripduration, fill=usertype)) +
  geom_histogram(position = "identity", alpha = 0.5) + 
  scale_x_log10()

# distribution using geom_density
trips %>%
  filter(tripduration <= 1e4) %>%
  ggplot(aes(x=tripduration, fill = usertype)) + geom_density(alpha = 0.5) + scale_x_log10()


# plot the total number of trips on each day in the dataset
trips %>% 
  mutate(date = as.Date(ymd)) %>% 
  group_by(date) %>%
  summarize(count = n()) %>%
  ggplot(aes(date, count)) + 
  geom_line()

# bar plot
trips %>% 
  group_by(ymd) %>%
  summarize(count=n()) %>%
  ggplot(aes(x=ymd, y = count)) + 
  geom_bar(stat = "identity")

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  mutate(age=(year(ymd)-birth_year)) %>%
  group_by(age, gender) %>%
  summarize(count=n()) %>%
  ggplot(aes(x=age,y=count,color = gender)) +
  geom_line()


# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

trips %>%
  mutate(age=(year(ymd)-birth_year)) %>%
  filter(age <= 100) %>%
  group_by(age, gender) %>%
  summarize(count=n()) %>%
  pivot_wider(names_from = gender, values_from = count) %>%
  mutate(ratio = Male/Female) %>%
  ggplot(aes(x=age,y=ratio)) +
  geom_bar(stat = "identity")

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
  group_by(ymd) %>%
  ggplot(aes(x=ymd, y =tmin)) +
  geom_line()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
  select(tmin, tmax, ymd) %>%
  pivot_longer(names_to = "min_or_max", values_to = "temp", 1:2) %>%
  ggplot(aes(x=ymd, y = temp, color = min_or_max)) +
  geom_line()


########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  group_by(ymd, tmin) %>%
  summarize(num_of_trips = n()) %>%
  ggplot(aes(x = ymd, y= num_of_trips)) + 
  geom_line()
  

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  mutate(substantial_precipitation = prcp > 0) %>%
  group_by(ymd, tmin, substantial_precipitation) %>%
  summarize( num_of_trips_w_prcp = n()) %>%
  ggplot(aes(x = ymd, y = num_of_trips_w_prcp, color = substantial_precipitation )) + 
  geom_point()+
  geom_smooth(method = "lm")  # add a smoothed fit on top of the previous plot, using geom_smooth
  
  


# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>%
  mutate(hour = hour(starttime)) %>%
  group_by(hour, ymd)%>%
  summarize(trips_per_hour = n()) %>%
  group_by(hour) %>%
  summarize(avg_trips_per_hour = mean(trips_per_hour), sd_trips_per_hour = sd(trips_per_hour))
  

# plot the above
trips_with_weather %>%
  mutate(hour = hour(starttime)) %>%
  group_by(hour, ymd)%>%
  summarize(trips_per_hour = n()) %>%
  group_by(hour) %>%
  summarize(avg_trips_per_hour = mean(trips_per_hour), sd_trips_per_hour = sd(trips_per_hour)) %>%
  ggplot(aes(x = hour, y = avg_trips_per_hour)) +
  geom_errorbar(aes(ymin = avg_trips_per_hour - sd_trips_per_hour, ymax = avg_trips_per_hour + sd_trips_per_hour))+
  geom_point() +
  labs(x = "hours of the day", y = "average trips by hours(with standard error shown)")

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather %>%
  mutate(day = wday(starttime)) %>%
  group_by(day, ymd)%>%
  summarize(trips_per_day = n()) %>%
  group_by(day) %>%
  summarize(avg_trips_per_day = mean(trips_per_day), sd_trips_per_day = sd(trips_per_day)) %>%
  ggplot(aes(x = day, y = avg_trips_per_day)) +
  geom_errorbar(aes(ymin = avg_trips_per_day - sd_trips_per_day, ymax = avg_trips_per_day + sd_trips_per_day))+
  geom_point() +
  labs(x = "days of the week", y = "average trips by day of the week")