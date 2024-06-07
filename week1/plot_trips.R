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

# histogram
trips %>%
  filter(tripduration > 60) %>%
  ggplot(aes(x = tripduration)) +
  geom_histogram() + 
  scale_x_log10(label = comma) +
  labs(title = "Distribution of Trip Times",
       x = "Trip Time",
       y = "Frequency")

# density
trips %>%
  filter(tripduration > 60) %>%
  ggplot(aes(x = tripduration)) +
  geom_density(fill = "grey") + 
  scale_x_log10(label = comma) +
  labs(title = "Distribution of Trip Times",
       x = "Trip Time",
       y = "Frequency")


# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)

#histogram
trips %>%
  filter(tripduration > 60) %>%
  ggplot(aes(x = tripduration, color = usertype)) +
  geom_histogram() +
  scale_x_log10(label = comma) 
  labs(title = "Distribution of Trip Times by Rider Type",
       x = "trip Time",
       y = "Frequency")
  
#density
trips %>%
  filter(tripduration > 60) %>%
  ggplot(aes(x = tripduration,fill=usertype, color = usertype)) +
  geom_density() +
  scale_x_log10(label = comma) 
  labs(title = "Distribution of Trip Times by Rider Type",
     x = "trip Time",
     y = "Frequency")
  
# plot the total number of trips on each day in the dataset

trips %>%
  filter(tripduration > 60) %>%
  mutate(start_date = as.Date(starttime)) %>%  
  group_by(start_date) %>%
  summarise(total_trips = n()) %>%
  ggplot(aes(x = start_date, y = total_trips)) +
  geom_line() +
  labs(title = "Total Number of Trips per Day",
       x = "Date",
       y = "Total Trips")


# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
  # getting the year in a date format
  mutate(age = c(2024L, as.integer(format(Sys.Date(), "%Y"))) - as.numeric(birth_year)) %>%
  group_by(age, gender) %>%
  summarize(total_trips = n()) %>%
  ggplot(aes(x = age, y = total_trips, color = gender)) +
  geom_line() +
  labs(title = "Total Number of Trips by Age and Gender",
       x = "Age",
       y = "Total Trips",
       color = "Gender")
head(trips) %>% view()

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

trips %>%
  mutate(age = 2024 - as.numeric(birth_year)) %>%
  group_by(gender, age) %>%
  summarize(count = n(), .groups = 'drop') %>%
  pivot_wider(names_from = gender, values_from = count, values_fill = list(count = 0)) %>%
  mutate(ratio = ifelse(Female == 0, NA, Male / Female)) %>%
  ggplot(aes(x = age, y = ratio)) +
  geom_point() +
  labs(title = "Ratio of Male to Female Trips by Age",
       x = "Age",
       y = "Male to Female Trip Ratio")
       
       
########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

weather%>%
  ggplot(aes(x = DATE, y = TMIN)) +
  geom_line() +
  labs(title = "Minimum Temperature Over Each Day",
       x = "Date",
       y = "Minimum Temperature")



# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
  pivot_longer(names_to = "Temp", values_to = "Temperature", 10:11) %>%
  ggplot(aes(x = DATE, y = Temperature, color = Temp)) +
  geom_line()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")
trips_with_weather %>% head(10) %>% View()
# view(trips_with_weather)

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

trips_with_weather %>%
  group_by(ymd, tmin) %>%
  summarize(total_trips = n())%>%
  ggplot(aes(x = tmin, y = total_trips)) +
  geom_point() + labs(title = "Number of Trips as a Function of Minimum Temperature",
                      x = "Minimum Temperature (°C)",
                      y = "Number of Trips")

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

mean_prcp <- mean(trips_with_weather$prcp)
mean_snow <- mean(trips_with_weather$snow)

trips_with_weather %>%
  group_by(ymd, tmin, prcp, snow) %>%
  summarize(total_trips = n()) %>%
  mutate(substantial_precipitation = (prcp > mean_prcp & snow > mean_snow)) %>%
  ggplot(aes(x = tmin, y = total_trips, color = substantial_precipitation)) +
  geom_point() + labs(title = "Number of Trips as a Function of Minimum Temperature",
                      x = "Minimum Temperature (°C)",
                      y = "Number of Trips",
                      color = "Substantial Precipitation")

# add a smoothed fit on top of the previous plot, using geom_smooth

mean_prcp <- mean(trips_with_weather$prcp)
mean_snow <- mean(trips_with_weather$snow)

trips_with_weather %>%
  group_by(ymd, tmin, prcp, snow) %>%
  summarize(total_trips = n()) %>%
  mutate(substantial_precipitation = (prcp > mean_prcp & snow > mean_snow)) %>%
  ggplot(aes(x = tmin, y = total_trips, color = substantial_precipitation)) +
  geom_point() + 
  geom_smooth() +
  labs(title = "Number of Trips as a Function of Minimum Temperature",
                      x = "Minimum Temperature (°C)",
                      y = "Number of Trips",
                      color = "Substantial Precipitation")


# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
# plot

trips_with_weather %>%
  mutate(hour = hour(starttime)) %>%
  group_by(hour) %>%
  summarise(average_trips = mean(tripduration), sd_trips = sd(tripduration), .groups = 'drop') %>%
  ggplot(aes(x = hour, y = average_trips)) +
  geom_line() +
  labs(title = "Average Number of Trips by Hours of the Day",
       x = "Hour of the day",
       y = "Average number of Trips")
  


# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

trips_with_weather %>%
  mutate(hour = hour(starttime), weekday = wday(starttime)) %>%
  group_by(hour, weekday) %>%
  summarise(average_trips = mean(tripduration), sd_trips = sd(tripduration)) %>%
  ggplot(aes(x = hour, y = average_trips, color = weekday)) +
  geom_line() +
  labs(title = "Average Number of Trips by Hour and Day of the Week",
       x = "Hour of the day",
       y = "Average number of Trips",
       color = "Day of the Week")
