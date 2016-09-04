# load some packages that we'll need
library(dplyr)
library(ggplot2)
library(reshape)
library(scales)
library(tidyr)
library(lubridate)

#####Predicting daily Citibike trips

#The point of this exercise is to get experience in an open-ended prediction exercise:
#predicting the total number of Citibike trips taken on a given day. Here are the rules of the game:

###### 1.....You can use any features you like that are available prior to the day in question, 
#ranging from the weather, to the time of year and day of week, to activity in previous days or weeks, 
#but don't cheat and use features from the future (e.g., the next day's trips).



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

##############################################################
#season = function(ymd)
#{
#if (between(month(ymd), 5, 3))
#    "Spring"
#  else if (between(month(ymd), 12 , 2))
#    "Winter"
#  else if (between(month(ymd), 8 , 6))
#    "Summer"
#  else if (between(month(ymd), 11 , 9))
#    "Fall"
#}
#season = Vectorize(season)

#df$season = season(df$ymd)

########################################################
#df$weekend <- "is_weekday"
 #if (df$day_of_week == "Sun" | df$day_of_week == "Sat"){
 #     df$weekend="is_weekend" 
 #     }
 # else {
   #   df$weekend="is_weekday" }
#######################################################

ggplot(df, aes(ymd, numtrip, color=season, shape=weekend)) + geom_point()


###### 2....As usual, split your data into training and testing subsets and evaluate performance on each.

indexes <- sample(1:nrow(df), size=0.2*nrow(df))
test=df[indexes, ] 
train=df[-indexes, ] 

##### 3....Quantify your performance in two ways: 
#### R^2 (or the square of the correlation coefficient),as we've been doing, and with root mean-squared error.


model2 <- lm(numtrip ~ day_of_week + tmax +prcp + is_holiday, data= train)
test$predicted= predict(model2, test)
rmse <- sqrt(mean((test$numtrip - test$predicted)^2))  ### 3610.572
cor(test$predicted,test$numtrip )^2 #### 0.888816


#### 4 ...Report the model with the best performance on the test data. Watch out for overfitting.
model2 <- lm(numtrip ~ day_of_week + tmax +prcp + weekend + is_holiday, data= train)

#### 5....Plot your final best fit model in two different ways. 
#     First with the date on the x-axis and the number of trips on the y-axis, 
#showing the actual values as points and predicted values as a line. 

ggplot(test , aes(color=log10(prcp+0.01))) +
  geom_point(aes(x = ymd, y=numtrip, shape=snow > 0)) +
  geom_line(aes(x = ymd, y=predicted))

#Second as a plot where the x-axis is the predicted value and the y-axis is the actual value, with each point representing one day.

ggplot(test, aes(predicted, numtrip, color=is_holiday, size=log10(snow+0.01))) +
  geom_point() +
  geom_abline(slope=1)


       
### 5....Inspect the model when you're done to figure out what the highly predictive features are, 
#and see if you can prune away any negligble features that don't matter much.


library(glmnet)

x=model.matrix(numtrip ~ day_of_week + tmax +prcp + is_holiday , data= train)
y=train$numtrip
cvfit <- cv.glmnet(x,y)
plot(cvfit)
ridge.mod=glmnet(x,y,alpha=0)



dim(coef(ridge.mod)) ## 12 100
ridge.mod$lambda[50] ## 91234.01
coef(ridge.mod)[,50]
sqrt(sum(coef(ridge.mod)[-1,50]^2)) ###1281.577
predict(ridge.mod, s=50, type="coefficients")[1:20]


set.seed(1)
train = sample(1:nrow(x), nrow(x)/8)
test =(-train)
y.test=y[test]
cv.out=cv.glmnet(x[train,],y[train],alpha=0)
plot(cv.out)


bestlam=cv.out$lambda.min 
####1008.668


ridge.pred=predict(ridge.mod,s=bestlam ,newx=x[test,])

MSRE= sqrt(mean((ridge.pred-y.test)^2))
### 3988.875

# plot the predicted vs. actual values
ggplot(test, aes(x=predicted, y=numtrip) )+
  geom_histogram() +
  geom_abline(slope=1)

# plot trips over time
ggplot(test, aes(color=log10(prcp+0.01))) +
  geom_point(aes(x = ymd, y=numtrip, shape=snow > 0)) +
  geom_line(aes(x = ymd, y=predicted))


