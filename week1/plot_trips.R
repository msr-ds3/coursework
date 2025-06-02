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
ggplot(trips, aes(x = tripduration))+
    geom_histogram(fill = 'blue', bins = 30) + 
    scale_x_log10(labels=comma) +
    ylab('Number of trip per Time')

    ggplot(trips, aes(x = tripduration))+
    geom_density(fill = 'grey') + 
    scale_x_log10(labels=comma)
# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration, , color = usertype, fill = usertype))+
    geom_histogram(bins = 30) + 
    scale_x_log10(labels=comma) +
    ylab('Number of trip per Time')+
    facet_grid( ~usertype)

ggplot(trips, aes(x = tripduration, , color = usertype, fill = usertype))+
    geom_density(fill = 'grey') + 
    scale_x_log10(labels=comma) +
    ylab('Number of trip per Time')+
    facet_grid( ~usertype)


# plot the total number of trips on each day in the dataset

trips %>% mutate(date = as.Date(starttime)) %>%
ggplot(aes(x = date))+
    geom_histogram(fill = 'blue', bins = 30)+
    scale_y_continuous(label = comma)+
    scale_x_date(date_labels = "%Y-%m-%d")
    
# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>% mutate(age = sys.Date() - birth_year) %>%
ggplot(aes(x = age, color = usertype, fill = usertype))+
    geom_histogram(bins = 30) + 
    scale_x_log10(labels=comma) +
    ylab()+
    facet_grid(~usertype)
# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
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


# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

# add a smoothed fit on top of the previous plot, using geom_smooth

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
