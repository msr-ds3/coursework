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
trips %>% mutate(trip_times=tripduration/60) %>% 
  filter(trip_times<1e4)%>%
  ggplot(aes(x=trip_times)) +
  geom_histogram()+
  scale_x_log10()+
  labs(x="trip times in minutes",y="count")

trips %>% mutate(trip_times=tripduration/60) %>% 
  ggplot(aes(x=trip_times)) +
  geom_density(fill="grey")+
  scale_x_log10()+
  xlab("trip times in minutes")+
  ylab("Density")


# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
#by default, geom_histogram has stack for position
trips %>% ggplot(aes(x=tripduration/60,color=usertype,fill=usertype)) +
  geom_histogram(position="identity",alpha=0.5)+
  scale_x_log10()+
  labs(x="trip times in minutes",y="count")


#area under the curve is 1; density gives you an idea of distribution, not the number of customers/subscribers
trips %>%
  group_by(usertype) %>%
  summarize(tripdurationByUser=mean(tripduration/60))

trips %>% ggplot(aes(x=tripduration/60,color=usertype,fill=usertype)) +
  geom_density(alpha=0.5)+
  geom_vline(xintercept =27)+
  scale_x_log10()+
  labs(x="Trip times in minutes",y="Density")

#trips %>% group_by(usertype) %>% summarize(avg_tripTimes=mean(tripduration))

# plot the total number of trips on each day in the dataset
trips %>% mutate(days=as.Date(starttime)) %>%
  #count(days) %>%
  ggplot(aes(x=days))+
  geom_histogram()+
  xlab("Days")+
  ylab("Number of Trips")
  
trips %>% 
  group_by(ymd) %>%
  summarize(count=n()) %>% ggplot(aes(x=ymd,y=count))+
  geom_line()

trips %>% mutate(days=as.Date(starttime)) %>%
  count(days) %>%
  ggplot(aes(x=days,y=n))+
  geom_col()+
  xlab("Days")+
  ylab("Number of Trips")

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
#where do null values go?
trips %>% ggplot(aes(x=birth_year,color=gender))+
  geom_bar(position="identity",alpha=0.5)+
  scale_y_log10()
  xlab("Birth Year")+
  ylab("Number of Trips")
#trips %>% count(gender)
trips %>% count(birth_year) %>%arrange(desc(n))
  
# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
trips %>% filter(gender=="Male" | gender=="Female") %>%
  group_by(birth_year) %>% count(gender) %>%
  pivot_wider(names_from = gender,values_from = n) %>%
  ggplot(aes(x=birth_year,y=Male/Female)) +
  geom_point()+
  xlab("birth_year")+
  ylab("male to female trip ratio")

# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>% 
  ggplot(aes(x=date(date),y=tmin)) +
    geom_point()+
    geom_smooth()+
    xlab("Date")+
    ylab("Min Temperature")+ theme(axis.text.x=element_text(angle=-90))
  
# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%select(date,tmax,tmin)  %>%
  pivot_longer(names_to = "min_max_temp",values_to="temp",2:3) %>%
  ggplot(aes(x=as.Date(date),y=temp,color=min_max_temp))+
  geom_point()+
  geom_smooth()+
  xlab("Date")+
  ylab("Temperature")


########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather%>% 
  group_by(date) %>%
  count(tmin)%>%
  ggplot(aes(x=tmin,y=n))+
  geom_point()+
  geom_smooth()+
  xlab("Min Temp")+
  ylab("Number of Trips")

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
mean_prcp=mean(weather$prcp)
trips_with_weather %>%mutate(sub_prcp=prcp>=mean_prcp) %>%
  group_by(ymd,tmin,sub_prcp) %>%
  summarize(count=n()) %>%
  ggplot(aes(x=tmin,y=count,color=sub_prcp))+
  geom_point()+
  geom_smooth()+
  xlab("tmin")+
  ylab("The number of trips")
  
trips_with_weather %>%mutate(sub_prcp=prcp>=mean_prcp) %>% 
  group_by(sub_prcp) %>%
  summarize(count=n()) %>%
  ggplot(aes(x=sub_prcp,y=count,color=sub_prcp,fill=sub_prcp))+
  geom_col()+
  labs(x="substantial precipitation",y="number of trips")
# add a smoothed fit on top of the previous plot, using geom_smooth

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
ndays=length(unique(date(trips$ymd)))
trips %>% group_by(date(ymd),hrs=hour(starttime)) %>%
  summarize(count=n()) %>%
  group_by(hrs) %>%
  summarize(avg_num_trips=mean(count),std=sd(count)) %>%
  ggplot(aes(x=hrs,y=avg_num_trips))+
  geom_point()+
  geom_smooth()+
  geom_errorbar(aes(ymin=avg_num_trips-std,ymax=avg_num_trips+std))+
  xlab("hours")+
  ylab("Avg Num of Trips")

# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

trips %>%  mutate(weekdays=wday(ymd,label=TRUE))%>%
  group_by(date(ymd),weekdays,hrs=hour(starttime)) %>%
  summarize(count=n()) %>%
  group_by(weekdays,hrs) %>%
  summarize(avg_num_trips=mean(count),std=sd(count)) %>%
  ggplot(aes(x=hrs,y=avg_num_trips,color=weekdays))+
  geom_point()+
  #geom_smooth()+
  scale_y_log10()+
  #geom_errorbar(aes(ymin=avg_num_trips-std,ymax=avg_num_trips+std))+
  xlab("hours")+
  ylab("Avg Num of Trips")

trips %>% mutate(weekdays=wday(ymd,label=TRUE)) %>%
  select(ymd,weekdays) %>%
  group_by(ymd,weekdays) %>%
  summarize(count=n()) %>%
  group_by(weekdays)%>%
  summarize(avg_wkd_trips=mean(count),std=sd(count)) %>%
  ggplot(aes(x=weekdays,y=avg_wkd_trips))+
  geom_point()+
  geom_smooth()+
  geom_errorbar(aes(ymin=avg_wkd_trips-std,ymax=avg_wkd_trips+std))+
  xlab("Weekdays")+
  ylab("Avg Number of Trips")