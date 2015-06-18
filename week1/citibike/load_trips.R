########################################
# load libraries
########################################
library(dplyr)


# set the data directory
data_dir <- '.'

# define a function to turn strings into datetimes
parse_datetime <- function(s, format="%Y-%m-%d %H:%M:%S") {
  as.POSIXct(as.character(s), format=format)
}


########################################
# load and clean trip data
########################################

# load each month of the trip data into one big data frame
csvs <- Sys.glob(sprintf('%s/*-tripdata.csv', data_dir))
trips <- data.frame()
for (csv in csvs) {
  tmp <- read.table(csv, header=T, sep=',', na.strings='\\N')
  trips <- rbind(trips, tmp)
}

# parse the start and stop time strings to datetimes
trips <- transform(trips,
                   starttime=parse_datetime(starttime),
                   stoptime=parse_datetime(stoptime))

# add a column for year/month/day (without time of day)
trips <- transform(trips,
                   ymd=parse_datetime(strftime(starttime, format="%Y-%m-%d"), "%Y-%m-%d"))

# recode gender from (0,1,2) to (Unknown, Male, Female)
trips <- transform(trips, gender=revalue(as.factor(gender), c("0"="Unknown", "1"="Male", "2"="Female")))


########################################
# load and clean weather data
########################################

# load weather data
csv <- sprintf('%s/weather.csv', data_dir)
weather <- read.table(csv, header=T, sep=',')

# extract just a few columns, lowercase column names, and parse dates
weather <- weather[, c("DATE","PRCP","SNWD","SNOW","TMAX","TMIN")]
names(weather) <- tolower(names(weather))
weather <- transform(weather, ymd=parse_datetime(date, "%Y%m%d"))


# save data frame for easy loading in the future
save(trips, weather, file=sprintf('%s/trips.RData', data_dir))

