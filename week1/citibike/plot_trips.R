########################################
# load libraries
########################################

# load some packages that we'll need
library(dplyr)
library(ggplot2)
library(reshape)
library(scales)
library(tidyr)


# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides

ggplot(trips, aes(tripduration)) + geom_histogram() + xlim(tripduration= 3000*60)

# plot the distribution of trip times by rider type
ggplot(trips, aes(tripduration, usertype)) + geom_histogram() + xlim(tripduration= 3000*60)

# plot the number of trips over each day
ggplot(trips, aes(ymd)) + geom_bar()


# plot the number of trips by gender and age
df <- group_by(trips, gender, birth_year) %>% summarize(count = n())
ggplot(df, aes(birth_year, count, color = as.factor(gender))) + geom_point() + ylim(0, 2e+05)


# plot the ratio of male to female trips by age
# hint: use the spread() function to reshape things to make it easier to compute this ratio
df_ratio <- trips %>% group_by(gender, birth_year) %>% summarize(count = n()) %>% spread(gender, count)
df_male_female <- df_ratio %>% mutate (ratio = Male/Female)
ggplot(df_male_female, aes(birth_year, ratio)) + geom_point() + ylim(0,20)
       
########################################
# plot weather data
########################################
# plot the minimum temperature over each day
ggplot(weather, aes(tmin, date)) + geom_point()

# plot the minimum temperature and maximum temperature over each day
# hint: try using the gather() function for this to reshape things before plotting
plot_data <- weather %>% gather("varibale", "value", 5:6)

ggplot(plot_data, aes(x= ymd, y= value, color=variable)) + geom_point()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
varmin <- cbind(starttime)

varmin <- trips %>% group_by(starttime) %>% summarize(count = n())



# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

# add a smoothed fit on top of the previous plot, using geom_smooth

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
num_days <- length(unique(trips$ymd))


# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
