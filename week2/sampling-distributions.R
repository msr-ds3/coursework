library(tidyverse)

####################################################################################
# IST Chapter 4, Exercise 4.1
#
# Table 4.4 presents the probabilities of the random variable Y:
#
#   Value | Probability
#   ------|------------
#     0   |    1p
#     1   |    2p
#     2   |    3p
#     3   |    4p
#     4   |    5p
#     5   |    6p
#
# These probabilities are a function of the number p, the probability of
# the value "0". Answer the following questions:
#
# 1. What is the value of p?The value of p is 1/21
# 2. P(Y < 3) = ? -> 6/21
# 3. P(Y = odd) = ? -> 12/21
# 4. P(1 <= Y < 4) = ? -> 9/21
# 5. P(|Y - 3| < 1.5) = ? -> 12/21
# 6. E(Y) = ? -> 3.33
#try to make a tribble 
num <- c(0,1,2,3,4,5)
denum <- c(1,2,3,4,5,6)/21
E<- sum(num*denum)
E

# 7. Var(Y) = ? -> 2.22
variance <- sum((num-E)^2* denum)
variance
# 8. What is the standard deviation of Y?-> 1.49
sd <- sqrt(variance)
sd
####################################################################################
# IST Chapter 4, Exercise 4.2
#
# One invests $2 to participate in a game of chance. In this game a coin
# is tossed three times. If all tosses end up "Head" then the player wins
# $10. Otherwise, the player loses the investment.
#
# 1. What is the probability of winning the game? -> 1/8 
# 2. What is the probability of losing the game?->7/8
# 3. What is the expected gain for the player that plays this game? -> -3/4 dollars
#    (Notice that the expectation can obtain a negative value.)



####################################################################################
# IST Chapter 6, Exercise 6.1
#
# Consider the problem of establishing regulations concerning the maximum
# number of people who can occupy a lift. In particular, we would like to
# assess the probability of exceeding maximal weight when 8 people are
# allowed to use the lift simultaneously and compare that to the probability
# of allowing 9 people into the lift.
#
# Assume that the total weight of 8 people chosen at random follows a
# Normal distribution with a mean of 560kg and a standard deviation of 57kg.
# Assume that the total weight of 9 people chosen at random follows a
# Normal distribution with a mean of 630kg and a standard deviation of 61kg.
#
# 1. What is the probability that the total weight of 8 people exceeds 650kg?
1 - pnorm(650,560,57)
#0.05717406
# 2. What is the probability that the total weight of 9 people exceeds 650kg?
1-pnorm(650,630,61)
#0.3715054
# 3. What is the central region that contains 80% of distribution of the
#    total weight of 8 people?
qnorm(0.9)
#1.281552
qnorm(0.9,560,57)
# 633.0484
qnorm(0.1)
#-1.281552
qnorm(0.1,560,57)
#486.9516
# 4. What is the central region that contains 80% of distribution of the
#    total weight of 9 people?
qnorm(0.9)
#1.281552
qnorm(0.9,630,61)
#708.1746
qnorm(0.1)
#-1.281552
qnorm(0.1,630,61)
#551.8254
# Hint: use pnorm() and qnorm().

####################################################################################
# IST Chapter 7, Exercise 7.1
#
# The file "pop2.csv" contains information associated to the blood pressure
# of an imaginary population of size 100,000:
# http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv
#
# Variables: id, sex, age, bmi, systolic, diastolic, group
#
# Our goal is to investigate the sampling distribution of the sample average
# of the variable "bmi". We assume a sample of size n = 150.
#
# 1. Compute the population average of the variable "bmi".
mean(pop2$bmi)
#24.98446
# 2. Compute the population standard deviation of the variable "bmi".
sd(pop2$bmi)
#4.188511
# 3. Compute the expectation of the sampling distribution for the sample
#    average of the variable.
samp <- sample(pop2$bmi,150)
X.bar <- rep(0,10^5)
for(i in 1:10^5)
{
    samp<- sample(pop2$bmi,150)
    X.bar[i]<-mean(samp)
}
hist(X.bar)
mean(X.bar)

# 4. Compute the standard deviation of the sampling distribution for the
#    sample average of the variable.
sd(X.bar)

# 5. Identify, using simulations, the central region that contains 80% of
#    the sampling distribution of the sample average.

quantile(X.bar, c(0.9,0.1))    

# 6. Identify, using the Central Limit Theorem, an approximation of the
#    central region that contains 80% of the sampling distribution of the
#    sample average.
qnorm(c(0.9,0.1),mean(X.bar),sd(X.bar))

pop2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv")
samp <- sample(pop2$bmi,100)
samp
mean(pop2$bmi)

# Hint: for (5), use replicate() to draw many samples of size 150,
# compute the mean of bmi for each, then use quantile().
# For (6), use qnorm() with the expectation and sd from (3) and (4).
