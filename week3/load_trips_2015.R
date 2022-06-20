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
csvs <- Sys.glob('*-tripdata.csv')
trips <- data.frame()
for (csv in csvs) {
  print(csv)
  tmp <- read_csv(csv, na='\\N')

  # the date format changed to something ugly in 2014-09 which read_csv doesn't recognize as a datetime,
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

# save data frame for easy loading in the future
#save(trips, weather, file='trips.RData')


#Instructions to get the holidays data properly

# download the from here: https://gist.github.com/shivaas/4758439

# Manually add a new row for the name of the columns : n,ymd,holiday

# Instructions to get the data frames properly

trips_per_day_2015 <- trips %>% select(ymd)

trips_per_day_2015 <- trips_per_day_2015 %>% group_by(ymd) %>% summarize(num_trips = n())

weather_2015 <- weather %>% filter(year(ymd) == 2015)

weather_2015 <- weather_2015 %>% select(prcp, snwd, snow, tmax, tmin, ymd)

trips_per_day_2015 <- merge(trips_per_day_2015, weather_2015, by = "ymd")

holidays <- read_csv("US Bank holidays")

trips_per_day_2015 <- trips_per_day_2015 %>%
  left_join(holidays, by = "ymd") %>%
    mutate(is_holiday = as.numeric(!is.na(holiday))) %>%
      mutate(is_weekend = as.numeric(wday(ymd) == c(1, 7))) %>%
        select(-c(n, holiday))

# Save data

save(trips_per_day_2015, file='trips_2015.RData')

