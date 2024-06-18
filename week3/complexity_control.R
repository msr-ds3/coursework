# Modify code to include test sample for the K-Fold Cross Validation Example
library(tidyverse)
library(scales)
library(modelr)
trips_per_day <- read_tsv('trips_per_day.tsv')

set.seed(42)
num_days <- nrow(trips_per_day)
frac_train <- 0.9
num_train <- floor(num_days * frac_train)

# randomly sample rows for the training + evaluation set
ndx <- sample(1:num_days, num_train, replace=F)

# used to fit the model
trips_per_day_train_eval <- trips_per_day[ndx, ]

# used to test the fit
trips_per_day_test <- trips_per_day[-ndx, ]


# Code for K-Fold Cross Validation
# Use trips_per_day_train as main dataframe
set.seed(42)
num_folds <- 5
num_days <- nrow(trips_per_day_train_eval)
num_train <- floor(num_days * frac_train)

ndx <- sample(1:num_days, num_train, replace=F)

trips_per_day <- trips_per_day_train_eval[ndx, ] %>%
  mutate(fold = (row_number() %% num_folds) + 1)

# fit a model for each polynomial degree
K <- 1:8
avg_validate_err <- c()
se_validate_err <- c()
for (k in K) {
  
  # do 5-fold cross-validation within each value of k
  validate_err <- c()
  for (f in 1:num_folds) {
    # fit on the training data
    trips_per_day_train <- filter(trips_per_day, fold != f)
    model <- lm(num_trips ~ poly(tmin, k, raw = T), data=trips_per_day_train)
    
    # evaluate on the validation data
    trips_per_day_validate <- filter(trips_per_day, fold == f)
    validate_err[f] <- sqrt(mean((predict(model, trips_per_day_validate) - trips_per_day_validate$num_trips)^2))
  }
  
  # compute the average validation error across folds
  # and the standard error on this estimate
  avg_validate_err[k] <- mean(validate_err)
  se_validate_err[k] <- sd(validate_err) / sqrt(num_folds)
}


# plot the validate error, highlighting the value of k with the lowest average error
plot_data <- data.frame(K, avg_validate_err, se_validate_err)
ggplot(plot_data, aes(x=K, y=avg_validate_err)) +
  geom_pointrange(aes(ymin=avg_validate_err - se_validate_err,
                      ymax=avg_validate_err + se_validate_err,
                      color=avg_validate_err == min(avg_validate_err))) +
  geom_line(color = "red") +
  scale_x_continuous(breaks=1:12) +
  theme(legend.position="none") +
  xlab('Polynomial Degree') +
  ylab('RMSE on validation data')

# Test Polynomial 4 (best one determined from code above) with the testing set
model <- lm(num_trips ~ poly(tmin, 4, raw = T), data=trips_per_day_train)

# Predict on the testing set
predictions <- predict(model, newdata = trips_per_day_test)

# Create a data frame for plotting
plot_data <- data.frame(Predicted = predictions, Actual = trips_per_day_test$num_trips)

# Scatter plot of predicted vs. actual
ggplot(plot_data, aes(x = Actual, y = Predicted)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +  # Adds a 45-degree line for reference
  xlab("Actual Number of Trips") +
  ylab("Predicted Number of Trips") +
  ggtitle("Actual vs. Predicted Number of Trips")
