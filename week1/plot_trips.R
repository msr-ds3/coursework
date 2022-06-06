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
ggplot(trips, aes(x = tripduration)) +
  geom_histogram(bins = 200) +
  scale_x_continuous(label = comma, limits = c(0,5000)) +
  scale_y_continuous(label = comma) + 
  xlab('Trip Time') + 
  ylab('Count')

ggplot(trips, aes(x = tripduration)) + 
  geom_density(fill = "grey") + 
  scale_x_log10(label = comma) + 
  xlab('Trip Time') + 
  ylab('Count')

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) + 
  geom_histogram(bins = 200) + 
  scale_x_continuous(label = comma, limits = c(0,5000)) + 
  scale_y_continuous(label = comma) + 
  xlab('Trip Time') + 
  ylab('Count')

ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) + 
  geom_density() + 
  scale_x_log10(label = comma) + 
  facet_wrap(~ usertype) +
  xlab('Trip Time') + 
  ylab('Count')

# plot the total number of trips on each day in the dataset
ggplot(trips, aes(x = starttime)) +
  geom_histogram(bins = 200) +
  scale_y_continuous(label = comma) +
  xlab("Day") +
  ylab("Count of Trips")

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
ggplot(trips, aes(x = 2022-birth_year, color = gender, fill = gender)) + 
  geom_histogram(bins = 200) + 
  scale_y_continuous(label= comma) + 
  facet_wrap(~ gender) + 
  xlab('Age') + 
  ylab('Count') 

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
ggplot(weather, aes(x = date, y = tmin)) + 
  geom_point() + 
  xlab('Days') + 
  ylab('Minimum Temperature') + 
  coord_flip()

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
num_trips <- trips %>%
  filter(grepl('2014-02',starttime))

summary <- num_trips %>%
  group_by(ymd) %>%
  summarize(count = n())

trips_weather <- inner_join(summary, weather, by="ymd")

ggplot(trips_weather, aes(x = tmin, y = count, label = ymd)) +
  geom_point() +
  geom_text(position = "identity", size = 2, vjust = 1.5) +
  xlab("Minimum Temperature") +
  ylab("Number of Trips") 

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_weather$subs_precip <- trips_weather$prcp >= 0.1
  
ggplot(trips_weather, aes(x = tmin, y = count, label = ymd)) +
  geom_point() +
  geom_text(position = "identity", size = 2, vjust = 1.5) +
  facet_wrap(~ subs_precip) +
  xlab("Minimum Temperature") +
  ylab("Number of Trips") 

# add a smoothed fit on top of the previous plot, using geom_smooth
ggplot(trips_weather, aes(x = tmin, y = count, label = ymd)) +
  geom_point() +
  geom_text(position = "identity", size = 2, vjust = 1.5) +
  geom_smooth(method = "lm") +
  scale_y_log10(label = comma) +
  facet_wrap(~ subs_precip) +
  xlab("Minimum Temperature") +
  ylab("Number of Trips")

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather$hour <- hour(trips_with_weather$starttime)

summ_by_hour <- trips_with_weather %>%
  group_by(ymd,hour) %>% 
  summarize(count = n())

hours_summary <- summarize(group_by(summ_by_hour,hour),
                           average_num_trips = mean(count),
                           sd_num_trips = sd(count))
head(hours_summary)
  
# plot the above
ggplot(hours_summary) +
  geom_point(aes(x = hour,  y = average_num_trips, color = "average num. of trips")) + 
  geom_point(aes(x = hour, y = sd_num_trips, color = "standard deviation")) + 
  xlab("Hour of Day") + 
  ylab("Num of Trips") + 
  scale_color_manual("",
                     breaks = c("average num. of trips", "standard deviation"),
                     values = c("red", "blue"))

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather$day_of_week <- wday(trips_with_weather$ymd)

summ_by_day <- trips_with_weather %>%
  group_by(ymd,day_of_week) %>%
  summarize(count = n())

day_summary <- summarize(group_by(summ_by_day,day_of_week),
            average_num_trips = mean(count),
            sd_num_trips = sd(count))

ggplot(day_summary) + 
  geom_point(aes(x = day_of_week, y = average_num_trips, color = "average num. of trips")) + 
  geom_point(aes(x = day_of_week, y = sd_num_trips, color = "standard deviation")) + 
  xlab("Day of the Week") + 
  ylab("Num of Trips") +
  scale_color_manual("", 
                     breaks = c("average num. of trips", "standard deviation"),
                     values = c("red", "blue"))
