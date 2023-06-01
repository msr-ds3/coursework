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
# trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))


########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
nrow(trips)

# find the earliest and latest birth years (see help for max and min to deal with NAs)
#birth_year has the type of chr, convert to numeric first
birth_yrs=as.numeric(trips$birth_year)
min(birth_yrs[!is.na(birth_yrs)])
max(birth_yrs[!is.na(birth_yrs)])

# use filter and grepl to find all trips that either start or end on broadway
#find all the stations that start with broadway
#find all the stations that end in broadway
#subtsract the intersection of those two datasets
broadway_stations1=filter(trips, grepl('*broadway*',start_station_name,ignore.case=TRUE))
broadway_stations2=filter(trips, grepl('*broadway*',end_station_name,ignore.case=TRUE))
broadway_stations3=inner_join(broadway_stations1,broadway_stations2)
nrow(broadway_stations1)+nrow(broadway_stations2)-nrow(broadway_stations3)
#one line solution: using OR; do remember to put () around each grepl
nrow(filter(trips, (grepl('*broadway*',start_station_name,ignore.case=TRUE))|(grepl('*broadway*',end_station_name,ignore.case=TRUE))))

# do the same, but find all trips that both start and end on broadway
nrow(filter(trips, (grepl('*broadway*',start_station_name,ignore.case=TRUE))&(grepl('*broadway*',end_station_name,ignore.case=TRUE))))

# find all unique station names
unique(c(trips$start_station_name,trips$end_station_name))

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
group_by(trips,gender) %>% summarize(avg_trip_time=mean(tripduration/60),sd_duration=sd(tripduration/60))

# find the 10 most frequent station-to-station trips
trips$station_to_station=paste(trips$start_station_name,trips$end_station_name,sep="--")
df_routes=group_by(trips,station_to_station) %>% summarize(count=n())
arrange(df_routes,desc(count))

# find the top 3 end stations for trips starting from each start station
length(unique(trips$start_station_name))
trips %>%
  group_by(start_station_name,end_station_name) %>%
  summarize(count=n()) %>%
  group_by(start_station_name) %>%
  arrange(start_station_name,desc(count)) %>%
  top_n(3)


# find the top 3 most common station-to-station trips by gender
trips %>% 
  group_by(gender,station_to_station) %>%
  summarize(count=n())%>% 
  top_n(3) 

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>% 
  mutate(date=as.Date(starttime)) %>%
  group_by(date) %>%
  summarize(count=n()) %>%
  arrange(desc(count)) 
  
# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips %>% 
  mutate(hrs=hour(starttime)) %>%
  group_by(hrs) %>%
  summarize(cnt=n()/(length(unique(as.Date(starttime))))) %>%
  arrange(desc(cnt))
