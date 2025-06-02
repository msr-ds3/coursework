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
head(trips)

########################################
# plot trip data
######################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
ggplot(trips,aes(tripduration/60))+ 
    geom_histogram(fill= 'blue', bins = 50)+
    scale_x_log10(labels=comma)+
    scale_y_continuous(labels = comma)+
    labs(x='Trip duration',
    y= 'Frequency',
    title = 'Histogram of trip duration in minutes')

ggplot(trips,aes(tripduration/60))+ 
    geom_density(fill= 'red')+
    scale_x_log10(labels=comma)+
    labs(x='Trip duration ',
    y= 'Frequency',
    title = 'Density plot in minutes')

head(trips)

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration, fill=usertype))+
    geom_histogram(bins = 40)+
    labs(x='Trip duration')+
    scale_x_log10(labels=comma)+
    facet_grid(~usertype)

ggplot(trips, aes(x = tripduration, fill=usertype))+
    geom_density()+
    labs(x='Trip duration')+
    scale_x_log10(labels=comma)+
    facet_grid(~usertype)

# plot the total number of trips on each day in the dataset
trips%>%
    mutate(date = as.Date(starttime))%>%
    ggplot(aes(x =date))+
        geom_histogram(bins=30)+
        scale_y_continuous(labels=comma)+
        scale_x_date(labels = date_format("%Y-%m-%d"))

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips%>%
    mutate(age = as.numeric(format(ymd, "%Y")) - as.numeric(birth_year)) %>%
    ggplot(aes(age, fill = gender))+
    geom_histogram(bins=40,alpha = 0.8)+
    scale_y_continuous(labels = comma)

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>% mutate(age = as.numeric(format(ymd, "%Y")) - as.numeric(birth_year)) %>% 
    group_by(age, gender) %>% summarise(num_trips = n(),  .groups = "drop")%>%
    pivot_wider(names_from = gender, values_from = num_trips) %>% mutate(male_to_female = Male/ Female) %>% 
    ggplot( aes(age, male_to_female))+  geom_line(color = "steelblue", size = 1) +
    geom_smooth( color = "red", linetype = "dashed") +
    scale_x_log10()+ 
    labs(x = "AGE", y = "Male to Female Ratio", title = "Male/Female trip ratio by Age") +
    theme_minimal()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
view(weather)
weather%>%
    ggplot(aes(x= ymd, y= tmin, color=tmin))+
    geom_point()+
    scale_color_gradient(low = "blue", high = "red") +
    labs(
        title="Scatterplot of min temp over each day",
        x=  "Day",
        y= "Minimum temperature")


# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
view(weather)

weather %>% pivot_longer(names_to = "temp_type", values_to = "temperature", cols = c(tmin,tmax)) %>%
    ggplot(aes(ymd, temperature, color= temp_type))+ geom_line() + scale_x_date() + labs(
    x = "Date",
    y = "Temperature",
    color = "Temperature Type",
    title = "Daily Min and Max Temperatures") 



########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

head(trips_with_weather)

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

str(weather)
head(trips)
trips_with_weather %>%
    group_by(ymd,tmin)%>%
    summarise(num_trips = n(), .groups = "drop")%>%
    ggplot(aes(tmin, num_trips))+geom_point()

#works only for this data frame since tmin is not different    
# trips_by_day <- trips %>%
#     mutate(date = as.Date(starttime)) %>%
#     group_by(date)%>%
#     summarise(num_trips = n())
# weather %>%
#     mutate(date = as.Date(date))%>%
#     inner_join(trips_by_day,weather_by_day, by ='date') %>%
#     ggplot(aes(x= mean(tmin),y= num_trips))+
#         geom_point() +
#         labs(x = "Minimum Temperature", y = "Number of Trips",
#         title = "Trips vs. Min Temperature")

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
    mutate(precptf = ifelse(prcp > mean(prcp), 'T', 'F'))%>%
    group_by(ymd,tmin, precptf)%>%
    summarise(num_trips = n(), .groups = "drop")%>%
    ungroup()%>%
    ggplot(aes(tmin, num_trips))+geom_point() + 
    labs( x = "number of trip",
        y = "minimum temp",
        title = "Substantial precipitation on num of trips") +
    facet_wrap(~precptf)
    


# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
    mutate(precptf = ifelse(prcp > mean(prcp), 'T', 'F'))%>%
    group_by(ymd,tmin, precptf)%>%
    summarise(num_trips = n(), .groups = "drop")%>%
    ungroup()%>%
    ggplot(aes(tmin, num_trips))+geom_point() + geom_smooth()+
    labs( x = "number of trip",
        y = "minimum temp",
        title = "Substantial precipitation on num of trips") +
    facet_wrap(~precptf)

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
library(lubridate)

trips_with_weather %>%
    mutate(hour = hour(starttime),
    date = as.Date(starttime))%>%
    group_by(hour,date)%>%
    summarise(num_trips = n(), .groups = "drop")%>%
    group_by(hour)%>%
    summarise(
        average_trips = mean(num_trips),
        sd_trips = sd(num_trips))

# plot the above
trips_with_weather %>%
    mutate(hour = hour(starttime),
    date = as.Date(starttime))%>%
    group_by(hour,date)%>%
    summarise(num_trips = n(), .groups = "drop")%>%
    group_by(hour)%>%
    summarise(
        average_trips = mean(num_trips),
        sd_trips = sd(num_trips)) %>%
    ggplot( aes(hour, average_trips))+
    geom_line(color = "red") + geom_ribbon(aes(ymin = average_trips - sd_trips, ymax = average_trips + sd_trips), alpha = 0.25)+
     labs(
        x = "Hour of Day",
        y = "Average Number of Trips",
        title = "Average Number of Trips by Hour with ±1 SD Ribbon",
        subtitle = "Red line: Mean trips per hour; Blue ribbon: ±1 standard deviation"
    ) +
    theme_minimal()


# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips %>%
    mutate(
        hour = hour(starttime),
        day = as.Date(starttime),
        weekday = wday(starttime, label =TRUE) )%>%
    group_by(hour, weekday, day)%>%
    summarise(trip_count = n(), .groups = "drop")%>%
    group_by(hour,weekday)%>%
    summarise(average = mean(trip_count),
        standarddev = sd(trip_count),
        .groups = "drop")

