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
group_by(trips,tripduration)%>%
mutate(count = n())%>%
select(tripduration,count)
ggplot(trips, aes(x = tripduration))+
geom_histogram()+ scale_x_log10(label = comma)+
xlab("Tripduration in sec")+
ylab("Num of trips")

ggplot(trips,aes(x = tripduration))+
geom_density()+
scale_x_log10(label = comma)+
xlab("Tripduration in sec")

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips,aes(x = tripduration,fill = usertype))+
geom_histogram()+
scale_x_log10(label = comma)+
xlab("Tripduration in sec")+
ylab("Num of trips")+
facet_wrap(~usertype)

ggplot(trips,aes(x = tripduration,fill = usertype))+
geom_density()+
scale_x_log10(label = comma)+
xlab("Tripduration in sec")+
facet_wrap(~usertype)

# plot the total number of trips on each day in the dataset
select(trips,starttime)%>%
mutate(day = floor_date(starttime,unit = "day"))%>%
group_by(day)%>%
summarize(counts = n())%>%
ggplot(aes(x=day,y=counts))+
geom_line()+
xlab("Days")+
ylab("Number of trips")

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
select(trips,birth_year,gender)%>%
filter(birth_year != is.na(birth_year))%>%
group_by(birth_year,gender)%>%
summarize(counts = n())%>%
ggplot(aes(x = 2014 -birth_year,y = counts,color = gender))+
geom_line()+
xlab("Age")+
ylab("Number of trips")

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
select(trips,birth_year,gender)%>%
filter(gender != "Unknown")%>%
group_by(birth_year,gender)%>%
summarize(counts = n()+1)%>%
pivot_wider(names_from = gender,values_from = counts,values_fill = 1)%>%
ggplot(aes(x = 2014 - birth_year,y = Male/Female))+
geom_point()+
xlab("Age")+
ylab("Male to Female Ratio")+
scale_y_log10(label = comma)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
select(weather,tmax,tmin,ymd)%>%
ggplot(aes(x=ymd,y=tmin))+
geom_line()+
xlab("Days")+
ylab("Temperature in Farenheit")

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
select(weather,tmax,tmin,ymd)%>%
pivot_longer(c(tmax,tmin),names_to = "type", values_to = "val")%>%
ggplot(aes(x=ymd,y=val,color = type))+
geom_line()+
xlab("Days")+
ylab("Temperature in Farenheit")

# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

select(trips_with_weather,tmin,ymd,prcp)%>%
mutate(subsPrcp = (prcp>=0.15))%>%
group_by(ymd,tmin,subsPrcp)%>%
summarize(trips = n())%>%
ggplot(aes(x=tmin,y=trips,color = subsPrcp))+
geom_point()+
xlab("Min-Temp in Farenheit")+
ylab("No of trips")+
labs(color = "Substantial Precipitaton")

# add a smoothed fit on top of the previous plot, using geom_smooth

select(trips_with_weather,tmin,ymd,prcp)%>%
mutate(subsPrcp = (prcp>=0.15))%>%
group_by(ymd,tmin,subsPrcp)%>%
summarize(trips = n())%>%
ggplot(aes(x=tmin,y=trips, color = subsPrcp))+
geom_point()+
geom_smooth(method = "lm")+
xlab("Min-Temp in Farenheit")+
ylab("No of trips")+
labs(color = "Substantial Precipitaton")

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

select(trips_with_weather,starttime,ymd)%>%
mutate(hr = hour(starttime))%>%
group_by(ymd,hr)%>%
summarize(tripsPerhr=n())%>%
group_by(hr)%>%
summarize(averagePerhr = mean(tripsPerhr), std = sd(tripsPerhr))%>%
print(n=24)

# plot the above

select(trips_with_weather,starttime,ymd)%>%
mutate(hr = hour(starttime))%>%
group_by(ymd,hr)%>%
summarize(tripsPerhr=n())%>%
group_by(hr)%>%
summarize(averagePerhr = mean(tripsPerhr), std = sd(tripsPerhr))%>%
ggplot(aes(x=hr,y=averagePerhr,ymin = averagePerhr-std,ymax = averagePerhr+std))+
geom_point()+
geom_errorbar()+
xlab("Hours of the day")+
ylab("Avg No of rides")

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

select(trips_with_weather,starttime,ymd)%>%
mutate(hr = hour(starttime),day = wday(ymd,label = TRUE))%>%
group_by(ymd,day,hr)%>%
summarize(tripsPerhr=n())%>%
group_by(hr,day)%>%
summarize(tripsPerhrday = n(),averagePerhrday = mean(tripsPerhr), std = sd(tripsPerhr))%>%
ggplot(aes(x=hr,y=averagePerhrday,ymin = averagePerhrday-std,ymax = averagePerhrday+std , color = day))+
geom_point()+
geom_errorbar()+
xlab("Hours of the day")+
ylab("Avg No of rides")+
facet_wrap(~day)
