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
trips %>%
    ggplot(aes(x=tripduration)) +
    geom_histogram(binwidth=200) +
    scale_y_log10(label=comma) +
    labs(
        x="Trip Duration",
        y="Count",
        title="Disribution of Trip Times Across Rides"
    )

trips %>%
    ggplot(aes(x=tripduration)) +
    geom_density() +
    scale_y_log10(label=comma) +
    labs(
        x="Trip Duration",
        y="Count",
        title="Disribution of Trip Times Across Rides"
    )

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
trips %>%
    ggplot(aes(x=tripduration, color=usertype, fill=usertype)) + 
    geom_histogram() +
    scale_y_log10(label=comma) +
    labs(
        x="Trip Duration",
        y="Count",
        title="Disribution of Trip Times by Rider Type"
    )

trips %>%
    ggplot(aes(x=tripduration, color=usertype, fill=usertype)) + 
    geom_density() +
    scale_y_log10(label=comma) +
    labs(
        x="Trip Duration",
        y="Count",
        title="Disribution of Trip Times by Rider Type"
    )

# plot the total number of trips on each day in the dataset
trips %>%
    group_by(date = as.Date(starttime)) %>%
    summarize(frequency=n()) %>%
    ggplot(aes(x=date, y=frequency)) + 
    geom_point() + 
    geom_smooth() + 
    labs(
        x="Day",
        y="Total trips",
        title="Total Trips per Day"
    )

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
    mutate(age=2014-birth_year) %>%
    ggplot(aes(x=age, color=gender)) +
    geom_bar() +
    labs(
        x="Age",
        y="Total trips",
        title="Total Trips by Age and Gender"
    )

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)


########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
    ggplot(aes(x=date, y=tmin)) +
    geom_point() +
    geom_smooth() + 
    labs(
        x="Date",
        y="Mininmum Temperature",
        title="Daily Minimum Temperature"
    )

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
    group_by(tmin) %>%
    summarize(num_trips=n()) %>%
    ggplot(aes(x=tmin, y=num_trips)) +
    geom_point() +
    labs(
        x="Minimum Temperature",
        y="Number of trips",
        title="Minimum Temperature v. Number of Trips"
    )

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

# substantial precipiatation would be anything above the average
trips_with_weather %>%
    summarize(mean_precipitation=mean(prcp))

# mean = 0.0936

trips_with_weather %>%
    mutate(substantial_prcp = (prcp > 0.0936)) %>%
    group_by(tmin, substantial_prcp) %>%
    summarize(num_trips=n()) %>%
    ggplot(aes(x=tmin, y=num_trips, color=substantial_prcp)) +
    geom_point() +
    labs(
        x="Minimum Temperature",
        y="Number of trips",
        color="Substantial Precipitation",
        title="Minimum Temperature v. Number of Trips"
    )

# add a smoothed fit on top of the previous plot, using geom_smooth

trips_with_weather %>%
    mutate(substantial_prcp = (prcp > 0.0936)) %>%
    group_by(tmin, substantial_prcp) %>%
    summarize(num_trips=n()) %>%
    ggplot(aes(x=tmin, y=num_trips, color=substantial_prcp)) +
    geom_point() +
    labs(
        x="Minimum Temperature",
        y="Number of trips",
        color="Substantial Precipitation",
        title="Minimum Temperature v. Number of Trips"
    ) +
    geom_smooth(method="lm")


# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips %>%
    group_by(date=as.Date(starttime), hour=hour(starttime)) %>%
    summarize(
        total_trips=n(),
    ) %>%
    group_by(hour) %>%
    summarize(
        mean_per_hour=mean(total_trips),
        sd_per_hour=sd(total_trips)
    ) %>%
    select(hour, mean_per_hour, sd_per_hour) %>%
    print(n=24)

# plot the above
trips %>%
    group_by(date=as.Date(starttime), hour=hour(starttime)) %>%
    summarize(
        total_trips=n(),
    ) %>%
    group_by(hour) %>%
    summarize(
        mean_per_hour=mean(total_trips),
        sd_per_hour=sd(total_trips)
    ) %>%
    select(hour, mean_per_hour, sd_per_hour) %>%
    ggplot(aes(x=hour, y=mean_per_hour)) +
    geom_pointrange(aes(ymin=mean_per_hour-sd_per_hour, ymax=mean_per_hour+sd_per_hour)) +
    labs(
        x="Hour of the Day",
        y="Average Trips",
        title="Range of Trips per Hour",
    )


# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips %>%
    group_by(date=as.Date(starttime), hour=hour(starttime), weekday=wday(starttime, label=T)) %>%
    summarize(
        total_trips=n(),
    ) %>%
    group_by(hour, weekday) %>%
    summarize(
        mean_per_hour=mean(total_trips),
        sd_per_hour=sd(total_trips)
    ) %>%
    select(hour, weekday, mean_per_hour, sd_per_hour) %>%
    ggplot(aes(x=hour, y=mean_per_hour)) +
    geom_pointrange(aes(ymin=mean_per_hour-sd_per_hour, ymax=mean_per_hour+sd_per_hour)) +
    labs(
        x="Hour of the Day",
        y="Average Trips",
        title="Range of Trips per Hour by Weekday"
    ) + 
    facet_wrap(~ weekday)
