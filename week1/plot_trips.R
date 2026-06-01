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
ggplot(trips, mapping = aes(x = tripduration)) +
    geom_histogram(bins = 200, fill = 'red') + 
    scale_x_log10(label = comma)

ggplot(trips, mapping = aes(x = tripduration)) +
    geom_density(fill = '#b73ab1') + 
    scale_x_log10(label = comma)

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
group_by(usertype, tripduration) %>%
    ggplot(mapping = aes(x = tripduration, color = usertype, fill = usertype)) +
    geom_histogram(bins = 200) + 
    scale_x_log10(label = comma) +
    facet_wrap(~ usertype)

trips %>%
group_by(usertype, tripduration) %>%
    ggplot(mapping = aes(x = tripduration, color = usertype, fill = usertype)) +
    geom_density() + 
    scale_x_log10(label = comma) + 
    facet_wrap(~ usertype)

# plot the total number of trips on each day in the dataset
trips %>%
mutate(days = floor_date(starttime, unit = "day")) %>%
group_by(days) %>%
    ggplot(mapping = aes(x = days)) + 
    geom_bar()

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
# NTS: add a bar plot
trips %>%
mutate(age = 2014 - birth_year) %>%
group_by(age, gender) %>%
summarize(count = n()) %>%
    ggplot(mapping = aes(x = age, y = count, color = gender)) + 
    geom_point() +
    geom_smooth()
# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
mutate(age = 2014 - birth_year) %>%
filter(gender != "Unknown") %>%
group_by(age, gender) %>%
summarize(count = n()) %>%
pivot_wider(
    id_cols = age,
    names_from = gender,
    values_from = count
) %>%
mutate(ratio = Male/Female) %>%
    ggplot(mapping = aes(x = age, y = ratio)) + 
        geom_point()
########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
ggplot(mapping = aes(x = ymd, y = tmin)) +
    geom_point(color = '#cf47fc')

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
pivot_longer(
    cols = starts_with("tm"),
    names_to = "tdim",
    values_to = "tvalue",
) %>%
    ggplot(mapping = aes(x = date, y = tvalue, color = tdim)) +
    geom_point()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
group_by(tmin, date) %>%
summarize(trips = n()) %>%
    ggplot(mapping = aes(x = tmin, y = trips)) +
        geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
summarize(avg_precip = mean(prcp)) %>%
select(avg_precip)

"""
# # A tibble: 1 × 1
  avg_precip
       <dbl>
1     0.0936
"""
trips_with_weather %>%
mutate(sub_prcp = prcp > 0.0936) %>%
group_by(tmin, date, sub_prcp) %>%
summarize(trips = n()) %>%
ggplot(mapping = aes(x = tmin, y = trips, color = sub_prcp)) +
    geom_point()

trips_with_weather %>%
mutate(sub_prcp = prcp > 0.0936) %>%
group_by(tmin, date, sub_prcp) %>%
summarize(trips = n()) %>%
ggplot(mapping = aes(x = tmin, y = trips, color = sub_prcp)) +
    geom_point() + 
    facet_wrap(~ sub_prcp)
# add a smoothed fit on top of the previous plot, using geom_smooth

trips_with_weather %>%
mutate(sub_prcp = prcp > 0.0936) %>%
group_by(tmin, date, sub_prcp) %>%
summarize(trips = n()) %>%
ggplot(mapping = aes(x = tmin, y = trips, color = sub_prcp)) +
    geom_point() + 
    facet_wrap(~ sub_prcp) + 
    geom_smooth(model = "lm")
# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

trips_with_weather %>%
mutate(hour = hour(starttime)) %>%
group_by(hour, date) %>%
summarize(count = n()) %>%
group_by(hour) %>%
summarize(avg = mean(count), sd = sd(count)) %>%
    ggplot(aes(x = hour, y = avg)) + 
        geom_pointrange(aes(ymin = avg - sd, ymax = avg + sd)) +
        xlab('Hour of the Day') +
        ylab('Avg Num of Trips') 
# plot the abov

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
# Facet Wrap
trips_with_weather %>%
mutate(wday = wday(starttime, label = TRUE)) %>%
group_by(wday, date) %>%
summarize(count = n()) %>%
group_by(wday) %>%
summarize(avg = mean(count), sd = sd(count)) %>%
    ggplot(aes(x = wday, y = avg)) + 
        geom_pointrange(aes(ymin = avg - sd, ymax = avg + sd)) +
        xlab('Day of the Week') +
        ylab('Avg Num of Trips') 
