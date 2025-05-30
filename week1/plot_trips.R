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
#density plot
ggplot(trips, aes(x = tripduration)) +
    geom_histogram(bins = 50) +
    scale_x_log10(label = comma) +
    xlab('trip duration') +
    ylab('frequency')

ggplot(trips, aes(x = tripduration)) +
    geom_density(fill = "#8d77bc") +
    scale_x_log10(label = comma) +
    xlab('trip duration (seconds)') 



# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) +
    geom_histogram(bins = 50) +
    scale_x_log10(label = comma) +
    xlab('trip duration') +
    ylab('frequency')

ggplot(trips, aes(x = tripduration, fill = usertype)) +
    geom_density(alpha = 0.6) +
    scale_x_log10(label = comma) +
    xlab('trip duration (seconds)') +
    ylab('frequency')

# plot the total number of trips on each day in the dataset
trips_date <- trips |> mutate(date = as.Date(trips$starttime, "%m/%d/%y"))
ggplot(trips_date, aes(x = date)) +
    geom_histogram(bins = 30) +
    xlab('date') +
    ylab('frequency') +
    scale_y_continuous(label = comma)
# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
#view(trips |> mutate(birth_year_num = as.numeric(trips$birth_year)) |> head(n=100)) # i know its supposed to be age and not birth_year
trips_filtered <- trips |> filter(!is.na(birth_year))
ggplot(trips_filtered, aes(x = birth_year, color = gender, fill=gender)) +
    geom_histogram(alpha=.6) +
    xlab('birth year') +
    ylab('num trips')


# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather$date_column <- as.Date(weather$date, format = "%Y-%m-%d")
trips <- trips |> mutate(date = as.Date(trips$starttime, "%m/%d/%y"))
ggplot(weather, aes(x = date_column, y = tmin, color=tmin)) +
    geom_point() +
    scale_x_date(date_breaks= "1 month", date_labels = "%b %Y") +
    ylab('Minimum Temperature of the day')


# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather$date_column <- as.Date(weather$date, format = "%Y-%m-%d")
trips <- trips |> mutate(date = as.Date(trips$starttime, "%m/%d/%y"))
########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")
# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips$date_column <- as.Date(trips$date, format = "%Y-%m-%d")
weather$date_column <- as.Date(weather$date, format = "%Y-%m-%d")
t2 <- trips_with_weather |> group_by(date) |> summarize(trip_count = n())
t2$date_column <- as.Date(t2$date, format = "%Y-%m-%d")
t3 <- inner_join(t2,weather, by = "date_column")
ggplot(t3, aes(x = tmin, y=trip_count)) +
    geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

t3 <- t3 |> mutate(sig_precip = prcp > 0.15)
ggplot(t3, aes(x = tmin, y=trip_count)) +
    geom_point() +
    geom_smooth(method = "lm") +
    facet_wrap(~sig_precip)

# add a smoothed fit on top of the previous plot, using geom_smooth
#done above

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_hours <- trips |> mutate(hour = hour(trips$starttime))
view(trips_hours |> group_by(hour) |> summarize(mean=mean(n()), sd(n())) |> head(n=100))

#new solution
trips_hours <- trips |> mutate(hour = hour(trips$starttime))
trips_hours <- trips_hours |> group_by(hour,ymd) |> summarize(num_trips = n())
trips_hours <- trips_hours |> group_by(hour) |> summarize(mean= mean(num_trips), sd=sd(num_trips))

ggplot(trips_hours, aes(x = hour, y=mean)) + geom_ribbon(aes(ymin=mean-sd, ymax= mean+sd), alpha=.2) + geom_line()
# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
