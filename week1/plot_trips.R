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
ggplot(trips, aes(x = tripduration)) + geom_histogram(bins = 100) + scale_x_log10(label = comma) 
ggplot(trips, aes(x=tripduration)) + geom_density(fill = "grey") + scale_x_log10(label = comma)
       
# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration, color = usertype)) + geom_histogram(bins=100) + scale_x_log10(label = comma) + scale_y_log10(label = comma) 
ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) + geom_density() +scale_x_log10(label = comma) 

# plot the total number of trips on each day in the data set
trips %>% group_by(ymd) %>% summarize (num_trips =n()) %>% ggplot(aes(x = ymd, y = num_trips)) + geom_point() + xlab('Number of Trips') + ylab('Day')

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>% mutate(age = 2022-birth_year) %>% group_by(age, gender) %>% summarize (num_trips =n()) %>% ggplot(aes(x = age, y = num_trips, color = gender)) + geom_point() + xlab('Age') + ylab('Number of Trips')  + scale_y_log10(label = comma)

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data

########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
 ggplot(weather, aes(x=date,  y=tmin)) + geom_point()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

weather_ymd <- weather %>% mutate(ymd = as.Date(date, '%Y-%m-%d'))
trips_with_weather <- inner_join(trips, weather_ymd, by="ymd")
weather <- weather_ymd

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

num_trips <- trips %>% group_by(ymd) %>% summarize(num_trips = n())
num_trips_tmin <- inner_join(num_trips, weather, by="ymd")

num_trips_tmin %>% ggplot(mapping = aes(x = tmin, y = num_trips)) + geom_point() + scale_y_continuous(label = comma)

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
# add a smoothed fit on top of the previous plot, using geom_smooth

num_trips_tmin %>% mutate(sub_precip = prcp >= 0.3) %>% ggplot(mapping = aes(x = tmin, y = num_trips, color = sub_precip)) + geom_point() + geom_smooth() + scale_y_continuous(label = comma)

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

trips_hour <- mutate(trips, hour = hour(starttime))
trips_by_hour <- trips_hour %>% group_by(ymd, hour) %>% summarize(count = n())
hour_total <- group_by(trips_by_hour, hour) %>% summarize(avg = mean(count), std_dev = sd(count))
ggplot(data = hour_total) + geom_line(mapping = aes(x = hour, y = avg)) + geom_ribbon(mapping = aes(x = hour, ymin = avg - std_dev, ymax = avg + std_dev), alpha = 0.2)

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_hour <- mutate(trips_hour, day = wday(ymd))
trips_hour <- mutate(trips_hour, day=factor(day, levels=c(1,2,3,4,5,6,7), labels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")))

trips_by_day <- trips_hour %>% group_by(ymd, day) %>% summarize(count = n())
day_total <- group_by(trips_by_day, day) %>% summarize(avg = mean(count), std_dev = sd(count))
ggplot(data = day_total) + geom_point(mapping = aes(x = day, y = avg))
ggplot(data = day_total) + geom_point(mapping = aes(x = day, y = std_dev)) 