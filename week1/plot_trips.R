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
# Changed plots per Hannah suggestions
smaller_trips <- trips %>%
    filter(tripduration <= 5000)

ggplot(smaller_trips, aes(x=tripduration)) +
    geom_histogram(bins = 100) + 
    labs(x = "Trip Duration", x = "Trip Count", title = "Distribution of Trip Time Across All Rides")

ggplot(smaller_trips, aes(x=tripduration)) +
    geom_density(fill = "#bbbbf8", colour = "#bbbbf8") +
    labs(x = "Trip Duration", y = "Trip Count", title = "Distribution of Trip Times Across All Rides")

# CHANGES: I removed the log10 scale and instead filtered out extreme values


# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
# Changed plots per Hannah suggestions
ggplot(smaller_trips, aes(x=tripduration, colour=usertype, fill=usertype)) +
    scale_x_log10(label = comma) +
    geom_histogram(bins = 50) +
    facet_wrap(~ usertype, scale = "free_y") +
    labs(x = "Trip Duration", y = "Trip Count", title = "Distribution of Trip Times Across All Rides (Split by User Type)")

#
ggplot(trips, aes(x=tripduration, colour=usertype, fill=usertype)) +
    scale_x_log10(label = comma) +
    geom_density() +
    labs(x = "Trip Duration", y = "Density", title = "Distribution of Trip Times Across All Rides (Colored by User Type)")

# plot the total number of trips on each day in the dataset
# Changed plot from bar plot to line graph per Hannah suggestion
trips %>%
    mutate(day = floor_date(starttime, unit = "day")) %>%
    group_by(day) %>%
    summarize(count = n()) %>%
    ggplot(aes(x=day, y = count)) +
    geom_line(colour = '#9797c0') +
    labs(x = "Day", y = "Trip Count", title = "Total number of trips per day")

# If you want to see changes across days, it is more difficult to follow if you are 
# looking a barplot as opposed to a line graph

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
    mutate(age = 2014 - birth_year) %>%
    ggplot(aes(x = age, fill = gender)) +
    geom_bar(alpha = 1/5, position = "identity") +
    labs(x = "Age", y = "Total number of trips", title = "Total number of trips vs age (colored by gender)")

# Scatter plot version (Scatter plot version is much better)
# Kept scatter plot version because it is easier to see the differences betweeen groups
# Also limited the range to 250000 so the group difference is easier to see
trips %>%
    mutate(age = 2014 - birth_year) %>%
    group_by(age, gender) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = age, y = count, colour = gender)) +
    ylim(0, 250000) +
    geom_point() +
    geom_smooth() +
    labs(x = "Age", y = "Total number of trips", title = "Total number of trips vs age (colored by gender)")

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
    mutate(age = 2014 - birth_year) %>% # adding age field
    filter(gender != "Unknown") %>% # filtering out unknown to keep male/femlae
    select(age, gender) %>% # isolating age and gender so i can see what happens
    group_by(age, gender) %>% # grouping by age and gender
    summarize(count = n()) %>% # counting trip amounts for each age and gender
    pivot_wider(age, names_from = gender, values_from = count) %>%
    mutate(ratio = Male / Female)     
    ggplot(aes(x = age, y = ratio)) +
    geom_point(colour = '#6d6daf') +
    labs(x = "Age", y = "Ratio of male to female trips", title = "Age vs Ratio of male to female trips")

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
# Made x = year month day for easier visuals on the x-axis per Hannah suggestion
ggplot(weather, aes(x = ymd(date), y = tmin)) +
    geom_point(colour='#618695') +
    labs(x = "Date", y = "Minimum Temperature", title = "Date vs Minimum temperature")

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
    pivot_longer(names_to = "maxmin", values_to = "ex_temp", 5:6) %>%
    ggplot(aes(x = date, y = ex_temp, colour = maxmin)) +
    geom_point() +
    labs(x = "Date", y = "Temperature Ranges", title = "Date vs Min and Max Temperatures (colored by min/max)")

weather %>%
    pivot_longer(names_to = "maxmin", values_to = "ex_temp", 5:6) %>%
    ggplot(aes(x = date, y = ex_temp, group = maxmin, colour = maxmin)) +
    geom_line() +
    labs(x = "Date", y = "Temperature Ranges", title = "Date vs Min and Max Temperatures (colored by min/max)")

# reshaping data
########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
# x = min temp y = number of trips
trips_with_weather %>%
    group_by(tmin, date) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = tmin, y = count)) +
    geom_point() +
    labs(x = "Minimum temperature", y = "Trip count", title = "Trip count by minimum temperature for each day")

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

# AVG MEAN PRECIP: 0.0936
trips_with_weather %>% 
    mutate(is_substantial = (prcp > 0.0936)) %>%
    group_by(tmin, date, is_substantial) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = tmin, y = count, colour = is_substantial)) +
    geom_point() +
    labs(x = "Minimum temperature", y = "Trip count", title = "Trip count by minimum temperature for each day")

# Same graph but splitting graph by substantial precipitation or not
trips_with_weather %>% 
    mutate(is_substantial = (prcp > 0.0936)) %>%
    group_by(tmin, date, is_substantial) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = tmin, y = count)) +
    geom_point(colour = 'purple') +
    facet_wrap(~ is_substantial) +
    labs(x = "Minimum temperature", y = "Trip count", title = "Trip count by minimum temperature for each day")

# add a smoothed fit on top of the previous plot, using geom_smooth
# Same graph as above but with a line
trips_with_weather %>% 
    mutate(is_substantial = (prcp > 0.0936)) %>%
    group_by(tmin, date, is_substantial) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = tmin, y = count, colour = is_substantial)) +
    geom_point() +
    geom_smooth(method = "lm") +
    labs(x = "Minimum temperature", y = "Trip count", title = "Trip count by minimum temperature for each day (but with a line)")

trips_with_weather %>% 
    mutate(is_substantial = (prcp > 0.0936)) %>%
    group_by(tmin, date, is_substantial) %>%
    summarize(count = n()) %>%
    ggplot(aes(x = tmin, y = count)) +
    geom_point( colour = 'purple') +
    facet_wrap(~ is_substantial) +
    geom_smooth(method = "lm") +
    labs(x = "Minimum temperature", y = "Trip count", title = "Trip count by minimum temperature for each day")

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>%
    mutate(hour = hour(starttime)) %>%
    group_by(date, hour) %>%
    summarize(count=n()) %>%
    group_by(hour) %>%
    arrange(hour) %>%
    summarize(avg = mean(count), sd = sd(count)) %>%
    view() 

# plot the above
# removed coord-flip, the hours vs count makes more sense the other way around
# per Hannah suggestion
trips_with_weather %>%
    mutate(hour = hour(starttime)) %>%
    group_by(date, hour) %>%
    summarize(count=n()) %>%
    group_by(hour) %>%
    summarize(avg = mean(count), sd = sd(count)) %>%
    ggplot(aes(x = hour, y = avg)) +
    geom_pointrange(aes(ymin = avg - sd, ymax = avg + sd)) +
    labs(x = "Hour of Day", y = "Average Trips", title = "Average Trips by Hour of Day")

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
# Changed to facet_wrap by day_of_week rather than avg and sd by day_of_week
# per Hannah suggestion
trips %>%
    mutate(hour = hour(starttime), date = as.Date(starttime), day_of_week = wday(date)) %>%
    group_by(date, hour, day_of_week) %>%
    summarize(count=n()) %>%
    group_by(hour, day_of_week) %>%
    summarize(avg = mean(count), sd = sd(count)) %>%
    ggplot(aes(x = hour, y = avg)) +
    geom_pointrange(aes(ymin = avg - sd, ymax = avg + sd)) +
    facet_wrap(~ day_of_week) +
    labs(x = "Hour of Day", y = "Average Trips", title = "Average Trips by Hour of Day")
