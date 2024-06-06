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
load('C:/Users/jane/Documents/Github/coursework/week1/trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
trips%>%
  filter(tripduration > 60)%>%
  ggplot(aes(x = tripduration)) +   
  geom_histogram(binwidth=0.1, fill='blue', color='black', alpha=0.7) +
  scale_x_log10(labels=comma_format()) +
  labs(x='Trip Time', y='Count', title='Histogram of Trip Durations') + 
  xlab('trip time') +
  ylab('count') + 
  theme_minimal() 

trips%>%
    filter(tripduration >60)%>%
    ggplot(aes(x = tripduration)) +
    geom_density(fill = "grey", alpha = 0.6) + 
    scale_x_log10(labels = comma) +  
    xlab('Trip Time') +  
    ylab('Density') +
    ggtitle('Density Plot of Trip Durations') + 
    theme_minimal() 

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips%>%
  filter(tripduration > 60)%>%
  ggplot(aes(x = tripduration, fill = usertype)) +
  geom_histogram(position = "dodge", alpha = 0.6, binwidth = 0.1) + 
  scale_x_log10(labels = comma) +  
  xlab('Trip Time') + 
  ylab('Count') +
  ggtitle('Histogram of Trip Durations') +
  theme_minimal() 


# plot the total number of trips on each day in the dataset

trips%>%
  filter(tripduration >60)%>%
  mutate(date = as.Date(starttime))%>%
  group_by(date) %>%
  summarize(total_trip = n())%>%
  ggplot(aes(x = date, y = total_trip)) +
  geom_line(color = "blue", size = 1) +  
  xlab('Date') +  
  ylab('Total Trips') +  
  ggtitle('Total Number of Trips') +
  scale_x_date(date_labels = "%b %d, %Y", date_breaks = "3 month") +  
  scale_y_continuous(labels = comma) + 
  theme_minimal() 


# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)

trips %>%
  filter(tripduration > 60) %>%
  mutate(
    birth_year = as.numeric(birth_year),
    age = as.numeric(format(Sys.Date(), "%Y")) - birth_year
  ) %>%
  group_by(gender, age) %>%
  summarize(total_trip = n(), .groups = 'drop') %>%
  ggplot(aes(x = age, y = total_trip, color = gender)) +
  geom_line(size = 1) +  
  labs(
    title = "Total Number of Trips by Age and Gender",
    x = "Age",
    y = "Total Number of Trips",
    color = "Gender"
  ) +
  scale_y_continuous(labels = comma) +  
  theme_minimal() 


# plot the ratio of male to female trips (on the y axis) by age (on the x axis)


# Calculate the ratio of male to female trips by age
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
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
  group_by(ymd, tmin) %>%
  summarize(total_trips = n(), .groups = 'drop')%>%
  ggplot(aes(x = tmin, y = total_trips)) +
  geom_point(color = "red", size = 3, alpha = 0.7) +  
  labs(
    title = "Number of Trips as a Function of Minimum Temperature",
    x = "Minimum Temperature (°C)",
    y = "Number of Trips"
  ) +
  theme_minimal()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
# add a smoothed fit on top of the previous plot, using geom_smooth

trips_with_weather %>%
  mutate(substantial_precipitation = (prcp > 0.00936& snow >0.0108))%>%
  group_by(ymd, tmin, substantial_precipitation) %>%
  summarize(total_trips = n(), .groups = 'drop') %>%
  ggplot(aes(x = tmin, y = total_trips, color = substantial_precipitation)) +
  geom_point() +
  labs(title = "Number of Trips as a Function of Minimum Temperature",
       x = "Minimum Temperature (°C)",
       y = "Number of Trips",
       color = "Substantial Precipitation") + 
  geom_smooth() +
  scale_color_manual(values = c("TRUE" = "orange", "FALSE" = "skyblue"),
                     labels = c("TRUE" = "Yes", "FALSE" = "No")) +
  theme_minimal()
  



# compute the average number of trips and standard deviation by day in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

trips_with_weather%>%
  mutate(hour = hour(starttime))%>%
  group_by(hour,ymd)%>%
  mutate(count = n())%>%
  group_by(hour)%>%
  summarize(avg_trip = mean(count), 
            standard_dev = sd(count)
  )%>%
  ggplot(aes(x = factor(hour), y = avg_trip)) +
  geom_bar(stat = "identity", fill = "gray") +
  geom_errorbar(aes(ymin = avg_trip - standard_dev, ymax = avg_trip + standard_dev),
                width = 0.2, color = "orange") +
  labs(
    title = "Average Number of Trips per Hour of the Week",
    x = "Hour of the Week",
    y = "Average Number of Trips"
  )+ 
  theme_minimal()
# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather%>%
  mutate(day = wday(starttime))%>%
  group_by(day,ymd)%>%
  mutate(count = n())%>%
  group_by(day)%>%
  summarize(avg_trip = mean(count), 
            standard_dev = sd(count)
  )%>%
  ggplot(aes(x = factor(day), y = avg_trip)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  geom_errorbar(aes(ymin = avg_trip - standard_dev, ymax = avg_trip + standard_dev),
                width = 0.2, color = "red") +
  labs(
    title = "Average Number of Trips per Day of the Week",
    x = "Day of the Week",
    y = "Average Number of Trips"
  )+ 
  theme_minimal()

