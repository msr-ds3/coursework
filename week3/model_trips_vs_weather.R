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

# randomly select 80% of the data to train the model on
set.seed(42)
num_days <- nrow(trips_per_day)
ndx <- sample(1:num_days, round(0.8 * num_days))

# use this data frame to fit your model
trips_per_day_train <- trips_per_day[ndx, ]

# pretend this doesn't exist (for now!)
trips_per_day_test <- trips_per_day[-ndx, ]

# fit for each polynomial degree
K <- 1:12
train_fit <- c()
test_fit <- c()
for (k in K) {
  # fit on the training data
  model <- lm(num_trips ~ poly(tmin, k), data=trips_per_day_train)

  # evaluate on the training data
  cor_train <- cor(predict(model, trips_per_day_train), trips_per_day_train$num_trips)
  train_fit[k] <- cor_train^2
  
  # evaluate on the test data
  cor_test <- cor(predict(model, trips_per_day_test), trips_per_day_test$num_trips)
  test_fit[k] <- cor_test^2
}

# plot the training and test curves
plot_data <- data.frame(k=K, train=train_fit, test=test_fit) %>%
  gather("variable","value", 2:3)
ggplot(plot_data, aes(x=k, y=value, linetype=variable)) +
  geom_line()

# create a generic function to plot the fitted model against the training and test data
plot_model <- function(k) {
  model <- lm(num_trips ~ poly(tmin, k), data=trips_per_day_train)
  df_train <- trips_per_day_train
  df_train$predicted <- predict(model, trips_per_day_train)
  df_train$label <- 'train'
  df_test <- trips_per_day_test
  df_test$predicted <- predict(model, trips_per_day_test)
  df_test$label <- 'test'
  plot_data <- rbind(df_train, df_test)
  ggplot(data=plot_data, aes(x=tmin)) + 
    geom_line(aes(y=predicted)) + 
    geom_point(aes(y=num_trips)) + 
    facet_wrap(~ label, nrow=1)
}

# plot the model with the best fit to the test data
k_star <- which.max(test_fit)
plot_model(k_star)

