library(ISLR2)
library(boot)

setwd("C:/Users/buka/Documents/coursework/week3")

set.seed(1)

auto <- Auto

train_val_percent <- 0.9
test_percent <- 0.1
n <- nrow( auto )

# train_set <- sample( n, floor(n*train_val_percent) )


train_set <- sample(362, 196)

model <- lm( mpg ~ horsepower, data = auto, subset = train_set )

attach(auto)
mean((mpg - predict(model, auto))[-train_set]^2)



# k-fold cross validation
set.seed(17)
K <- 10

errors <- rep( 0, K )
for( k in 1:K ){
  m <- glm(mpg ~ poly(horsepower, k))
  errors[k] <- cv.glm(auto, m, K = K)$delta[1]
}
errors






library(tidyverse)
library(scales)
library(modelr)

theme_set(theme_bw())
options(repr.plot.width=4, repr.plot.height=3)

set.seed(42)

trips_per_day <- read_tsv('trips_per_day.tsv')

n <- nrow(trips_per_day)
train_percent <- 0.8
num_train <- floor(n * train_percent)

# split for test
trips_sample <- sample(1:n, num_train, replace = FALSE)
trips_train <- trips_per_day[trips_sample,]
trips_test <- trips_per_day[-trips_sample,]

# k fold
K <- 5

trips_fold <- trips_train %>%
  mutate( fold = row_number()%%K + 1 )

degree <- 1:8 # degree polynomial
avg_errs = rep(0, 8)
avg_ses = rep(0, 8)
for ( d in degree ){
  
  k_val_err = rep( 0, K )
  for( k in 1:K ){
    
    train_set <- trips_fold %>% filter( fold != k )
    val_set <- trips_fold %>% filter( fold == k )
    
    model <- lm( num_trips ~ poly(tmin, d, raw = TRUE), data = train_set )
    k_val_err[k] <- sqrt( mean( (predict(model, val_set) - val_set$num_trips) ^ 2 ) )
  }
  
  avg_errs[d] <- mean(k_val_err)
  avg_ses[d] <- sd(k_val_err) / sqrt(K)
  
}


# Jake's code to plot

plot_data <- data.frame(degree, avg_errs, avg_ses)

ggplot(plot_data, aes(x=degree, y=avg_errs)) +
  geom_pointrange(aes(ymin=avg_errs - avg_ses,
                      ymax=avg_errs + avg_ses,
                      color=avg_errs == min(avg_errs))) +
  geom_line(color = "red") +
  scale_x_continuous(breaks=1:12) +
  theme(legend.position="none") +
  xlab('Polynomial Degree') +
  ylab('RMSE on validation data')

# degree 4 seems to work best here, so use on test
model <- lm( num_trips ~ poly(tmin, 4, raw = TRUE), data = trips_train )
y_hat <- predict( model, trips_test )

err <- sqrt( mean( (y_hat - trips_test$num_trips) ^ 2 ) )
se <- sd(trips_test$num_trips) / sqrt(nrow(trips_test))
