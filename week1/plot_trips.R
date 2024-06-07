########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)
setwd("C:/Users/yino/coursework/week1")

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################


# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)

library(ggplot2)
library(dplyr)

# Assuming your data frame is named `trips`

?diamonds


# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
# Histogram

trips %>%
  filter(tripduration <= 3600) %>%
  ggplot(aes(x = tripduration, fill = usertype)) +
  geom_histogram(position = "identity", alpha = 0.5, bins = 50) +
  scale_y_continuous(labels = comma)+
  labs(title = "Distribution of Trip Times by Rider Type", x = "Trip Duration (seconds)", y = "Count") +
  scale_fill_manual(values = c("Subscriber" = "blue", "Customer" = "red"))


# density 
trips %>%
  filter(tripduration <= 3600) %>%
  ggplot(aes(x = tripduration, fill = usertype, color = usertype)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of Trip Times by Rider Type", x = "Trip Duration (seconds)", y = "Density") +
  scale_y_continuous(labels = comma)+
  scale_fill_manual(values = c("Subscriber" = "blue", "Customer" = "red")) +
  scale_color_manual(values = c("Subscriber" = "blue", "Customer" = "red"))

# plot the total number of trips on each day in the dataset

trips %>%
  mutate(day = floor_date(as.Date(starttime), "day")) %>%
  group_by(day) %>%
  summarise(total_trips = n()) %>%
  ggplot(aes(x = day, y = total_trips)) +
  geom_col(color = "blue", fill = "lightblue") +
  scale_x_date(labels = date_format("%Y-%m"), date_breaks = "1 month") +
  labs(title = "Total Number of Trips Per Month", x = "day", y = "Total Trips") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)

trips %>%
  mutate(age = birth_year) %>%
  group_by(age, gender) %>%
  summarise(total_trips = n()) %>%
  ggplot(aes(x = age, y = total_trips, color = gender, fill = gender)) +
  geom_col(position = "dodge", alpha = 0.7) +
  scale_y_continuous(labels = comma) +  
  labs(title = "Total Number of Trips by Age and Gender", x = "Age", y = "Total Trips") +
  theme_minimal()

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

trips %>%
  group_by(gender, birth_year) %>%
  summarise(total_trips = n()) %>%
  pivot_wider(names_from = gender, values_from = total_trips) %>%
  mutate(ratio = Male / Female) %>%
  ggplot(aes(x = birth_year, y = ratio)) +
  geom_line(color = "pink")

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

weather %>%
  mutate(date = as.Date(date)) %>%
  group_by(date) %>%
  summarise(min_temp = min(tmin, na.rm = TRUE)) %>%
  ggplot(aes(x = date, y = min_temp)) +
  geom_line() +
  scale_x_date(labels = date_format("%Y-%m-%d"), date_breaks = "1 month") +
  labs(title = "Minimum Temperature Over Each Day", x = "Date", y = "Minimum Temperature (F)") +
  theme_minimal()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

weather %>%
  mutate(date = as.Date(date)) %>%
  group_by(date) %>%
  summarise(min_temp = min(tmin, na.rm = TRUE), max_temp = max(tmax, na.rm = TRUE)) %>%
  pivot_longer(cols = c(min_temp, max_temp), names_to = "temperature_type", values_to = "temperature") %>%
  ggplot(aes(x = date, y = temperature, color = temperature_type)) +
  geom_line() 
########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

trips_with_weather %>%
  mutate(date = as.Date(ymd)) %>%
  group_by(date) %>%
  summarise(total_trips = n(), min_temp = min(tmin, na.rm = TRUE)) %>%
  ggplot(aes(x = min_temp, y = total_trips)) +
  geom_point(color = "blue") +
  labs(x = "Minimum Temperature (°F)", y = "Number of Trips") +
  theme_minimal()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
  mutate(date = as.Date(ymd),
         substantial_precip = prcp >= 1.0) %>%
  group_by(date, substantial_precip) %>%
  summarise(total_trips = n(), min_temp = min(tmin, na.rm = TRUE)) %>%
  ggplot(aes(x = min_temp, y = total_trips, color = substantial_precip)) +
  geom_point() +
  labs(
       x = "Minimum Temperature (°F)",
       y = "Number of Trips",
       color = "Substantial Precipitation") +
  theme_minimal()



# add a smoothed fit on top of the previous plot, using geom_smooth

trips_with_weather %>%
  mutate(date = as.Date(ymd),
         substantial_precip = prcp >= 1.0) %>%
  group_by(date, substantial_precip) %>%
  summarise(total_trips = n(), min_temp = min(tmin, na.rm = TRUE)) %>%
  ggplot(aes(x = min_temp, y = total_trips, color = substantial_precip)) +
  geom_point() +
  labs(
    x = "Minimum Temperature (°F)",
    y = "Number of Trips",
    color = "Substantial Precipitation") +
  theme_minimal()+
  geom_smooth(method = "loess", se = FALSE)

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

trips_with_weather %>%
  mutate(hour = hour(starttime),
         date = as.Date(starttime)) %>%
  group_by(hour, date) %>%
  summarise(trips_per_hour = n()) %>%
  group_by(hour) %>%
  summarise(
    average_trips = mean(trips_per_hour),
    sd_trips = sd(trips_per_hour)
  ) %>%
  arrange(hour)

# Display the results

# hour average_trips sd_trips
# <int>         <dbl>    <dbl>
# 1    17         1955.    1084.
# 2    18         1922.    1106.
# 3    19         1538.     772.
# 4    16         1515.     721.
# 5    13         1451.     757.
# 6    12         1369.     886.
# 7    14         1325.     634.
# 8    15         1322.     652.
# 9    20         1275.     680.
# 10    21         1230.     989.
# ℹ 14 more rows

# plot the above

trips_with_weather %>%
  mutate(hour = hour(starttime),
         date = as.Date(starttime)) %>%
  group_by(hour, date) %>%
  summarise(trips_per_hour = n()) %>%
  group_by(hour) %>%
  summarise(
    average_trips = mean(trips_per_hour),
    sd_trips = sd(trips_per_hour)
  ) %>%
  arrange(desc(average_trips)) %>%
  ggplot(aes(x = hour, y = average_trips)) +
  geom_col(fill = "lightblue", color = "blue") +
  geom_errorbar(aes(ymin = average_trips - sd_trips, ymax = average_trips + sd_trips), width = 0.2) +
  labs(
       x = "Hour of the Day",
       y = "Average Number of Trips") +
  theme_minimal()

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

trips_with_weather %>%
  mutate(hour = hour(starttime),
         day_of_week = wday(starttime, label = TRUE),
         date = as.Date(starttime)) %>%
  group_by(hour, day_of_week, date) %>%
  summarise(trips_per_hour = n()) %>%
  group_by(hour, day_of_week) %>%
  summarise(
    average_trips = mean(trips_per_hour),
    sd_trips = sd(trips_per_hour)
  ) %>%
  ggplot(aes(x = hour, y = average_trips, fill = day_of_week)) +
  geom_col(position = position_dodge(width = 0.9), color = "blue", alpha = 0.6) +
  geom_errorbar(aes(ymin = average_trips - sd_trips, ymax = average_trips + sd_trips), 
                position = position_dodge(width = 0.9), width = 0.25) +
  labs(
    x = "Hour of the Day",
    y = "Average Number of Trips",
    fill = "Day of Week") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
