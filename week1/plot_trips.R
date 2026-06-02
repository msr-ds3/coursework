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
ggplot(aes(x=tripduration)) + geom_histogram()+
scale_x_log10(label = comma )+ xlab('Trip Duration') +ylab('Count')

ggplot(trips,aes(x=tripduration))+ geom_density(fill = "grey"  )+
scale_x_log10(label = comma )+ xlab('Trip Duration') +ylab('Count')

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration  , color = usertype, fill =  usertype ))  + geom_histogram() +scale_x_log10(label = comma )+
xlab('Trip Duration') +ylab('Count of Trips')
ggplot(trips, aes(x = tripduration  , color = usertype, fill =  usertype ))  + geom_density() +scale_x_log10(label = comma )+
xlab('Trip Duration') +ylab('Count of Trips')

# plot the total number of trips on each day in the dataset
trips %>%
mutate(day = floor_date(starttime,unit="day"))%>%
group_by(day)%>%
summarize(count = n())%>%
ggplot(aes(x = day,y = count)) + geom_line() + xlab('Day') +ylab('Number of Trips')
# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
group_by(birth_year,gender)%>%
summarize(count = n())%>%
group_by(gender)%>%
ggplot(aes(x = 2014 - birth_year, y = count, fill = gender, color = gender))+
geom_line() +scale_y_log10(label = comma ) + xlab('Age') +ylab('Number of Trips')

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
filter(birth_year != is.na(birth_year)) %>% 
group_by(gender,birth_year)%>%summarize(count = n())%>%
pivot_wider(names_from = gender,values_from = count,values_fill =  1 ) %>% 
mutate(mtof_ratio = Male/Female)%>%
ggplot(aes(x = 2014 - birth_year , y = mtof_ratio )) + geom_point()+ xlab('Age') +ylab('Ratio to Male and Female')


########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather%>%
mutate(day = floor_date(ymd,unit="day"))%>%
ggplot(aes(x = day , y = tmin))+ geom_point()+scale_y_log10(label = comma )+ xlab('Day') +ylab('Minimum Temperature')

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
select(date,tmin,tmax) %>%
pivot_longer(names_to ="temp", values_to = "temp_values", 2:3 )%>%
ggplot(aes(x = date, y = date ))+geom_point() +  xlab('Day') +ylab('Minimum And Maximum Temperature')


########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather%>%
group_by(ymd,tmin)%>%
summarize(count=n())%>%
ggplot(aes(x=tmin, y = count))+geom_point()+ xlab('Minimum Temperature per day') +ylab('Number of Trips')

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather%>%
mutate(prcptf = ifelse (prcp > mean(prcp) , "T", "F")) %>% 
group_by(ymd,tmin,prcptf)%>%
summarize(count=n())%>% 
ggplot(aes(x=tmin, y = count)) +geom_point()+ facet_wrap(~prcptf) +xlab('Minimum Temperature per day') +ylab('Number of Trips')

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather%>% 
mutate(prcptf = ifelse (prcp > mean(prcp) , "T", "F")) %>% 
group_by(ymd,prcptf)%>%
summarize(count=n(), mean = mean(tmin))%>% 
ggplot(aes(x=mean, y = count)) +geom_point()+xlab('Minimum Temperature per day') +ylab('Number of Trips')+geom_smooth(method = "lm")
# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_weather %>% 
mutate(hour = hour(starttime),day = floor_date(ymd,unit="day"))%>% 
group_by(day,hour) %>% 
summarize (count = n())%>% 
group_by(hour)%>%summarize (mean = mean(count),sd = sd(count))
# plot the above
trips_with_weather %>% 
mutate(hour = hour(starttime),day = floor_date(ymd,unit="day"))%>% 
group_by(day,hour) %>% 
summarize (count = n())%>% 
group_by(hour)%>%
summarize (mean = mean(count),sd = sd(count))%>%
ggplot(aes( x= hour))+ geom_ribbon(aes(ymin = mean - sd , ymax  = sd + mean,alpha = 0.25)) + xlab(' Hour') +ylab('SD and Mean of Trips')
# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather %>% 
mutate(weekday = wday(starttime,label = TRUE),hour = hour(starttime),day = floor_date(ymd,unit="day"))%>% 
group_by(day,hour,weekday)%>%summarize (count= n())%>%
group_by(hour,weekday)%>%
summarize (mean = mean(count),sd = sd(count))%>%
ggplot(aes( x= hour))+ 
geom_ribbon(aes(ymin = mean - sd , ymax  = sd + mean,alpha = 0.25))+facet_wrap(~weekday,scale ="free")
+ xlab(' Hour') +ylab('SD and Mean of Trips')
