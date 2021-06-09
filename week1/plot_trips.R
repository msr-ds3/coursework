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
ggplot(trips, aes(x = tripduration/60)) + geom_histogram(bins = 100)+scale_x_log10(label=comma) + xlim(c(0,60))
ggplot(trips, aes(x = tripduration)) + geom_density()+scale_x_log10(label = comma)


# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration/60, color = usertype, fill = usertype)) + 
  geom_histogram(bins = 100)+scale_x_log10(label=comma) + xlim(c(0,60)) + 
    scale_y_continuous(labels = comma)+ facet_wrap(~usertype)

ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) + 
  geom_density()+scale_x_log10(label = comma)+
   facet_wrap(~usertype)

# plot the total number of trips on each day in the dataset

#summarize(group_by(trips,ymd), count = n() )%>% 
plot_data <- trips %>%
  group_by(ymd)%>%
  summarize(num_trips = n()) 

ggplot( data = plot_data, mapping=aes( x = ymd, y = num_trips) ) + geom_line()

#or
trips %>%
  group_by(ymd)%>%
  summarize(num_trips = n()) %>%
  ggplot( aes( x = ymd, y = num_trips) ) + 
  geom_line()
  



# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips%>%
  mutate( age = 2014 - birth_year)%>%
  ggplot(aes(age, color = gender, fill = gender)) +
  geom_histogram(bins = 100) +
  scale_y_continuous(labels = comma)+
  facet_wrap(~ gender)

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the spread() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered spread() yet)

trips%>%
  mutate( age = 2014 - birth_year)%>%
  count(gender,age)%>%
  pivot_wider(names_from = gender, values_from = n)%>%
  mutate( ratio = Male/Female)%>%
  ggplot(aes(x=age, y=ratio))+
  geom_bar(stat = "identity")+
  xlim(c(18,90))
  

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

ggplot(data = weather,aes(x = ymd, y = tmin))+ 
  geom_point()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the gather() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

  weather%>%
  pivot_longer(c(tmin,tmax),names_to = "type" , values_to = "temprature")%>%
   ggplot(aes( x = ymd , y = temprature, color = type))+ 
    geom_point()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
   trips_with_weather%>%
     count(ymd,tmin)%>%
     ggplot(aes( x = n, y = tmin ))+ geom_point()



# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
 
   trips_with_weather%>%
     count(ymd,tmin,prcp)%>%
     mutate(Tf = if_else(prcp > 0, "true", "false"))%>%
     ggplot(aes( x = n, y = tmin))+ 
     geom_point()+
     facet_wrap(~Tf)
 
  

# add a smoothed fit on top of the previous plot, using geom_smooth
   
   trips_with_weather%>%
     count(ymd,tmin,prcp)%>%
     mutate(Tf = if_else(prcp > 0, "true", "false"))%>%
     ggplot(aes( x = n, y = tmin))+ 
     geom_point()+
     facet_wrap(~Tf)+
     geom_smooth()
  

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
   trips_with_weather%>%
    mutate(hour = lubridate::hour(starttime))%>%
    count(hour,ymd)%>%
     group_by(hour)%>%
     summarize(mean_trip= mean(n),
              sd_trip = sd(n))

# plot the above
   
   trips_with_weather%>%
     mutate(hour = lubridate::hour(starttime))%>%
     count(hour,ymd)%>%
     group_by(hour)%>%
     summarize(mean_trip= mean(n),
               sd_trip = sd(n))%>%
     ggplot(aes(x = hour, y=mean_trip))+geom_point(color = "red")+
     geom_point(aes(x = hour, y=sd_trip))
     

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
   trips_with_weather%>%
     mutate(hour = lubridate::hour(starttime))%>%
     count(hour,ymd)%>%
     mutate(day = lubridate:: wday(ymd) )%>%
     group_by(hour,day)%>%
     summarize(mean_trip= mean(n),
               sd_trip = sd(n))%>%
     ggplot(aes(x = hour, y=mean_trip))+geom_point(color = "red")+
     geom_point(aes(x = hour, y=sd_trip))+
       facet_wrap(~day)