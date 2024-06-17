library(tidyverse)
library(modelr)

install.packages("ISLR2")
library(ISLR2)

setwd("C:/Users/buka/Documents/coursework/week2")

# 4.1 IST

# p = 1/21
# P(Y < 3) = 2/7
# P(Y is odd) = 4/7
# P(1 <= Y < 4) = 3/7
# P(|Y - 3| < 1.5) = 4/7
# variance = 2.22
# sd = sqrt( 2.22 )


# 6.1 IST

# 1
1 - pnorm(650, 560, 57)

# 2
1 - pnorm(650, 630, 61)

# 3
qnorm(0.1, 560, 57)
qnorm(0.9, 560, 57)

# 4
qnorm(0.1, 630, 61)
qnorm(0.9, 630, 61)



# 7.1 IST
blood <- read.csv("pop2.csv")

# 1, 2
blood %>%
  summarize( pop_mean = mean(bmi), pop_sd = sd(bmi) ) %>% View

# 3
blood_s <- rep(0, 10e3)
for( i in 1:10e3)
{
  blood_s[i] <- sample(blood$bmi, 150) %>% mean
}
mean(blood_s)

# sample size: 150
# number of samples: 1000


# 4
sd(blood_s)

# 5



# 9.1 IST
magnets <- read_csv("magnets.csv")
magnets %>% summary()

# 1
mean(magnets$change)

# 2
# active is a factor

# 3
magnets %>%
  group_by(active) %>%
  summarize( avg = mean(active, na.rm = TRUE) ) %>% View

mean( magnets$change[1:29] )
mean( magnets$change[30:50] )

# 4
sd( magnets$change[1:29] )
sd( magnets$change[30:50] )

# 5
magnets %>%
  ggplot( aes(x = active, y = change) ) +
  geom_boxplot()




# 10.1 IST

# 1 
data <- rnorm(10e3, 3, 2) # -- against Normal(3, 2)

N <- 10e3
means = rep( 0, N )
meds <- rep( 0, N )
for(i in 1:N){
  means[i] <- sample(data, 100) %>% mean( na.rm = TRUE )
  meds[i] <- sample(data, 100) %>% median( na.rm = TRUE )
}
mse_means = mean( (means - 3)^2 )
mse_meds = mean( (meds - 3)^2 )
# the mean sqaured error for mean is less than for median, so the mean is the better estimator

# 10.2
population <- read_csv("pop2.csv")
sampled <- read_csv("ex2.csv")

# 1
x_bar <- mean(sampled$group == "HIGH")

# 2
mu <- mean(population$group == "HIGH")

# 3 -- simulating sample distribution OF the sample mean and find expectation,variance of it
N <- 10e3
p1000 <- rep( 0, N ) # -- will be distribution of sample proportion
for(i in 1:N){
  s_ = sample(population$group, 150)
  p1000[i] <- mean(s_ == "HIGH")
}
mean(p1000)

var(p1000) # -- 4 (variance of sample proportion, from simulating with many samples) OR

p_ <- mean(population$group == "HIGH") # -- 5 (variance of sample proportion, from population)
p_*(1 - p_) / 150



# 2.2 ISRS

# 30/34 patients in control group died, 45/69 patients in treatment died
# the null hyp. is that the treatment has no effect on whether the patient died or not,
#   the alt hyp. would say that the treatment is effective and effects death rate
#   28; 75; 69; 34; 0; greater than 45/69 - 30/34 (the observed difference)
# the simulation suggests that the treatment does not work and has no effects, since the
#   distribution of differences is centered at 0

# 2.6 ISRS

# the hypotheses are that others yawing does not influence a person yawning (null) and that
#   others yawning makes someone yawn also (alt)
# the observed difference is 24/34 - 12/16 (-0.044)
# the p-value is very small almost negligable, since p-value is definitely <5%, I would reject
#   the null and say others yawing has some effect an individual yawning



data_magnet <- rnorm(29, 3.5, 3)
data_placebo <- rnorm(21, 3.5, 1.5)
data <- c(data_magnet, data_placebo)


blood <- read_csv("pop2.csv")
# are males more susceptible to high blood pressure than females ?

# test statistic: proportion of high pressure in males - proportion of high pressure in females

# estimation
blood_by_sex <- blood %>%
  group_by( sex ) %>%
  summarise(n())

N <- 10e1 # number of samples
sample_size <- 200 # sample size
diffs <- rep(0, N)
for(trial in 1:N){
  s_ <- sample_n(blood, sample_size)
  male <- s_ %>% filter(sex == "MALE")
  female <- s_ %>% filter(sex == "FEMALE")
  
  diffs[trial] <- mean( male$group == "HIGH" ) - mean( female$group == "HIGH" )
}
estimate <- mean(diffs)
se <- sd(diffs) / sqrt(N)

# hypothesis test

# -- null: being male does not effect probability of high pressure
# -- alpha: 2%

s_ <- sample_n(blood, sample_size)
male <- s_ %>% filter(sex == "MALE")
female <- s_ %>% filter(sex == "FEMALE")

diff_ <- mean( male$group == "HIGH" ) - mean( female$group == "HIGH" )

# -- create a null distribution














 
















body <- read_table("body.txt", col_names = FALSE) %>% # -- X1:X9 is diameters, X10:21 is girths
  rename(gender = X25, height = X24, weight = X23, age = X22)

body %>%
  ggplot( aes(x = body$height, y = body$weight) ) +
  geom_point()

model <- lm( weight ~ height , data = body )
model %>%
  summary

# 3.6
boston <- Boston

boston %>%
  ggplot( aes(x=lstat, y=medv) ) +
  geom_point() 

model <- 
  lm( medv ~ poly(lstat, 5), data = boston)
model %>%
  summary