########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)
library(ggplot2)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration)) + geom_histogram() + scale_x_log10(label = comma) +xlab('Trip Duration') +
    ylab('Frequency')

ggplot(trips, aes(x = tripduration)) +
    geom_density(fill = "grey") +
    scale_x_log10(label = comma) +
    xlab('Trip Duration') +
    ylab('Frequency')

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips) + geom_histogram( aes(x = tripduration, color = usertype, fill = usertype)) + scale_x_log10(label = comma) +xlab('Trip Duration') +
    ylab('Frequency')

ggplot(trips) +
    geom_density(aes(x = tripduration, color = usertype, fill = usertype)) +
    scale_x_log10(label = comma) +
    xlab('Trip Duration') +
    ylab('Frequency')

# plot the total number of trips on each day in the dataset
trips1 <- mutate(trips, date = as.Date(starttime))
ggplot(trips1) + geom_histogram(aes(x = date))  +xlab('Date') +
    ylab('Frequency')

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
tripsa <- mutate(trips, age = 2025-birth_year)
ggplot(tripsa) + geom_histogram( aes(x = age,color = gender, fill = gender)) + scale_x_log10(label = comma) +xlab('Age') +
ylab('Frequency')

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)


########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
ggplot(weather) + geom_point( aes(x = date, y = tmin)) +xlab('Date') +
ylab('Min Temp')

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
df_long <- weather %>% pivot_longer(cols = c(tmin,tmax), names_to = "temp_type", values_to = "temperature")
ggplot(df_long) + geom_point(aes(x = date, y = temperature, color = temp_type)) +xlab('Date') +
ylab('Temperatue')

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
head(trips_with_weather)
trips <- mutate(trips, ymd = as.Date(starttime))
trip <- group_by(trips, ymd)
a <- summarize(trip, count = n())
head(a)
b <- inner_join(weather, a, by="ymd")
str(weather)
str(trip)
ggplot(b, aes(x = tmin, y = count)) + geom_point() +xlab('Min Temperature') +
ylab('Number of trips')

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
weather1 <- mutate(b, precip = ifelse(prcp>=mean(prcp), T,F))
ggplot(weather1, aes(x = tmin, y = count)) + geom_point() + facet_wrap(~ precip) + xlab("Minimum Temperature") +ylab("Number of Trips")

# add a smoothed fit on top of the previous plot, using geom_smooth
ggplot(weather1, aes(x = tmin, y = count)) + geom_point() + geom_smooth() + facet_wrap(~ precip) + xlab("Minimum Temperature") +ylab("Number of Trips")


# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips <- mutate(trips, hr = hour(starttime), date = as.Date(starttime))
trip <- group_by(trips, hr, date) |> count(date,hr) |> group_by(hr) |> summarize(average = mean(n), std = sd(n))
trip

# plot the above
df_long <- trip %>% pivot_longer(cols = c(average,std), names_to = "stat_type", values_to = "statistic")
df_long
ggplot(df_long) + geom_point(aes(x = hr, y = statistic, color = stat_type)) +xlab('Hour') +
ylab('Statistic')

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips <- mutate(trips, hr = hour(starttime), date = as.Date(starttime))
trip <- group_by(trips, date, hr)  |> count(date,hr) |> mutate(day = wday(date))
trip

trip <- trip |> group_by(day, hr) |> summarize(average = mean(n), std = sd(n))
trip
view(trip)

df_long <- trip %>% pivot_longer(cols = c(average,std), names_to = "stat_type", values_to = "statistic")
df_long
ggplot(df_long) + geom_point(aes(x = hr, y = statistic, color = stat_type))+ facet_wrap(~ day)


