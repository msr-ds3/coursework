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

trips %>%
  count(tripduration) %>%
  ggplot(aes(x=tripduration/3600)) +
  geom_histogram() +
  scale_x_log10(label=comma)

trips %>%
  count(tripduration) %>%
  ggplot(aes(x=tripduration/3600)) +
  geom_density() +
  scale_x_log10(label=comma)

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)

trips %>%
  ggplot(aes(x=tripduration, color=usertype, fill=usertype)) +
  geom_histogram(position="identity", alpha=0.5) + #identity puts the bars in each other, alpha makes them transparent
  geom_vline(aes(xintercept = mean(tripduration) ), linetype = "dashed") +
  scale_x_log10(label=comma)

trips %>%
  ggplot(aes(x=tripduration, color=usertype, fill=usertype)) +
  geom_density() + # Normalizes both of them to make the area under the curve equal to 1, basically says where the tripduration is likely to be
  scale_x_log10(label=comma)

# plot the total number of trips on each day in the dataset

trips %>%
  mutate(date = date(starttime)) %>%
  ggplot(aes(x=date)) +
  geom_histogram() +
  xlab("Days") +
  ylab("Number of trips") +
  scale_y_continuous(label=comma)

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)

trips %>%
  ggplot(aes(x=birth_year, color=gender)) +
  geom_histogram(position="dodge", alpha=0.5) +
  scale_y_continuous(label=comma)

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

trips %>%
  group_by(gender) %>%
  count(birth_year) %>%
  pivot_wider(names_from=gender, values_from=n) %>%
  mutate(ratio=Male/Female) %>%
  ggplot(aes(x=birth_year, y=ratio)) +
  geom_point()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

weather %>%
  ggplot(aes(x=date(date), y=tmin)) +
  geom_point()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

weather %>%
  pivot_longer(names_to="type", values_to="temp", 5:6) %>%
  ggplot(aes(x=date(date), y=temp, color=type)) +
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
  group_by(date) %>%
  summarize(count=n(), tmin = tmin[1]) %>%
  ggplot(aes(x=tmin, y=count)) +
  geom_point() +
  geom_smooth()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  group_by(date) %>%
  summarize(count=n(), tmin = tmin[1], substantial_prec = prcp[1] > 1.0) %>%
  ggplot(aes(x=tmin, y=count, color=substantial_prec)) +
  geom_point() +
  geom_smooth()

# add a smoothed fit on top of the previous plot, using geom_smooth

# compute the (average number of trips and standard deviation) in (number of trips by hour of the day)
# hint: use the hour() function from the lubridate package

trips_with_weather %>%
  mutate(hour=hour(starttime)) %>%
  group_by(hour, date) %>%
  count() %>%
  group_by(hour) %>%
  summarize(mean = mean(n), sd = sd(n)) %>%
    ggplot(aes(x=hour, y=mean)) +
    geom_point() +
    geom_errorbar(aes(ymin= mean - sd, ymax=mean+sd), width=.2,
                  position=position_dodge(0.05)) +
    labs(x="Hour", y="Number of Trips")

# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

trips_with_weather %>%
  mutate(hour=hour(starttime)) %>%
  group_by(hour, date) %>%
  count() %>%
  mutate(dow=wday(date)) %>%
  group_by(dow, hour) %>%
  summarize(mean = mean(n), sd = sd(n)) %>%
    ggplot(aes(x=hour, y=mean, color=as.factor(dow))) +
    geom_point() +
    labs(x="Hour", y="Number of Trips")
