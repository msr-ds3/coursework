library(dplyr)
library(ggplot2)
library(tidyr)

theme_set(theme_bw())

load('trips.RData')

# count the number of trips per day
trips_per_day <- trips %>%
  group_by(ymd) %>%
  summarize(num_trips=n())

# join trip info and weather for each day
trips_per_day <- inner_join(trips_per_day, weather, by="ymd")

# divide the data into five different folds for cross-validation
set.seed(42)
num_folds <- 5
num_days <- nrow(trips_per_day)
trips_per_day$fold <- sample(1:num_folds, num_days, replace=T)

# fit a model for each polynomial degree
K <- 1:12
avg_test_err <- c()
se_test_err <- c()
for (k in K) {

  # do 5-fold cross-validation within each value of k
  test_err <- c()
  for (f in 1:num_folds) {
    # use this data frame to fit your model
    trips_per_day_train <- filter(trips_per_day, fold != f)
    
    # pretend this doesn't exist (for now!)
    trips_per_day_test <- filter(trips_per_day, fold == f)
    
    # fit on the training data
    model <- lm(num_trips ~ poly(tmin, k), data=trips_per_day_train)
    
    # evaluate on the test data
    test_err[f] <- sqrt(mean((predict(model, trips_per_day_test) - trips_per_day_test$num_trips)^2))
  }

  # compute the average test error across folds
  # and the standard error on this estimate
  avg_test_err[k] <- mean(test_err)
  se_test_err[k] <- sd(test_err) / sqrt(num_folds)
}

# plot the test error, highlighting the value of k with the lowest average error
plot_data <- data.frame(K, avg_test_err, se_test_err)
ggplot(plot_data, aes(x=K, y=avg_test_err, color=avg_test_err == min(avg_test_err))) +
  geom_pointrange(aes(ymin=avg_test_err - se_test_err, ymax=avg_test_err + se_test_err)) +
  geom_line() +
  scale_x_continuous(breaks=1:12) +
  theme(legend.position="none") +
  xlab('Polynomial Degree') +
  ylab('RMSE on test data')

