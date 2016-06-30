# load some packages that we'll need
library(dplyr)
library(ggplot2)
library(reshape)
library(scales)
library(tidyr)
library(lubridate)
library(readr)


# load and clean weather data
########################################

# load weather data from belvedere tower in central park
# https://www.ncei.noaa.gov/orders/cdo/762757.csv
# ordered from
# http://www.ncdc.noaa.gov/cdo-web/datasets/GHCND/stations/GHCND:USW00094728/detail
weather_2015 <- read.table('weather_2015.csv', header=T, sep=',')

# extract just a few columns, lowercase column names, and parse dates
weather_2015 <- select(weather_2015, DATE, PRCP, SNWD, SNOW, TMAX, TMIN)
names(weather_2015) <- tolower(names(weather_2015))
weather_2015 <- mutate(weather_2015,
                  tmin = tmin / 10,
                  tmax = tmax / 10,
                  ymd = as.Date(parse_datetime(date, "%Y%m%d")))
weather_2015 <- tbl_df(weather_2015)

# save data frame for easy loading in the future
save(trips, weather_2015, file='trips.RData')




########################################
####Create another col for day_of_week
weather_2015 <- weather_2015 %>% mutate(day_of_week = wday(ymd, label=T)) 

########################################
####Create another col for is_weekend

is_weekend = function(ymd)
{
  if (wday(ymd) ==1 | wday(ymd)==7)
  {
    TRUE
  }else
    
  {FALSE
    
  }
}
is_weekend = Vectorize(is_weekend)

weather_2015$is_weekend = is_weekend(weather_2015$ymd)

#### Creaye another col for is_holiday

holidays15 = as.Date(c("2015-01-01", "2015-01-19", "2015-02-16", "2015-05-25", "2015-07-03", "2015-09-07", "2015-10-12", "2015-11-11", "2015-11-26", "2015-12-25"))
weather_2015 <- mutate(weather_2015, is_holiday = ymd %in% holidays15)

season = function(ymd)
{
  if (month(ymd)== 12 | month(ymd)== 1 |month(ymd) == 2)
    "Winter"
  else if (month(ymd) == 3 | month(ymd) == 4 | month(ymd) == 5)
    "Spring"
  else if (month(ymd) == 6 | month(ymd) == 7 | month(ymd) == 8)
    "Summer"
  else 
    "Fall"
}
season = Vectorize(season)

weather_2015$season = season(weather_2015$ymd)
#######################################################
##first we create 2014 data frame:
trips_with_weather <- inner_join(trips, weather, by="ymd")
df <- trips_with_weather %>% group_by(ymd, tmax, tmin,snow,prcp,snwd) %>% summarize(numtrip = n()) 
df <- df %>% mutate(day_of_week = wday(ymd, label=T)) 

is_weekend = function(ymd)
{
  if (wday(ymd) ==1 | wday(ymd)==7)
  {
    TRUE
  }else
    
  {FALSE
    
  }
}
is_weekend = Vectorize(is_weekend)

df$weekend = is_weekend(df$ymd)




holidays <- as.Date(c("2014-01-01","2014-01-20","2014-02-17","2014-05-26","2014-07-04","2014-09-01","2014-10-13","2014-11-11","2014-11-27","2014-12-25"))
df <- mutate(df, is_holiday = ymd %in% holidays)




season = function(ymd)
{
  if (month(ymd)== 12 | month(ymd)== 1 |month(ymd) == 2)
    "Winter"
  else if (month(ymd) == 3 | month(ymd) == 4 | month(ymd) == 5)
    "Spring"
  else if (month(ymd) == 6 | month(ymd) == 7 | month(ymd) == 8)
    "Summer"
  else 
    "Fall"
}
season = Vectorize(season)

df$season = season(df$ymd)
######################################################################
###Predict num trips:
####predict for 2015

model <- lm(numtrip ~ day_of_week + tmax +prcp + is_holiday, data= df)
weather_2015$predicted= predict(model,weather_2015)



#rmse <- sqrt(mean((weather_2015$ - weather_2015$)^2))  ### 
#cor(weather_2015$,weather_2015$)^2 #### 




