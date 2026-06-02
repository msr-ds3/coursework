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
# 1. What is the value of p?
# The total probability of each value should be 1. Therefore
# P(0) + P(1) + P(2) + P(3) + P(4) + + P(5) = p + 2p + 3p + 4p + 5p + 6p = 21p = 1
# p = 1/21

values <- c(0:5)
probs <- c(1/21, 2/21, 3/21, 4/21, 5/21, 6/21)

# 2. P(Y < 3) = ?
# This would be the probability of getting 0, 1, or 2.
# P(0) + P(1) + P(2) = p + 2p + 3p = 6p
# Since p = 1/21, this means P(Y < 3) = 6/21
sum(probs[values < 3])

# 3. P(Y = odd) = ?
# This would be the probability of getting 1, 3, or 5.
# P(1) + P(3) + P(5) = 2p + 4p + 6p = 12p
# Since p = 1/21, this means P(Y = odd) = 12/21
sum(probs[values %% 2 == 1])

# 4. P(1 <= Y < 4) = ?
# This would be the probability of getting 1, 2, or 3. 
# P(1) + P(2) + P(3) = 2p + 3p + 4p = 9p
# Since p = 1/21, this means P(1 <= Y < 4) = 9/21
sum(probs[values < 4 & values >= 1])

# 5. P(|Y - 3| < 1.5) = ?
# This would be the probability of getting 2, 3, or 4. 
# This is because |2-3| = 1, |3-3| = 0, |4-3| = 1, however all values outside that range result in a number above 1.5.
# P(2) + P(3) + P(4) = 3p + 4p + 5p = 12p 
# Since p = 1/21, this means P(|Y - 3| < 1.5) = 12/21
sum(probs[abs(values - 3) < 1.5])

# 6. E(Y) = ?
# E(Y) = 1/21 (1*0 + 2*1 + 3*2 + 4*3 + 5*4 + 6*5) 
# = 1/21 (2 + 6 + 12 + 20 + 30) = 1/21 (70) = 70/21= 3.33
mu <- sum(values * probs)
mu 

# 7. Var(Y) = ?
# Var(Y) = 1/21 [1*(0-3.33)^2 + 2*(1-3.33) + 3*(2-3.33)^2 + 4*(3-3.33)^2 + 5*(4-3.33)^2 + 6*(5-3.33)^2]
# = 2.222233333
var <- sum(probs * (values - mu)^2)
var

# 8. What is the standard deviation of Y?
# This would be the square root of the variance.
# 1.490715712
sd <- sqrt(var)
sd


####################################################################################
# IST Chapter 4, Exercise 4.2
#
# One invests $2 to participate in a game of chance. In this game a coin
# is tossed three times. If all tosses end up "Head" then the player wins
# $10. Otherwise, the player loses the investment.
#

values <- c(0,1)
probs <- c(1/2, 1/2)

# 1. What is the probability of winning the game?
# 1/2 * 1/2 * 1/2 = 1/8
(probs[values == 1])^3

# another way to do it
dbinom(3, 3, 1/2)

# 2. What is the probability of losing the game?
# 1 - 1/8 = 7/8
1 - (probs[values == 1])^3

# another way to do it
1 - dbinom(3, 3, 1/2)

# 3. What is the expected gain for the player that plays this game?
#    (Notice that the expectation can obtain a negative value.)
# A player can gain $8 and lose $2. This can be represented by 8 and -2.
# 8 * 1/8 + -2 * 7/8 = 1 - 7/4 = -3/4
8 * (probs[values == 1])^3 + (-2) * (1 - (probs[values == 1])^3)

# another way
8 * (dbinom(3, 3, 1/2)) + (-2) * (1 - dbinom(3, 3, 1/2))



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
mu_8 <- 560
sd_8 <- 57
1 - pnorm(650, mu_8, sd_8)
# The probability is 0.05717406 or ~5%

# 2. What is the probability that the total weight of 9 people exceeds 650kg?
mu_9 <- 630
sd_9 <- 61
1 - pnorm(650, mu_9, sd_9)
# The probability is 0.3715054 or ~37%

# 3. What is the central region that contains 80% of distribution of the
#    total weight of 8 people?
# This would be everyone between 10% and 90%
tenth_percentile_8 <- qnorm(0.1, mu_8, sd_8)
ninetieth_percentile_8 <- qnorm(0.9, mu_8, sd_8)
# The interval can be expressed as 
c(tenth_percentile_8, ninetieth_percentile_8)
# This is the total weight interval [486.9516, 633.0484]

# 4. What is the central region that contains 80% of distribution of the
#    total weight of 9 people?
tenth_percentile_9 <- qnorm(0.1, mu_9, sd_9)
ninetieth_percentile_9 <- qnorm(0.9, mu_9, sd_9)
# The interval can be expressed as 
c(tenth_percentile_9, ninetieth_percentile_9)

# This is the total weight interval [551.8254, 708.1746]
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
pop2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv")
# 1. Compute the population average of the variable "bmi".
bmi_mu <- pop2 %>%
    select(bmi) %>%
    summarize(avg_bmi=mean(bmi)) %>%
    pull()
bmi_mu
# The average population bmi is 24.98446


# 2. Compute the population standard deviation of the variable "bmi".
bmi_sd <- pop2 %>%
    select(bmi) %>%
    summarize(sd_bmi=sd(bmi)) %>%
    pull()
bmi_sd
# The population standard deviation is 4.188511

# 3. Compute the expectation of the sampling distribution for the sample
#    average of the variable.
# The expectation should theoretically be the mean 24.98446.

# 4. Compute the standard deviation of the sampling distribution for the
#    sample average of the variable.
# The standard deviation should be the standard error.
# This is sd/sqrt(N)
bmi_se <- bmi_sd/sqrt(150)
bmi_se

# 5. Identify, using simulations, the central region that contains 80% of
#    the sampling distribution of the sample average.

n = 150

# replicate a pipe 1e5 times
mu_hat <- replicate(1e5, pop2 %>%
    select(bmi) %>%
    slice_sample(n=n) %>%
    summarize(mean(bmi)) %>%
    pull())

quantile(mu_hat, c(0.1, 0.9))
# This should print
#     10%      90% 
# 24.46307 25.57535

# 6. Identify, using the Central Limit Theorem, an approximation of the
#    central region that contains 80% of the sampling distribution of the
#    sample average.

tenth_percentile = qnorm(0.1, bmi_mu, bmi_se)
ninetieth_percentile = qnorm(0.9, bmi_mu, bmi_se)
# This can be expressed as
c(tenth_percentile, ninetieth_percentile)
# This is [24.54618, 25.42274]

# Hint: for (5), use replicate() to draw many samples of size 150,
# compute the mean of bmi for each, then use quantile().
# For (6), use qnorm() with the expectation and sd from (3) and (4).
