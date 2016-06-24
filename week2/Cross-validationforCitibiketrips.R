###In this assignment we'll predict number of trips per day as a function of the weather on that day.
### 1...Create a data frame with one row for each day, the number of trips taken on that day, and the minimum temperature on that day.

trips_with_weather <- inner_join(trips, weather, by="ymd")
df <- trips_with_weather %>% group_by(ymd, tmin) %>% summarize(count = n()) 



### 2....Split the data into a randomly selected training and test set, 
###as in the above exercise, with 80% of the data for training the model and 20% for testing.
indexes <- sample(1:nrow(df), size=0.2*nrow(df))
test=df[indexes, ] 
train=df[-indexes, ] 


## 3.....Fit a model to predict the number of trips as a (linear) function of the minimum temperature, 
#and evaluate the fit on the training and testing data sets. 
#Do this first visually by plotting the predicted and actual values as a function of the minimum temperature. 
ml.fit <- lm(count ~ tmin , data= test)
test$predicted = fitted(ml.fit)
ggplot(test, aes(x=tmin, y=count)) +  geom_point(alpha=0.1) + geom_line(aes(x=tmin, y=predicted))


ml.fit2 <- lm(count ~ tmin , data= train)
train$predicted = fitted(ml.fit2)
ggplot(train, aes(x=tmin, y=count)) +  geom_point(alpha=0.1) + geom_line(aes(x=tmin, y=predicted))



#Then do this with R^2, as above. You'll want to use the predict and cor functions for this.

#for the test   : Adjusted R-squared:     0.6681 
#for the train    : Adjusted R-squared:   0.6792  

cor(test$predicted,test$count)^2 ##   0.6726852
cor(train$predicted,train$count)^2 ## 0.6803221


## 4....Repeat this procedure, but add a quadratic term to your model (e.g., + tmin^2, or equivalently + poly(k,2)). 
ml.fit3 <- lm(count ~ tmin + poly(tmin, 2), data= test)
test$predicted = fitted(ml.fit3)
ggplot(test, aes(x=tmin, y=count)) +  geom_point(alpha=0.1) + geom_line(aes(x=tmin, y=predicted)) + 
xlab('minimum temperature') +
ylab('number of trips')

ml.fit4 <- lm(count ~ tmin + poly(tmin, 2), data= train)
train$predicted = fitted(ml.fit4)
ggplot(train, aes(x=tmin, y=count)) +  geom_point(alpha=0.1) + geom_line(aes(x=tmin, y=predicted)) + 
  xlab('minimum temperature') +
  ylab('number of trips')


#for the test     : Adjusted R-squared:  0.6664   
#for the train    : Adjusted R-squared:  0.6782 

cor(test$predicted,test$count)^2 ##   0.6756687
cor(train$predicted,train$count)^2 ## 0.6804394


###How does the model change, and how do the fits between the linear and quadratic models compare?





## 5...Now automate this, extending the model to higher-order polynomials with a for loop over the degree k. 
###For each value of k, fit a model to the training data and save the R^2 on the training data to one vector and test vector to another. 

tran_cor <- c()
test_cor <- c()

for (k in 1:20){
  ml.fit5 <- lm(count ~ tmin + poly(tmin, k, raw=T), data= train)
  train$predicted = predict(ml.fit5, train)
  test$predicted = predict(ml.fit5, test)
  
  tran_cor[k] <- cor(train$predicted,train$count)^2
  test_cor[k] <- cor(test$predicted,test$count)^2
}

###Then plot the training and test R^2 as a function of k. What value of k has the best performance?

#ggplot(, aes(x=train_cor, y=)) + 













## 6....Finally, fit one model for the value of k with the best performance in 6), and plot the actual and predicted values for this model.