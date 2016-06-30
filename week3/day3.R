### Implement 5-fold cross-validation for your Citibike model to get a better estimate of the error on the testing data. 
df$fold <- sample(1:5, nrow(df), replace=T)



rmse_vector <- c()
for (i in 1:5) {
  train <- filter(df, fold != i)
  test <- filter(df, fold == i)
  model2 <- lm(numtrip ~ day_of_week + tmax*prcp + is_holiday + season, data= train)
  test$predicted= predict(model2, test)
  rmse <- sqrt(mean((test$numtrip - test$predicted)^2)) 
  rmse_vector[i] <- rmse
}

avg = mean(rmse_vector) #### 3864.394
standard_error= sd(rmse_vector) / sqrt(5) ##219.2191

###########################################################################################
weather <- read.table('weather_2015.csv', header=T, sep=',')

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
###########################################################################################
####Compute the RMSE on this data set and compare the results to what you found with cross-validation
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


  
