########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(lubridate)
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
  filter(tripduration > 0, tripduration < 100000) %>%
  summarize(count = n()) %>%
  ggplot(aes(x=tripduration)) +
  geom_histogram()

trips %>%
  group_by(tripduration) %>%
  filter(tripduration > 0, tripduration < 100000) %>%
  summarize(count = n()) %>%
  ggplot(aes(x=tripduration)) +
  geom_density() +
  scale_x_continuous(label = comma) +
  scale_y_continuous(label = comma)

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
  filter(tripduration > 0, tripduration < 10000) %>%
  ggplot(aes(x=tripduration, fill=usertype)) +
  geom_histogram(position = "identity", alpha = 0.5) + 
  scale_x_log10()

trips %>%
  filter(tripduration > 0, tripduration < 10000) %>%
  ggplot(aes(x=tripduration, fill=usertype)) +
  geom_density(alpha = 0.5) +
  scale_x_log10()

# plot the total number of trips on each day in the dataset
trips %>% 
  group_by(ymd) %>%
  summarize(count=n()) %>%
  ggplot(aes(x=ymd, y = count)) + 
  geom_line()

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
trips %>%
  mutate(age=(year(ymd)-birth_year)) %>%
  filter(age <= 100) %>%
  group_by(age, gender) %>%
  summarize(count=n()) %>%
  pivot_wider(names_from = gender, values_from = count) %>%
  mutate(m2f_ratio = Male/(Female)) %>%
  ggplot(aes(x=age,y=m2f_ratio)) +
  geom_line()

trips %>%
  mutate(age=(year(ymd)-birth_year)) %>%
  filter(age <= 100) %>%
  group_by(age, gender) %>%
  summarize(count=n()) %>%
  pivot_wider(names_from = gender, values_from = count) %>%
  mutate(m2f_ratio = Male/(Female)) %>%
  ggplot(aes(x=age,y=m2f_ratio)) +
  geom_bar(stat = "identity")

# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
ggplot(weather, aes(x=ymd,y=tmin)) +
  geom_line()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
weather %>%
  select(tmax,tmin,ymd) %>%
  pivot_longer(names_to="min_or_max", values_to="temperature",1:2) %>%
  ggplot(aes(x=ymd,y=temperature,color=min_or_max)) +
  geom_line()
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
  group_by(ymd,tmin) %>%
  summarize(count=n()) %>%
  ggplot(aes(x=tmin,y=count)) +
  geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  select(ymd,tmin,prcp) %>%
  mutate(subs_prec=prcp>=.5) %>%
  group_by(ymd,tmin,subs_prec) %>%
  summarize(count=n()) %>%
  ggplot(aes(x=tmin,y=count,color=subs_prec)) +
  geom_point()

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
  select(ymd,tmin,prcp) %>%
  mutate(subs_prec=prcp>=.5) %>%
  group_by(ymd,tmin,subs_prec) %>%
  summarize(count=n()) %>%
  ggplot(aes(x=tmin,y=count,color=subs_prec)) +
  geom_point() +
  geom_smooth()

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
# plot the above
trips %>%
  mutate(hour=hour(starttime)) %>%
  group_by(hour,ymd) %>%
  count() %>%
  group_by(hour) %>%
  summarize(avg=mean(n),sd=sd(n)) %>%
  ggplot(aes(x=hour,y=avg)) +
  geom_point() +
  geom_errorbar(aes(ymin=avg-sd, ymax=avg+sd), width=.2, position=position_dodge(0.05))

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips %>%
  mutate(hour=hour(starttime)) %>%
  mutate(dow=wday(starttime)) %>%
  group_by(hour,dow, ymd) %>%
  count() %>%
  group_by(hour,dow) %>%
  summarize(avg=mean(n),sd=sd(n)) %>%
  ggplot(aes(x=hour,y=avg, color=as.factor(dow))) +
  geom_point()

