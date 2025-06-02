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
    geom_histogram(bins = 30, fill = "blue", color = "black") +  scale_x_log10() 


    ggplot(trips, aes(x = tripduration)) + 
    geom_density(fill = "blue", color = "black") +  scale_x_log10()




# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)

 ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) + 
    geom_histogram() +  scale_x_log10() + 
    facet_grid(~ usertype) 
    + ylab("Number of trips")


 # Density : 
 ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) + 
    geom_density()+  scale_x_log10() + 
    facet_grid(~ usertype) 



# plot the total number of trips on each day in the dataset

trips %>% mutate(day =  as.Date(starttime)) %>% 
     ggplot(aes(x = day)) +  
     geom_histogram(bins = 30, fill = "blue")
     



# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)


trips %>% mutate(age = as.numeric(format(ymd, "%Y")) - as.numeric(birth_year)) %>% 
    ggplot(aes(x = age, , fill = gender)) + geom_histogram(bins = 30, alpha = 0.9) + 
    ylab("Total number of trips")





# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)



trips_age <- trips %>% mutate(age = as.numeric(format(ymd, "%Y")) - as.numeric(birth_year))

trips_age_grouped <- group_by(trips_age, age, gender)  %>% summarise(count = n())

trips_age_grouped_pivoted <- pivot_wider(trips_age_grouped, names_from = gender, values_from = count)

trips_age_grouped_pivoted_with_ratio <- mutate(trips_age_grouped_pivoted, ratio = Male / Female)

ggplot(trips_age_grouped_pivoted_with_ratio, aes(x = age, y = ratio)) + geom_point() + scale_x_log10(label = comma) + 
geom_smooth(se = FALSE)




########################################
# plot weather data
########################################

# plot the minimum temperature (on the y axis) over each day (on the x axis)

ggplot(weather, aes(x = date, y = tmin)) + geom_point()



# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

new_weather_pivoted <- pivot_longer(weather, cols = c(tmin, tmax), names_to = "temp_type", values_to = "Temp")
ggplot(new_weather_pivoted, aes(x = date, y = Temp, color =temp_type )) + geom_point()  +  labs(
    x = "Date", 
    y = "Temp"
)





########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

daily_trips <- trips_with_weather %>% mutate(date = as.Date(starttime)) %>%
    group_by(date) %>% summarize(trip_count =  n(), min_temp = min(tmin))

    ggplot(daily_trips, aes(x = min_temp, y = trip_count)) +  geom_point() + xlab("Min Temp") + ylab("Number of trips")

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

daily_summary <- trips_with_weather %>% mutate(date = as.Date(starttime)) %>%
    group_by(date) %>% summarize(trip_count_after =  n(), min_temp_after = min(tmin), substantial_prcp = min (prcp) >= 0.3)

    ggplot(daily_summary, aes(x = min_temp_after, y = trip_count_after, color =substantial_prcp )) +  
    geom_point() + xlab("Min Temp") + ylab("Number of trips")



# add a smoothed fit on top of the previous plot, using geom_smooth

daily_summary <- trips_with_weather %>% mutate(date = as.Date(starttime)) %>%
    group_by(date) %>% summarize(trip_count_after =  n(), min_temp_after = min(tmin), substantial_prcp = min (prcp) >= 0.3)

    ggplot(daily_summary, aes(x = min_temp_after, y = trip_count_after, color =substantial_prcp )) +  
    geom_point() + geom_smooth(method = "lm") + xlab("Min Temp") + ylab("Number of trips")


# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

hour_summary <- trips_with_weather %>% mutate(date =  as.Date(starttime), hour = hour(starttime)) %>%
    group_by(date, hour) %>% summarize(trips_per_hr = n(), .groups = "drop") %>% group_by(hour) %>% 
    summarize(avg = mean(trips_per_hr) , sd_trips = sd(trips_per_hr)) 




# plot the above

hour_summary <- trips_with_weather %>% mutate(date =  as.Date(starttime), hour = hour(starttime)) %>%
    group_by(date, hour) %>% summarize(trips_per_hr = n(), .groups = "drop") %>% group_by(hour) %>% 
    summarize(avg = mean(trips_per_hr) , sd_trips = sd(trips_per_hr)) 


ggplot(hour_summary, aes(x = hour, y = avg)) + geom_point(color = 'blue') + 
    geom_errorbar(aes(ymin = avg - sd_trips, ymax = avg + sd_trips))


# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

hour_by_day <- trips_with_weather %>% mutate(date =  as.Date(starttime), hour = hour(starttime), day_of_week = wday(date)) %>%
    group_by(date, day_of_week, hour) %>% summarize(trips_per_hr = n(), .groups = "drop") %>% 
    group_by(day_of_week, hour) %>% summarize(avg_trip = mean(trips_per_hr), sd_trips = sd(trips_per_hr), .groups = "drop")


    ggplot(hour_by_day, aes(x = hour, y = avg_trip, color = day_of_week)) + geom_point(color = 'blue') + 
    geom_errorbar(aes(ymin = avg_trip - sd_trips, ymax = avg_trip + sd_trips)) + scale_x_continuous(breaks = 0:23)




