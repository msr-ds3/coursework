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
csvs <- c(Sys.glob('*-tripdata.csv'), Sys.glob('*-tripdata_2.csv'))
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
weather <- read.table('weather_2015.csv', header=T, sep=',')

# extract just a few columns, lowercase column names, and parse dates
weather <- select(weather, DATE, PRCP, SNWD, SNOW, TMAX, TMIN)
names(weather) <- tolower(names(weather))
weather <- mutate(weather,
                  ymd = as.Date(parse_datetime(date, "%Y-%m-%d")))
weather <- tbl_df(weather)

# Get holidays
holidays <- read_csv(here('week4/bank_holiday.csv'), col_names=c("holidy_id", "ymd", "holiday_name"))

# Note: I exclude anything not in 2015, since we have a couple of 2016 new years trips
# Note that they are storing temperatures as 34 instead of 3.4
trips_per_day <- trips |>
    group_by(ymd) |>
    summarize(num_trips=n()) |>
    filter(year(ymd) == 2015) |>
    inner_join(weather, by="ymd") |>
    mutate(tmin=tmin/10, tmax=tmax/10) |>
    left_join(holidays, by="ymd") |>
    mutate(day_of_week=wday(ymd, label=T), is_weekend=day_of_week %in% c("Sun", "Sat"), is_workday=is.na(holiday_name) & !is_weekend)

# save data frame for easy loading in the future
save(trips_per_day, file='trips_2015.RData')

