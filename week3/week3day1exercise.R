library(MASS)
library(ISLR2)
library(dplyr)
library(boot)


## ---- lab 5.3.1 --------------------
set.seed(1)
train <-sample(392, 196)

lm.fit <- lm(mpg ~ horsepower, data = Auto, subset = train)
attach(Auto)

mean((mpg - predict(lm.fit, Auto))[-train]^2)
# res : 23.26601

lm.fit2 <- lm(mpg ~ poly(horsepower, 2), data = Auto, subset = train)

mean((mpg- predict(lm.fit2, Auto))[-train]^2)
# res: 18.71646

lm.fit3 <- lm(mpg ~ poly(horsepower, 3), data = Auto, subset = train)

mean((mpg- predict(lm.fit3, Auto))[-train]^2)
# res: 18.79401


set.seed(2)
train <-sample(392, 196)

lm.fit <- lm(mpg ~ horsepower, data = Auto, subset = train)
attach(Auto)

mean((mpg - predict(lm.fit, Auto))[-train]^2)
# res: 25.72651

lm.fit2 <- lm(mpg ~ poly(horsepower, 2), data = Auto, subset = train)


mean((mpg- predict(lm.fit2, Auto))[-train]^2)
# res: 20.43036

lm.fit3 <- lm(mpg ~ poly(horsepower, 3), data = Auto, subset = train)

mean((mpg- predict(lm.fit3, Auto))[-train]^2)
# res: 20.38533



## ---- lab 5.3.2 --------------------

# using generalized linear model
glm.fit <- glm(mpg ~ horsepower, data = Auto)
coef(glm.fit)
 # res: (Intercept)  horsepower 
#       39.9358610  -0.1578447

# using linear model
lm.fit <- glm(mpg ~ horsepower, data = Auto)
coef(glm.fit)
# res: (Intercept)  horsepower 
#       39.9358610  -0.1578447

glm.fit <- glm(mpg ~ horsepower, data = Auto)
cv.err <-cv.glm(Auto, glm.fit)
cv.err$delta

#res: [1] 24.23151 24.23114

cv.error <-rep(0, 10)
for (i in 1:10) {
  glm.fit <-glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error[i] <-cv.glm(Auto, glm.fit)$delta[1]
  }
cv.error

# res: [1] 24.23151 19.24821 19.33498 19.42443 19.03321 18.97864 18.83305 18.96115 19.06863 19.49093


## ---- lab 5.3.2 --------------------
set.seed(17)
cv.error.10 <-rep(0, 10)
for (i in 1:10) {
  glm.fit <-glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error.10[i] <-cv.glm(Auto, glm.fit,  K = 10)$delta[1]
}
cv.error.10

# res:  [1] 24.27207 19.26909 19.34805 19.29496 19.03198 18.89781 19.12061 19.14666 18.87013 20.95520

# #### ---------------------- adding training split on spliting dataset -------------


library(tidyverse)
library(scales)
library(modelr)

theme_set(theme_bw())
options(repr.plot.width=4, repr.plot.height=3)

trips_per_day <- read_tsv('trips_per_day.tsv')
head(trips_per_day)

# spliting
set.seed(42)

num_days <- nrow(trips_per_day)
frac_test <- 0.2

num_test <- floor(num_days * frac_test)

# randomly sample rows for the training set 
ndx_test <- sample(1:num_days, num_test, replace=F)

# used to test the model
trips_per_day_test <- trips_per_day[ndx_test, ]

# used to the fit
trips_per_day_train_val  <- trips_per_day[-ndx_test, ]

# ^^^ correct
# set.seed(42)
num_folds <- 5
# num_days_2 <- nrow(trips_per_day_train_val)
# frac_train <- 0.8
# num_train <- floor(num_days_2 * frac_train)
# 
# # randomly sample rows for the training set 
# ndx <- sample(1:num_days_2, num_train, replace=F)

trips_per_day_train_val <- trips_per_day_train_val %>%
  mutate(fold = (row_number() %% num_folds) + 1)


# fit a model for each polynomial degree
# set.seed(42)
K <- 1:8
avg_validate_err <- c()
se_validate_err <- c()
for (k in K) {
  
  # do 5-fold cross-validation within each value of k
  validate_err <- c()
  for (f in 1:num_folds) {
    # fit on the training data
    trips_per_day_train <- filter(trips_per_day_train_val, fold != f)
    model <- lm(num_trips ~ poly(tmin, k, raw = T), data=trips_per_day_train)
    
    # evaluate on the validation data
    trips_per_day_validate <- filter(trips_per_day_train_val, fold == f)
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


## ------------------------------------------------

# yawning problem




