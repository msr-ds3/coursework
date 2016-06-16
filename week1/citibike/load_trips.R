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
  tmp <- read_csv(csv, na='\\N')
  trips <- rbind(trips, tmp)
}

# add a column for year/month/day (without time of day)
trips <- transform(trips, ymd=as.Date(starttime))

# recode gender from (0,1,2) to (Unknown, Male, Female)
#trips <- transform(trips, gender=revalue(as.factor(gender), c("0"="Unknown", "1"="Male", "2"="Female")))


########################################
# load and clean weather data
########################################

# load weather data
weather <- read.table('weather.csv', header=T, sep=',')

# extract just a few columns, lowercase column names, and parse dates
weather <- select(weather, DATE, PRCP, SNWD, SNOW, TMAX, TMIN)
names(weather) <- tolower(names(weather))
weather <- transform(weather, ymd=parse_datetime(date, "%Y%m%d"))
weather <- tbl_df(weather)

# save data frame for easy loading in the future
save(trips, weather, file='trips.RData')

