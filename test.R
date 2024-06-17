library(tidyverse)
library(scales)
library(modelr)

trips_per_day <- read_tsv('C:/Users/fabio/Documents/coursework/week3/trips_per_day.tsv')
head(trips_per_day)

set.seed(42)

num_days <- nrow(trips_per_day)

#training data = 80%
frac_train <- 0.8
num_train <- floor(num_days * frac_train)
num_other <- num_days - num_train

ndx <- sample(1:num_days, num_days, replace=F)

#training set indexes
trips_train <- ndx[1:num_train]
trips_per_day_train <- trips_per_day[trips_train, ]

#rest of indexes
trips_other <- ndx[-trips_train]

num_validate <- floor(num_days *.1)
num_test <- ceiling(num_days *.1)

trips_validate <- trips_other[1:num_validate]
trips_test <- trips_other[num_test:(num_test+num_validate)]


trips_per_day_validate <- trips_per_day[trips_validate, ]
trips_per_day_test <- trips_per_day[trips_test, ]

