library(tidyverse)
library(scales)
library(modelr)
library(lubridate)

theme_set(theme_bw())
options(repr.plot.width=4, repr.plot.height=3)



trips_per_day <- read_tsv('trips_per_day.tsv')
head(trips_per_day)


set.seed(42)

trips_per_day$isweekend <- wday(trips_per_day$ymd) %in% c(1,7)

# Assume trips_per_day is your data frame and it has already been loaded
num_days <- nrow(trips_per_day)
frac_train <- 0.7
frac_validation <- 0.2
frac_test <- 0.1

train_size <- floor(num_days * frac_train)
validation_size <- floor(num_days * frac_validation)
test_size <- num_days - train_size - validation_size


train_indices <- sample(1:num_days, train_size, replace = FALSE)

remaining_indices <- setdiff(1:num_days, train_indices)

validation_indices <- sample(remaining_indices, validation_size, replace = FALSE)

test_indices <- setdiff(remaining_indices, validation_indices)

trips_per_day_train <- trips_per_day[train_indices, ]
trips_per_day_validation <- trips_per_day[validation_indices, ]
trips_per_day_test <- trips_per_day[test_indices, ]

cat("Training set size:", nrow(trips_per_day_train), "\n")
cat("Validation set size:", nrow(trips_per_day_validation), "\n")
cat("Test set size:", nrow(trips_per_day_test), "\n")







model <- lm(num_trips ~ poly(tmin, 5, raw = T), data = trips_per_day_train)

trips_per_day_train <- trips_per_day_train %>%
  add_predictions(model) %>%
  mutate(split = "train")
trips_per_day_validation <- trips_per_day_validation %>%
  add_predictions(model) %>%
  mutate(split = "validate")
plot_data <- bind_rows(trips_per_day_train, trips_per_day_validation)

ggplot(plot_data, aes(x = tmin, y = num_trips)) +
  geom_point(aes(color = split)) +
  geom_line(aes(y = pred)) +
  xlab('Minimum temperature') +
  ylab('Daily trips') +
  scale_y_continuous()






set.seed(42)
num_folds <- 5

trips_per_day_train <- trips_per_day_train %>%
  mutate(fold = (row_number() %% num_folds) + 1)

# fit a model for each polynomial degree
K <- 1:20
avg_validate_err <- c()
se_validate_err <- c()
for (k in K) {
  # do 5-fold cross-validation within each value of k
  validate_err <- c()
  for (f in 1:num_folds) {
    # fit on the training data
    trips_per_day_train_new <- filter(trips_per_day_train, fold != f)
    model <- lm(num_trips ~ poly(tmin, k, raw = TRUE) + poly(tmax, k, raw = TRUE) + prcp + snwd + snow +poly(isweekend, k, raw = TRUE), data = trips_per_day_train)
    # evaluate on the validation data
    trips_per_day_validate_new <- filter(trips_per_day_train, fold == f)
    validate_err[f] <- sqrt(mean((predict(model, trips_per_day_validate_new) - trips_per_day_validate_new$num_trips)^2))
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

#Lets see what happens if we use 12th degree polynomial to plot the graph
model <- lm(num_trips ~ poly(tmin, 12, raw = TRUE) + poly(tmax, 12, raw = TRUE) + prcp + snwd + snow +poly(isweekend, 12, raw = TRUE), data = trips_per_day_train)

trips_per_day_train <- trips_per_day_train %>%
  add_predictions(model) %>%
  mutate(split = "train")

trips_per_day_validation <- trips_per_day_validation %>%
  add_predictions(model) %>%
  mutate(split = "validate")

trips_per_day_test_pred <- trips_per_day_test %>%
  add_predictions(model) %>%
  mutate(split = "test")

plot_data <- bind_rows(trips_per_day_train, trips_per_day_validation, trips_per_day_test_pred)

ggplot(plot_data, aes(x = tmin, y = num_trips)) +
  geom_point(aes(color = split)) +
  geom_line(aes(y = pred)) +
  xlab('Minimum temperature') +
  ylab('Daily trips') +
  scale_y_continuous()


# Predict on the test data using the previously trained model
trips_per_day_test_pred <- trips_per_day_test %>%
  add_predictions(model) %>%
  mutate(split = "test")

# Plot the predicted vs. actual values
ggplot(trips_per_day_test_pred, aes(x = pred, y = num_trips)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  xlab('Predicted') +
  ylab('Actual') +
  ggtitle('Predicted vs Actual on Test Data')

# Calculate RMSE for the test dataset
pred_actual <- trips_per_day_test %>%
  add_predictions(model) %>%
  mutate(actual = num_trips)

rmse <- pred_actual %>%
  summarize(rmse = sqrt(mean((pred - actual)^2)))

print(rmse)


