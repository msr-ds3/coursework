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

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# add a column for year/month/day (without time of day)
trips <- mutate(trips, ymd=as.Date(starttime))


########################################
# load and clean weather data
########################################

# load weather data
weather <- read.table('weather.csv', header=T, sep=',')

# extract just a few columns, lowercase column names, and parse dates
weather <- select(weather, DATE, PRCP, SNWD, SNOW, TMAX, TMIN)
names(weather) <- tolower(names(weather))
weather <- mutate(weather,
                  tmin = tmin / 10,
                  tmax = tmax / 10,
                  ymd = as.Date(parse_datetime(date, "%Y%m%d")))
weather <- tbl_df(weather)

# save data frame for easy loading in the future
save(trips, weather, file='trips.RData')

