########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides

ggplot(trips, ase(tripduration)) + geom_bar()

# plot the distribution of trip times by rider type
ggplot(trips, ase(tripduration, usertype)) + geom_bar()

# plot the number of trips over each day
ggplot(trips, ase(ymd)) + geom_bar()


# plot the number of trips by gender and age

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the minimum temperature over each day

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

# add a smoothed fit on top of the previous plot, using geom_smooth
