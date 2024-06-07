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
trips |> 
  filter(tripduration <= 3600) |> 
  ggplot(aes(x = tripduration)) +
  geom_histogram() +
  scale_y_continuous(label = comma)
trips |> 
  filter(tripduration <= 3600) |> 
  ggplot(aes(x = tripduration)) +
  geom_density()
  
# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips |> 
  filter(tripduration <= 3600) |> 
  ggplot(aes(x = tripduration, color = usertype, fill = usertype)) +
  geom_histogram() +
  scale_y_continuous(label = comma) +
  facet_wrap(~ usertype)
trips |> 
  filter(tripduration <= 3600) |> 
  ggplot(aes(x = tripduration, color = usertype, fill = usertype)) +
  geom_density() +
  scale_y_continuous(label = comma) +
  facet_wrap(~ usertype)
# plot the total number of trips on each day in the dataset
trips |> 
  mutate(days = date(starttime)) |> 
  group_by(days) |> 
  summarise(num_of_rides = n()) |> 
  ggplot(aes(x = days, y = num_of_rides)) +
  geom_point() +
  geom_line()

  
# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)

trips |> 
  mutate(age = 2014 - birth_year) |> 
  group_by(age, gender) |> 
  summarise(num_rides_by_age = n()) |> 
  ggplot(aes(x = age, y = num_rides_by_age, color = gender)) +
  geom_point() +
  coord_cartesian(ylim = c(0,300000)) +
  scale_y_continuous(labels = comma)

  
# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips |> 
  mutate(age = 2014 - birth_year) |> 
  select(age, gender) |> 
  group_by(age, gender) |> 
  summarise(num_trips = n()) |> 
  pivot_wider(names_from = gender, values_from = num_trips) |> 
  mutate(male_female_ratio = Male/Female) |> View()
  ggplot(aes(x = age, y = male_female_ratio)) +
  geom_point()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather |> 
  ggplot(aes(x = ymd, y = tmin)) +
  geom_point()
# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)

# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather |> 
  select(ymd, tmin, tmax) |>
  pivot_longer(names_to = "min_max", values_to = "temp", -ymd) |> 
  group_by(ymd) |> 
  ggplot(aes(x = ymd, y = temp, color = min_max)) +
  geom_point()
  

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather |> 
  group_by(ymd) |> 
  summarise(num_of_trips = n(),
            min_temp = min(tmin)) |> 
  ggplot(aes(x = min_temp, y = num_of_trips)) +
  geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather |> 
  mutate(sub_prcp = prcp > .2) |> 
  group_by(ymd, sub_prcp) |> 
  summarise(num_of_trips = n(),
            min_temp = min(tmin)) |> 
  ggplot(aes(x = min_temp, y = num_of_trips, color = sub_prcp)) +
  geom_point()
  
# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather |> 
  mutate(sub_prcp = prcp > .2) |> 
  group_by(ymd, sub_prcp) |> 
  summarise(num_of_trips = n(),
            min_temp = min(tmin)) |> 
  ggplot(aes(x = min_temp, y = num_of_trips, color = sub_prcp)) +
  geom_point() +
  geom_smooth()
# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather |> 
  mutate(hour = hour(starttime)) |>
  group_by(ymd, hour) |> 
  summarise(trips_taken = n()) |> 
  group_by(hour) |> 
  summarise(avg_trips_taken = mean(trips_taken),
            sd_trips_taken = sd(trips_taken))

  # plot the above
trips_with_weather |> 
  mutate(hour = hour(starttime)) |>
  group_by(ymd, hour) |> 
  summarise(trips_taken = n()) |> 
  group_by(hour) |> 
  summarise(avg_trips_taken = mean(trips_taken),
            sd_trips_taken = sd(trips_taken)) |> 
  ggplot(aes(x = hour, y = avg_trips_taken)) +
  geom_ribbon(aes(ymin = avg_trips_taken - sd_trips_taken, 
                  ymax = avg_trips_taken + sd_trips_taken), 
              fill = "lightblue", alpha = 0.3) +
  geom_line(color = "blue")

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
  trips_with_weather |> 
    mutate(hour = hour(starttime), day_of_week = wday(starttime, label = TRUE)) |>
    group_by(ymd, hour, day_of_week) |> 
    summarise(trips_taken = n(),
              .groups = 'drop') |> 
    group_by(hour, day_of_week) |> 
    summarise(avg_trips_taken = mean(trips_taken),
              sd_trips_taken = sd(trips_taken),
              .groups = 'drop') |>
    ggplot(aes(x = hour, y = avg_trips_taken)) +
    geom_ribbon(aes(ymin = avg_trips_taken - sd_trips_taken, 
                    ymax = avg_trips_taken + sd_trips_taken,
                    fill = as.factor(day_of_week), alpha = 0.3)) +
    geom_line(aes(color = as.factor(day_of_week))) +
    facet_wrap(~ day_of_week)

