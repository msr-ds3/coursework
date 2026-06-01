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
ggplot(trips, aes(x = tripduration)) +
    scale_x_log10(label = comma) +
    scale_y_continuous(label = comma) +
    geom_histogram()

ggplot(trips, aes(x = tripduration)) +
    scale_x_log10(label = comma) +
    scale_y_continuous(label = comma) +
    geom_density(fill="pink")

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration, color=usertype, fill=usertype)) +
    scale_x_log10(label = comma) +
    geom_histogram()

ggplot(trips, aes(x = tripduration, color=usertype, fill=usertype)) +
    scale_x_log10(label = comma) +
    geom_density()

# plot the total number of trips on each day in the dataset
trips_per_day <- trips %>%
    group_by(ymd)%>%
    summarize(num_trips = n())

ggplot(trips_per_day, aes(x = ymd, y = num_trips)) +
    xlab('DATE')+
    ylab('Number of Trips')+
    geom_point()

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
total_trips <- trips %>%
    mutate(age = lubridate::year(Sys.Date()) - birth_year)%>%
    group_by(age,gender)%>%
    summarize(num_trips = n())

ggplot(total_trips, aes(x = age, y = num_trips, color=gender)) +
    scale_y_continuous(label = comma) +
    xlab('Age')+
    ylab('Number of trips')+
    geom_line()

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
    mutate(age = lubridate::year(Sys.Date()) - birth_year)%>%
    group_by(age,gender)%>%
    summarize(count = n())%>%
    pivot_wider(names_from = gender, values_from = count, values_fill = 1)%>%
    mutate(ratio = Male/Female)%>%
ggplot(aes(x = age, y = ratio)) +
    xlab('Age')+
    ylab('Ratio of male to female trips')+
    geom_line()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
ggplot(weather, aes(x = date, y = tmin)) +
    xlab('Date')+
    ylab('Minimum temperature')+
    geom_point()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
pivot_longer(weather, names_to = "min_max", values_to = "Temperature", 10:11) %>%
ggplot(aes(x = date, y = Temperature, group=min_max, color=min_max)) +
    xlab('Date')+
    ylab('Daily Temperature Level ')+
    geom_line()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
summarize(group_by(trips_with_weather,ymd,tmin), count=n())%>%
    ggplot(aes(x = ymd, y = tmin)) +
    xlab('Date')+
    ylab('Minimum temperature')+
    geom_line()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather%>%
    mutate(precip=ifelse(prcp>mean(prcp), "T", "F"))%>%
    group_by(ymd,precip)%>%
    summarise(count=n(), mean=mean(tmin))%>%
    ggplot(aes(x=mean, y=count))+
    geom_point()

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather%>%
    mutate(precip=ifelse(prcp>mean(prcp), "T", "F"))%>%
    group_by(ymd,precip)%>%
    summarise(count=n(), mean=mean(tmin))%>%
    ggplot(aes(x=mean, y=count))+
    geom_point()+
    geom_smooth(method="lm")

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather%>%
    mutate(hour= hour(starttime), day=floor_date(ymd,unit = "day"))%>%
    group_by(day,hour)%>%
    summarise(count=n())%>%
    group_by(hour)%>%
    summarise(mean=mean(count), stds=sd(count))

# plot the above
trips_with_weather%>%
    mutate(hour= hour(starttime), day=floor_date(ymd,unit = "day"))%>%
    group_by(day,hour)%>%
    summarise(count=n())%>%
    group_by(hour)%>%
    summarise(mean=mean(count), stds=sd(count))%>%
    ggplot(aes(x=hour))+
    xlab('Time (hour)')+
    ylab('Average Number of Trips and Standard Deviation in Number of Trips')+
    geom_ribbon(aes(ymin= mean-stds, ymax=mean+stds, alpha=0.1))

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather%>%
    mutate(weekday=wday(ymd, label = TRUE), hour= hour(starttime), day=floor_date(ymd,unit = "day"))%>%
    group_by(day,hour,weekday)%>%
    summarise(count=n())%>%
    group_by(hour, weekday)%>%
    summarise(mean=mean(count), stds=sd(count))%>%
    ggplot(aes(x=hour))+
    geom_ribbon(aes(ymin= mean-stds, ymax=mean+stds, alpha=0.5))+
    facet_wrap(~ weekday, scale="free")
