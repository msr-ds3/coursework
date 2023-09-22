library(tidyverse)
library(lubridate)

pop.2 <- read.csv(file="pop2.csv")

## Compute the population average of the variable “bmi”.
mean(pop.2$bmi)

## Compute the population standard deviation of the variable “bmi”.
sd(pop.2$bmi)

## Compute the expectation of the sampling distribution for the sample average of the variable.
X.bar <- rep(0, 10^5)
for(i in 1:10^5)
{
  X.samp <- sample(pop.2$bmi, 150)
  X.bar[i] <- mean(X.samp)
}
mean(X.bar)

## Compute the standard deviation of the sampling distribution for the sample average of the variable.
sd(X.bar)

## Identify, using simulations, the central region that contains 80% of the sampling distribution of the sample average.
quantile(X.bar, c(0.1,0.9))

## Identify, using the Central Limit Theorem, an approximation of the central region that contains 80% of the sampling distribution of the sample average
qnorm(c(0.1,0.9),mean(X.bar),sd(X.bar))
