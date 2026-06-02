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
# 1p + 2p + 3p + 4p + 5p + 6p = 1
# 21p = 1
# p = 1/21

# 2. P(Y < 3) = ?
#     0   |    1p
#     1   |    2p
#     2   |    3p
# Probability that y will be less than 3 is 6p or 6/21

# 3. P(Y = odd) = ?
#     1   |    2p
#     3   |    4p
#     5   |    6p
# Probability that y is odd is 12p or 12/21

# 4. P(1 <= Y < 4) = ?
# {1,2,3}
#     1   |    2p
#     2   |    3p
#     3   |    4p
# Probability that y is less than or equal to 1 and less than 4 is 9p or 9/21

# 5. P(|Y - 3| < 1.5) = ?
#  P < +- 1.5 + 3
#  p < 4.5
#  p > 1.5
#  Events where this is true {2,3,4}
# 3p + 4p + 5p
# Probability that the absolute value of Y - 3 is less than 1.5 is 12p or 12/21


# 6. E(Y) = ?
# Expected value is calculated by getting the summation of all possible outcomes multiplied 
# by their probability
# E(Y) = 0(1p) + 1(2p) + 2(3p) + 3(4p) + 4(5p) + 5(6p)
# E(Y) = 2p + 6p + 12p + 20p + 30p = 70p = 70/21 = 3.333bar
# Apparently can do in R as well
y.val <- c(0,1,2,3,4,5) 
p.val <- c(1,2,3,4,5,6) / 21
E.val <- sum(y.val * p.val)
E.val
# OUTPUT is also 3.3333

# 7. Var(Y) = ?
# Don't want to do this by hand
Var.val <- sum((y.val - E.val)^2 * p.val)
Var.val
# OUTPUT is 2.2222

# 8. What is the standard deviation of Y?
Sd.val <- sqrt(Var.val)
Sd.val
# OUTPUT is 1.4907


####################################################################################
# IST Chapter 4, Exercise 4.2
#
# One invests $2 to participate in a game of chance. In this game a coin
# is tossed three times. If all tosses end up "Head" then the player wins
# $10. Otherwise, the player loses the investment.
#
# 1. What is the probability of winning the game?
# 2. What is the probability of losing the game?
# 3. What is the expected gain for the player that plays this game?
#    (Notice that the expectation can obtain a negative value.)

# Assuming the probability of getting heads is 50% or .5...
# 1. The probability of winning the game is .5^3 = chance of getting HHH
prob_of_winning <- .5^3
prob_of_winning
# OUTPUT is .125 or 12.5%

# 2. The probability of losing the game is 1 - prob_of_winning
prob_of_losing <- 1 - prob_of_winning
prob_of_losing
# OUTPUT is .875 or 87.5%

# 3. What is the expected gain for the player that plays this game
# All possible outcomes are 
# Outcomes                                               | Probability
# Gain 8 dollars {HHH} (1)                               | 0.125
# Lose 2 dollars {HTT, HHT, HTH, TTT, THH, TTH, THT} (7) | 0.875
y.val_coin <- c(8,-2)
p.val_coin <- c(1, 7) / 8
E.val_coin <- sum(y.val * p.val)
E.val_coin
# OUTPUT is -0.75

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
# 2. What is the probability that the total weight of 9 people exceeds 650kg?
# 3. What is the central region that contains 80% of distribution of the
#    total weight of 8 people?
# 4. What is the central region that contains 80% of distribution of the
#    total weight of 9 people?

# Hint: use pnorm() and qnorm().
# Question One
q1_prob_lt <- pnorm(650, 560, 57) # Getting probability that X is less than or equal to 650
q1_prob_mt <- 1 - q1_prob_lt
q1_prob_mt
# OUTPUT is 0.05717

# Question Two
q2_prob_lt <- pnorm(650, 630, 61) # Getting probability that X is les than or equal to 650
q2_prob_mt <- 1 - q2_prob_lt
q2_prob_mt
# OUTPUT is 0.3715

# Question Three
# If 80%, should be 10% from bottom of curve, 10% from top of curve
q3_lowerhf <- qnorm(.10, 560, 57)
q3_upperhf <- qnorm(.90, 560, 57)
q3_lowerhf
q3_upperhf
# ANSWER
# 80% of the distribution of the total weight of 8 people is in range
# [486.9516, 633.0484]

# Question Four
# If 80%, should be 10% from bottom of curve, 10% from top of curve
q4_lowerhf <- qnorm(.10, 630, 61)
q4_upperhf <- qnorm(.90, 630, 61)
q4_lowerhf
q4_upperhf
# ANSWER
# 80% of the distribution of the total weight of 9 people is in range
# [551.8254, 708.1746]


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
# 2. Compute the population standard deviation of the variable "bmi".
# 3. Compute the expectation of the sampling distribution for the sample
#    average of the variable.
# 4. Compute the standard deviation of the sampling distribution for the
#    sample average of the variable.
# 5. Identify, using simulations, the central region that contains 80% of
#    the sampling distribution of the sample average.
# 6. Identify, using the Central Limit Theorem, an approximation of the
#    central region that contains 80% of the sampling distribution of the
#    sample average.

pop2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv")

# Hint: for (5), use replicate() to draw many samples of size 150,
# compute the mean of bmi for each, then use quantile().
# For (6), use qnorm() with the expectation and sd from (3) and (4).

# Question One: Compute the population average of the variable "bmi"
pop2_avg_bmi <- mean(pop2$bmi)
pop2_avg_bmi
# OUTPUT: 24.9844

# Question Two: Compute the population standard deviation of the variable "bmi"
pop2_sd_bmi <- sd(pop2$bmi)
pop2_sd_bmi
# OUTPUT: 4.1885

# Question Three: Compute the expectation of the sampling distribution for the sample average
# of the variable

## Following textbook version
pop2_bar <- rep(0, 10^5)
for (i in 1:10^5) {
    pop2.sample <- sample(pop2$bmi, 150)
    pop2_bar[i] <- mean(pop2.sample)
}
pop2_bmi_expected <- mean(pop2_bar)
pop2_bmi_expected
# OUTPUT: 24.98472

# Question Four: Compute the standard deviation of the sampling distribution for the sample average
# of the variable
# sd of sampling distribution is standard error

pop2_bmi_sd <- sd(pop2_bar)
pop2_bmi_sd
# OUTPUT: 0.341606

# Question Five: Identify, using simulations, the central region that contains 80% of the sampling
# distribution of the sample average (hint replicate and quantile())

# With replicate
pop2_wrep_bar <- replicate(1e5, mean(sample(pop2$bmi, 150)))
pop2_wrep_expected <- mean(pop2_wrep_bar)
pop2_wrep_sd <- sd(pop2_wrep_bar)
pop2_wrep_expected
pop2_wrep_sd
# OUTPUT (expected value): 24.98476
# OUTPUT (se): 0.342095

pop2_cent_reg_wrep <- quantile(pop2_wrep_bar, c(.10, .90))
pop2_cent_reg_wrep
# OUTPUT: [24,54825, 25.42490]

# Following textbook version
pop2_cent_reg_sims <- quantile(pop2_bar, c(.10, .90))
pop2_cent_reg_sims
# OUTPUT: [24.44904, 25.51937]

# Question Six: Identify, using the CLT, an approximation of the central region that contains 
# 80% of the sampling distribution of the sample average (hint qnrom)
pop2_cent_reg_clt <- qnorm(c(0.10, 0.90), mean(pop2_bar), sd(pop2_bar))
pop2_cent_reg_clt
# OUTPUT: [24.54731, 25.42288]