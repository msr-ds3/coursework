library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################




# read one month of data
trips <- read_csv('./coursework/week1/201402-citibike-tripdata.csv')
##viewing the data
view(trips)

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# convert dates strings to dates
# trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))


########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
nrow(trips)


# find the earliest and latest birth years (see help for max and min to deal with NAs)

#converting birth_year into numbers
trips$birth_year <- as.numeric(trips$birth_year)
max(trips$birth_year, na.rm = TRUE)
min(trips$birth_year, na.rm = TRUE)

# use filter and grepl to find all trips that either start or end on broadway
filtered_df <- filter(trips, grepl("Broadway", start_station_name) | grepl("Broadway",end_station_name))
view(filtered_df)
# do the same, but find all trips that both start and end on broadway
filtered_both_df <- filter(trips, grepl("Broadway", start_station_name) & grepl("Broadway",end_station_name))
nrow(filtered_both_df)
# find all unique station names
#stupid idea nrow(distinct(trips[ ,"start_station_name"])) + nrow(distinct(trips[ ,"end_station_name"]))

union(trips$start_station_name, trips$end_station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
grouped_df <- trips %>%
    group_by(gender)%>%
    summarize(num_trips = n(),
     average_trip = mean(tripduration)/60,
     standard_deviation = sd(tripduration)/60)
grouped_df




# find the 10 most frequent station-to-station trips

frequent_df <- trips %>%
  group_by(start_station_name, end_station_name) %>%
  summarize(num_trips = n()) %>%
  arrange(desc(num_trips))

head(frequent_df,10)

# find the top 3 end stations for trips starting from each start station

trips %>%
  group_by(start_station_name, end_station_name) %>%
  summarize(num_trips = n()) %>%
    group_by(start_station_name) %>%
    arrange(desc(num_trips))%>%
    slice(1:3)



top3_end_stations
# find the top 3 most common station-to-station trips by gender
trips %>%
    group_by(start_station_name, end_station_name, gender) %>%
    summarize(num_trips= n())%>%
    group_by(gender)%>%
    arrange(desc(num_trips))%>%
    slice(1:3)




# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>%
    mutate(date_only = as.Date(starttime)) %>%
    count(date_only)%>%
    arrange(desc(n)) %>%
    head(1)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
view(trips)
trips %>% mutate( hours = hour(starttime)) %>%
    group_by(hours) %>% summarise(count = n(), day_in_month_count = days_in_month(starttime), avg = count /  day_in_month_count)
 
trips %>% mutate( hours = hour(starttime)) %>%
    group_by(hours) %>% summarise(count = n()) %>%  arrange(desc(count)) %>% slice(1)
 



