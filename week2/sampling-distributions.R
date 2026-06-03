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
 # p=1/(1+2+3+4+5+6) = 1/21

# 2. P(Y < 3) = ?
 # P(Y < 3) = 1/21 + 2/21 + 3/21 = 6/21

# 3. P(Y = odd) = ?
 # P(Y = odd) = P(Y = 1) + P(Y = 3) + P(Y = 5)
 # P(Y = odd) = 2/21 + 4/21 + 6/21 = 12/21

# 4. P(1 <= Y < 4) = ?
 # P(1 <= Y < 4) =  P(Y = 1) + P(Y = 2) + P(Y = 3)
 # P(1 <= Y < 4) = 2/21 + 3/21 + 4/21 = 9/21

# 5. P(|Y - 3| < 1.5) = ?
 # P(|Y - 3| < 1.5) = P(Y = 2) + P(Y = 3) + P(Y = 4)
 # P(|Y - 3| < 1.5) = 3/21 + 4/21 + 5/21 = 12/21

# 6. E(Y) = ?
 # E(Y) = (0*1/21) + (1* 2/21) + (2* 3/21) + (3* 4/21)
 #         + (4* 5/21) + (5* 6/21)
 # E(Y) = 70/21

 # If we don't want to do it by hand, we can compute:
Y.val <- c(0,1,2,3,4,5)
P.val <- c(1,2,3,4,5,6)/21
E <- sum(Y.val*P.val)
E

# 7. Var(Y) = ?
Var <- sum((Y.val-E)^2*P.val)
Var
 # Var(Y) = 2.22222

# 8. What is the standard deviation of Y?
 # sqrt(Var(Y)) = 1.49



####################################################################################
# IST Chapter 4, Exercise 4.2
#
# One invests $2 to participate in a game of chance. In this game a coin
# is tossed three times. If all tosses end up "Head" then the player wins
# $10. Otherwise, the player loses the investment.
#
# 1. What is the probability of winning the game?
 # The probability of winning is 1/8

# 2. What is the probability of losing the game?
 # Probability of losing = 1 - 1/8 = 7/8

# 3. What is the expected gain for the player that plays this game?
#    (Notice that the expectation can obtain a negative value.)
 # If the player wins, he gains (10-2)= $8 --> prob = 1/8
 # If the player loses, he gains (0-2)= $-2 --> prob = 7/8
 # E(gain) = (8 * 1/8) + (-2 * 7/8)
 # E(gain) = -3/4 = -0.75




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
 # P(X>650) = 1 - P(X<= 650)
 # P(X>650) = 1 - pnorm (650, 560, 57)
 1 - pnorm (650, 560, 57)
 # P(X>650) = 0.05717406

# 2. What is the probability that the total weight of 9 people exceeds 650kg?
 # P(Y>650) = 1 - P(Y<= 650)
 # P(Y>650) = 1 - pnorm (650, 630, 61)
 1 - pnorm (650, 630, 61)
# P(Y>650) = 0.3715054

# 3. What is the central region that contains 80% of distribution of the
#    total weight of 8 people?
 # For the 10th percentile:
 qnorm(0.1, 560, 57)
 # 486.9516
 # For the 90th percentile:
 qnorm(0.9, 560, 57)
 # 633.0484
 # The central region is [486.9516, 633.0484]

# 4. What is the central region that contains 80% of distribution of the
#    total weight of 9 people?
 # For the 10th percentile:
 qnorm(0.1, 630, 61)
 # 551.8254
 # For the 90th percentile:
 qnorm(0.9, 630, 61)
 # 708.1746
 # The central region is [551.8254, 708.1746]

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
 # The population average of the bmi is 24.98446

# 2. Compute the population standard deviation of the variable "bmi".
sd(pop2$bmi)
 # The population standard deviation of the bmi is 4.188511

# 3. Compute the expectation of the sampling distribution for the sample
#    average of the variable.
X.bar <- rep(0, 10^5)
for (i in 1:10^5) {
   X.samp <- sample(pop2$bmi, 150)
   X.bar[i] <- mean(X.samp)
}
mean(X.bar)
            # 24.98488

# 4. Compute the standard deviation of the sampling distribution for the
#    sample average of the variable.
sd(X.bar)
 # Standard deviation of the sampling distribution is 0.3430309

# 5. Identify, using simulations, the central region that contains 80% of
#    the sampling distribution of the sample average.
quantile(X.bar, c(0.1, 0.9))
# 10% --> 24.54774
# 90% --> 25.42295
# The central region is [24.54774, 25.42295]

# 6. Identify, using the Central Limit Theorem, an approximation of the
#    central region that contains 80% of the sampling distribution of the
#    sample average.
qnorm(c(0.1, 0.9), mean(X.bar), sd(X.bar))
 # The central region is [24.54527, 25.42449]


# Hint: for (5), use replicate() to draw many samples of size 150,
# compute the mean of bmi for each, then use quantile().
# For (6), use qnorm() with the expectation and sd from (3) and (4).
