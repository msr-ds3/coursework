library(dplyr)
library(readr)
library(timeDate)
library(lubridate)


# load model
load('model.RData')

#load 2015 weather data
weather <- read.table('weather_2015.csv', header=T, sep=',')

# extract just a few columns, lowercase column names, and parse dates
weather <- select(weather, DATE, PRCP, SNWD, SNOW, TMAX, TMIN)
names(weather) <- tolower(names(weather))
weather <- mutate(weather,
                  tmin = tmin / 10,
                  tmax = tmax / 10,
                  ymd = as.Date(parse_datetime(date, "%Y%m%d")))
weather <- tbl_df(weather)


#Create predictTrips dataframe with all features

holidays15 = as.Date(c("2015-01-01", "2015-01-19", "2015-02-16", "2015-05-25", "2015-07-03", "2015-09-07", "2015-10-12", "2015-11-11", "2015-11-26", "2015-12-25"))

predictTrips <- mutate(weather, is_WeekDay = as.numeric(isWeekday(ymd)), is_Holiday = as.numeric(ymd %in% holidays15), sub_prcp = as.numeric(prcp > .5), sub_snwd = as.numeric(snwd >1.25), snowing = as.numeric(snow > 0), dayWeek = wday(ymd, label = TRUE))

#Predict trips  

predictTrips$predicted <- predict(model, predictTrips)
