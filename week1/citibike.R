library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('201402-citibike-tripdata.csv')

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# convert dates strings to dates
#trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))


########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
nrow(trips) # 224736

# find the earliest and latest birth years (see help for max and min to deal with NAs)
filter(trips['birth_year'], birth_year==max(birth_year)) # latest-1997

filter(trips['birth_year'], birth_year != '\\N')%>%
    filter(birth_year==min(birth_year))                  # earliest-1899

# use filter and grepl to find all trips that either start or end on broadway
filter(trips, grepl('broadway', start_station_name, ignore.case=TRUE)| grepl('broadway', end_station_name, ignore.case=TRUE))

# do the same, but find all trips that both start and end on broadway
filter(trips, grepl('broadway', start_station_name, ignore.case=TRUE)& grepl('broadway', end_station_name, ignore.case=TRUE))

# find all unique station names
summarize(group_by(trips,start_station_name), count=n())

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
summarize(group_by(trips, gender),
    average_trip_time=mean(tripduration),
    std_trip=sd(tripduration))

# find the 10 most frequent station-to-station trips
summarize(group_by(trips,start_station_name,end_station_name), count=n()) %>%
    arrange(desc(count))%>%
    head(10)

# find the top 3 end stations for trips starting from each start station
summarize(group_by(trips,start_station_name,end_station_name), count=n()) %>%
    arrange(desc(count))%>%
    mutate(end_rank = row_number()) %>%
    filter(end_rank <= 3)%>%
    arrange(start_station_name)

# find the top 3 most common station-to-station trips by gender
summarize(group_by(trips,start_station_name,end_station_name, gender), count=n())%>%
    arrange(desc(count))%>%
    group_by(gender)%>%
    mutate(station_rank = row_number()) %>%
    filter(station_rank <= 3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips%>%
    select(starttime,stoptime)%>%
    mutate(date=floor_date(starttime, unit="day"))%>%
    group_by(date)%>%
    summarize(counts=n())%>%
    filter(counts==max(counts))

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
trips%>%
    select(starttime,stoptime)%>%
    mutate(hours = hour(starttime))%>%
    group_by(hours)%>%
    summarize(avg_trips_daily=n()/n_distinct(as.Date(starttime)))%>%
    print(n=24, width=Inf)

# what time(s) of day tend to be peak hour(s)?
trips%>%
    select(starttime,stoptime)%>%
    mutate(hours = hour(starttime))%>%
    group_by(hours)%>%
    summarize(count=n())%>%
    filter(count==max(count)) # 17
