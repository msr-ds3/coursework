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
# 1. What is the value of p? p = 1/21
# p(1 + 2 + 3 + 4 + 5 + 6) = 21p
# 21p = 1
# p = 1/21

# 2. P(Y < 3) = 6/21
# 1p + 2p + 3p = 1/21 + 2/21 + 3/21 = 6/21

# 3. P(Y = odd) = 12/21
# 2p + 4p + 6p = 2/21 + 4/21 + 6/21 = 12/21

# 4. P(1 <= Y < 4) = 9/21
# 2p + 3p + 4p  = 2/21 + 3/21 + 4/21 = 9/21

# 5. P(|Y - 3| < 1.5) = ?

# 6. E(Y) = 3.333333
y <- seq(0, 5)
prob <- seq(1, 6)/21
(ey <- sum(y*prob))

# 7. Var(Y) = 2.222222
(vy <- sum((y - ey)^2*prob))

# 8. What is the standard deviation of Y? = 1.490712
(sd <- sqrt(vy))


####################################################################################
# IST Chapter 4, Exercise 4.2
#
# One invests $2 to participate in a game of chance. In this game a coin
# is tossed three times. If all tosses end up "Head" then the player wins
# $10. Otherwise, the player loses the investment.
#
# 1. What is the probability of winning the game? = 1/8
# Sample Space: {HHH, HHT, HTH, HTT, THH, THT, TTH, TTT}

# 2. What is the probability of losing the game? = 7/8
# 1 - Prob(Winning) = 1 - 1/8 = 7/8

# 3. What is the expected gain for the player that plays this game?
#    (Notice that the expectation can obtain a negative value.) = -0.75

# E(x) = sum(x * p)
# P(HHH) * 8 + P(HHT) * -2 + P(HTH) * -2 + P(HTT) * -2 +
# P(THH) + -2 + P(THT) * -2 + P(TTH) * -2 + P(TTT) * -2
1/8 * 8 + (7/8) * -2




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
# P(weight > 650kg) = 0.05717406; mu = 560kg, sigma = 57kg
mu8 <- 560
sigma8 <- 57
1 - pnorm(650, mu8, sigma8)
# 2. What is the probability that the total weight of 9 people exceeds 650kg?
# P(weight > 650) = 0.3715054
mu9 <- 630
sigma9 <- 61
1 - pnorm(650, mu9, sigma9)
# 3. What is the central region that contains 80% of distribution of the
#    total weight of 8 people?
c(qnorm(0.1, mu8, sigma8), qnorm(0.9, mu8, sigma8))

# 4. What is the central region that contains 80% of distribution of the
#    total weight of 9 people?
qnorm(c(0.1, 0.9), mu9, sigma9)

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
mean(pop2$bmi)
# Output: 24.98446

# 2. Compute the population standard deviation of the variable "bmi".
sd(pop2$bmi)
# Output: 4.188511

# 3. Compute the expectation of the sampling distribution for the sample
#    average of the variable.

# initialize a zero vector 
sample_means <- rep(0, 10^5)

# Perform the simulation 100,000 times
for(i in 1:10^5)
{sample <- sample(pop2$bmi, 150) # n = 150
sample_means[i] <- mean(sample)} # store means from sample distribution in sample means

mu <- mean(sample_means)
mu

# 4. Compute the standard deviation of the sampling distribution for the
#    sample average of the variable.
sd <- sd(sample_means)
sd

# Output: 0.4120314

# 5. Identify, using simulations, the central region that contains 80% of
#    the sampling distribution of the sample average.
quantile(x = sample_means, probs = c(0.1, 0.9))

# 6. Identify, using the Central Limit Theorem, an approximation of the
#    central region that contains 80% of the sampling distribution of the
#    sample average.
qnorm(c(0.1, 0.9), mean, sd)

# Hint: for (5), use replicate() to draw many samples of size 150,
# compute the mean of bmi for each, then use quantile().
# For (6), use qnorm() with the expectation and sd from (3) and (4).
