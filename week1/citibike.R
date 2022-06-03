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
filtered_trips <- trips %>% 
  filter(birth_year > 0)
earliest <- min(filtered_trips$birth_year)
print(earliest)
latest <- max(trips$birth_year)
print(latest)

# use filter and grepl to find all trips that either start or end on broadway
filter(trips, grepl('Broadway',start_station_name) | grepl('Broadway',end_station_name))

# do the same, but find all trips that both start and end on broadway
filter(trips, grepl('Broadway',start_station_name) & grepl('Broadway',end_station_name))

# find all unique station names
unique(trips$start_station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
summarize(group_by(trips,gender),
          count = n(),
          average_trip_time = mean(tripduration),
          sd_trip_time = sd(tripduration))

# find the 10 most frequent station-to-station trips
station_to_station <- summarize(group_by(trips,start_station_name,end_station_name),
          count = n())

count_station_to_station <- station_to_station %>%
  arrange(desc(count))

head(count_station_to_station,10)

# find the top 3 end stations for trips starting from each start station
end_station <- summarize(group_by(trips,end_station_name),
                        count = n())
count_end_station <- end_station %>% arrange(desc(count))
head(count_end_station,3)

# find the top 3 most common station-to-station trips by gender
station_to_station_gender <- summarize(group_by(trips,start_station_name,end_station_name,gender),
                               count = n())

count_station_gender <- station_to_station_gender %>% 
  arrange(gender) %>% 
  arrange(desc(count))

male_top <- filter(count_station_gender,gender == "Male")
head(male_top,3)

female_top <- filter(count_station_gender,gender == "Female")
head(female_top,3)

unknown_top <- filter(count_station_gender,gender == "Unknown")
head(unknown_top,3)

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips$day <- floor_date(trips$starttime,unit = c("day")) 

summary <- trips %>%
  group_by(day) %>%
  summarize(count = n()) %>%
  arrange(desc(count))
head(summary,1)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips$hour <- hour(trips$starttime)

hours_summary <- trips %>%
  group_by(hour) %>%
  summarize(count = n()/28) %>%
  arrange(desc(count))
head(hours_summary,10)
