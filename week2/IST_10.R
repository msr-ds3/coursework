library(tidyverse)
library(lubridate)


## 10.1.1
mu <- 3
sig <- sqrt(2)
X.bar <- rep(0,10^5)
X.med <- rep(0,10^5)
for(i in 1:10^5)
{
  X <- rnorm(100,mu,sig)
  X.bar[i] <- mean(X)
  X.med[i] <- median(X)
}
mean(X.bar)
median(X.med)

var(X.bar)
var(X.med)

## 10.1.2
a <- 0.5
b <- 5.5
X.bar <- rep(0,10^5)
X.med <- rep(0,10^5)
for(i in 1:10^5)
{
  X <- runif(100,a,b)
  X.bar[i] <- mean(X)
  X.med[i] <- median(X)
}
mean(X.bar)
median(X.med)

var(X.bar)
var(X.med)


pop2 <- read.csv("pop2.csv")
ex2 <- read.csv("ex2.csv")
summary(ex2)

## Compute the proportion in the sample of those with a high level of blood pressure
mean(ex2$group == "HIGH")

## Compute the proportion in the population of those with a high level of blood pressure
mean(pop2$group == "HIGH")

## Simulate the sampling distribution of the sample proportion and compute its expectation.
P.hat <- rep(0,10^5)
for(i in 1:10^5)
{
  X <- sample(pop2$group,150)
  P.hat[i] <- mean(X == "HIGH")
}
mean(P.hat)

## Compute the variance of the sample proportion.
var(P.hat)

## It is proposed in Section 10.5 that the variance of the sample proportion is Var(Pˆ) = p(1 − p)/n, 
## where p is the probability of the event (having a high blood pressure in our case) and n is the 
## sample size (n = 150 in our case). Examine this proposal in the current setting.
p <- mean(pop2$group == "HIGH")
p*(1-p)/150




