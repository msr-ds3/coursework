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
```{r, echo = FALSE}```{r, echo = FALSE}(binwidth = 0.01)(binwidth = 0.01)(binwidth = 0.01)(binwidth = 0.01) facet_wrap(~cut) facet_wrap(~cut)#trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))
# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))

########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
nrow(trips)

#224736
# find the earliest and latest birth years (see help for max and min to deal with NAs)
select(trips,birth_year) %>%
mutate(birth_year = na_if(birth_year, "\\N"))%>%
drop_na(birth_year)%>%summarize(max_year = max(birth_year),min_year = min(birth_year))

# use filter and grepl to find all trips that either start or end on broadway
select(trips, start_station_name, end_station_name)%>%
filter( grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))

# do the same, but find all trips that both start and end on broadway
select(trips, start_station_name, end_station_name)%>%
filter( grepl('Broadway', start_station_name) , grepl('Broadway', end_station_name))

# find all unique station names
group_by(trips, start_station_name) %>% select(start_station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
group_by(trips,gender)%>%
summarize(count = n(),
mean_trip_duaration = mean(tripduration),
sd_trip_duration = sd(tripduration))

# find the 10 most frequent station-to-station trips
trips %>%
group_by(start_station_name,end_station_name)%>%
summarize (
    count=n()
)%>% arrange(desc(count))

# find the top 3 end stations for trips starting from each start station
summarize(group_by(trips,start_station_name,end_station_name),count = n())%>%
arrange(start_station_name,desc(count))%>% 
mutate(station_rank = row_number()) %>%
filter(station_rank<=3)
#%>% arrange(start_station_name)

# find the top 3 most common station-to-station trips by gender
summarize(group_by(trips,start_station_name,end_station_name, gender),
count = n())%>%
arrange(desc(count))%>%
group_by(gender)%>%
mutate (rank = row_number())%>%
filter (rank<=3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>%
mutate(date = floor_date(starttime,unit="day"))%>% 
group_by(date)%>%
summarize(count = n())%>%
arrange(desc(count))

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
trips%>%
mutate(hour = floor_date(starttime,unit="hour"),day = floor_date(starttime,unit="day"))%>% 
group_by(day,hour)%>%
summarize (count=n())%>%
group_by(hour)%>%
summarize(avg_trips = mean(count))

# what time(s) of day tend to be peak hour(s)?
trips%>%
mutate(hour = floor_date(starttime,unit="hour"),day = floor_date(starttime,unit="day"))%>% 
group_by(day,hour)%>%
summarize (count=n())%>%
group_by(hour)%>%
summarize(avg_trips = mean(count))%>%
arrange(desc(avg_trips))
