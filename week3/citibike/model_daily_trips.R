library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(glmnet)

theme_set(theme_bw())

########################################
# prepare training/test data
########################################

load('trips.RData')

# count the number of trips per day
trips_per_day <- trips %>%
  group_by(ymd) %>%
  summarize(num_trips=n())

# create a vector of holidays
holidays <- as.Date(c("2014-01-01",
                      "2014-01-20",
                      "2014-02-17",
                      "2014-05-26",
                      "2014-07-04",
                      "2014-09-01",
                      "2014-10-13",
                      "2014-11-11",
                      "2014-11-27",
                      "2014-12-25"))

# join trip info and weather for each day
# mark each holiday with an indicator
trips_per_day <- inner_join(trips_per_day, weather, by="ymd") %>%
  mutate(day_of_week = wday(ymd, label = T),
         is_holiday = ymd %in% holidays,
         holiday_effect = as.factor(ifelse(ymd %in% holidays, ymd, 0)))

#trips_per_day <- filter(trips_per_day, !is_holiday)

# randomly select 80% of the data to train the model on
set.seed(42)
num_days <- nrow(trips_per_day)
ndx <- sample(1:num_days, round(0.8 * num_days))

# use this data frame to fit your model
trips_per_day_train <- trips_per_day[ndx, ]

# pretend this doesn't exist (for now!)
trips_per_day_test <- trips_per_day[-ndx, ]

########################################
# fit and evaluate a linear model
########################################

# fit a linear model
model <- lm(num_trips ~ log(prcp+0.01) + log(snow+0.01)*poly(tmax,3) + log(snow+0.01)*poly(tmin,3) + day_of_week + is_holiday, data = trips_per_day_train)

# look at the r^2 on the training and test data
cor_train <- cor(predict(model, trips_per_day_train), trips_per_day_train$num_trips)
cor_train^2
cor_test <- cor(predict(model, trips_per_day_test), trips_per_day_test$num_trips)
cor_test^2
# look at the RMSE on the test data
sqrt(mean((predict(model, trips_per_day_test) - trips_per_day_test$num_trips)^2))

# plot the predicted vs. actual values
plot_data <- trips_per_day
plot_data$predicted <- predict(model, trips_per_day)
ggplot(plot_data, aes(color=log10(prcp+0.01))) +
  geom_point(aes(x = ymd, y=num_trips, shape=snow > 0)) +
  geom_line(aes(x = ymd, y=predicted))

# plot trips over time
ggplot(plot_data, aes(x=predicted, y=num_trips, color=log10(prcp+0.01), shape=is_holiday, size=log10(snow+0.01))) +
  geom_point() +
  geom_abline(slope=1)


########################################
# repeat this, with cv.glmnet
########################################

# fit a linear model with lasso regularization
form <- as.formula(num_trips ~ log(prcp+0.01) + log(snow+0.01)*poly(tmax,5) + log(snow+0.01)*poly(tmin,5) + day_of_week + is_holiday)
y <- trips_per_day_train$num_trips
X <- model.matrix(form, data=trips_per_day_train)
cvfit <- cv.glmnet(X, y)

# plot the generalization curve
plot(cvfit)

# predict on all the data 
plot_data <- trips_per_day
X_plot <- model.matrix(form, data=trips_per_day)
plot_data$predicted <- as.numeric(predict(cvfit, newx=X_plot, s="lambda.min"))

# measure performance on the test data
cor(plot_data$predicted[-ndx], plot_data$num_trips[-ndx])
sqrt(mean((plot_data$predicted[-ndx] - plot_data$num_trips[-ndx])^2))
#plot_data %>% select(predicted, num_trips)

# plot the predicted vs. actual values
ggplot(plot_data, aes(x=predicted, y=num_trips, color=log10(prcp+0.01), shape=is_holiday)) +
  geom_point() +
  geom_abline(slope=1)

# plot trips over time
ggplot(plot_data, aes(color=log10(prcp+0.01))) +
  geom_point(aes(x = ymd, y=num_trips, shape=snow > 0)) +
  geom_line(aes(x = ymd, y=predicted))

