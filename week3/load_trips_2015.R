library(dplyr)
library(readr)

# define a function to turn strings into datetimes
parse_datetime <- function(s, format="%Y-%m-%d %H:%M:%S") {
  as.POSIXct(as.character(s), format=format)
}

########################################
# load and clean trip data
########################################

# load each month of the trip data into one big data frame
csvs <- Sys.glob('2015*-tripdata.csv')
trips <- data.frame()
for (csv in csvs) {
  print(csv)
  tmp <- read_csv(csv, na='\\N')
  
  # the date format changed to something ugly in 2015-09 which read_csv doesn't recognize as a datetime,
  # so manually convert the date from a string to a datetime
  if (typeof(tmp$starttime) == "character")
    tmp <- mutate(tmp,
                  starttime=parse_datetime(starttime, "%m/%d/%Y %H:%M"),
                  stoptime=parse_datetime(stoptime, "%m/%d/%Y %H:%M"))
  
  trips <- rbind(trips, tmp)
}

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# add a column for year/month/day (without time of day)
trips <- mutate(trips, ymd=as.Date(starttime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender=factor(gender, levels=c(0,1,2), labels=c("Unknown","Male","Female")))

### save trips_2015
save(trips, file="justTrips_2015.RData")

########################################
# load and clean weather data
########################################

# load weather data from belvedere tower in central park
# https://www.ncei.noaa.gov/orders/cdo/2992179.csv
# ordered from
# http://www.ncdc.noaa.gov/cdo-web/datasets/GHCND/stations/GHCND:USW00094728/detail

weather <- read.table('weather.csv', header=T, sep=',')

# extract just a few columns, lowercase column names, and parse dates
weather <- select(weather, DATE, PRCP, SNWD, SNOW, TMAX, TMIN)
names(weather) <- tolower(names(weather))
weather <- mutate(weather,
                  ymd = as.Date(parse_datetime(date, "%Y-%m-%d")))
weather <- tbl_df(weather)


# rebuild yesterday's model 
trips_test <- trips %>% group_by(ymd) %>% summarize(num_trips = n())
trips_test2 <-  trips %>% group_by(ymd) %>% summarize(num_trips = n())

library(lubridate)

holidays <- read.table(file = "holidays.csv", sep = ',', header = FALSE, col.names = c("row", "ymd", "holiday_name")) %>% select(ymd) %>% mutate(ymd = as.Date(ymd), is_holiday = "Holiday")
trips_test <- right_join(holidays, trips_test, "ymd") %>% 
  mutate(is_holiday= ifelse(is.na(is_holiday), "Not_holiday", is_holiday))%>%
  mutate(is_weekend = ifelse(wday(ymd, week_start = 1) > 5, "Weekend", "Weekday")) 


# join weather and trips 
trips_test <- inner_join(weather, trips_test, "ymd") %>% 
  mutate(weather = ifelse(prcp > 0, "Raining", "Good_weather")) %>% 
  mutate(weather = ifelse(snwd > 0, "Snowing", weather))


# save data frame for easy loading in the future
save(trips_test, weather, file='trips_2015.RData')
