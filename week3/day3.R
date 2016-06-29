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


  
