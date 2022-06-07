#Chapter 4

# Question 4.1. Table 4.6 presents the probabilities of the random variable Y .
# These probabilities are a function of the number p, the probability of the value
# “0”. Answer the following questions:

#  1. What is the value of p?
  # p + 2p + 3p + ... + 6p = 1 ==> p = 1/21

#  2. P(Y < 3) = ? 0.2857
  # P(Y<3) = P(Y=0) + P(Y=1) + P(Y=2) = 1/21 + 2/21 + 3/21 = 6/21 = 0.2857

#  3. P(Y = odd) = ? 0.5714
  # P(Y = odd) = P(Y=1) + P(Y=3) + P(Y=5) = 2/21 + 4/21 + 6/21 = 12/21 = 0.5714

#  4. P(1 ≤ Y < 4) = ? 0.4286
  # P(1 ≤ Y < 4) = P(Y=1) + P(Y=2) + P(Y=3) = 2/21 + 3/21 + 4/21 = 9/21 = 0.4286

#  5. P(|Y − 3| < 1.5) = ? 0.5714
  # P(|Y − 3| < 1.5) = P(1.5 < Y < 4.5) = P(Y=2) + P(Y=3) + P(Y=4) = 
  # = 3/21 + 4/21 + 5/21 = 12/21 = 0.5714

#  6. E(Y ) = ? 3.33
  # E(Y) = 0 * 1/21 + 1 * 2/21 + 2 * 3/21 + 3 * 4/21 + 4 * 5/21 + 5 * 6/21 = 
  # 3.33

Yval <- c(0,1,2,3,4,5)
Pval <- c(1,2,3,4,5,6)/21
E <- sum(Yval*Pval)
E

#  7. Var(Y ) = ? 2.22
Var <- sum((Yval-E)^2 * Pval)
Var

#  8. What is the standard deviation of Y . = 1.4907
SD <- sqrt(Var)
SD

# Question 4.2. One invests $2 to participate in a game of chance. In this game
# a coin is tossed three times. If all tosses end up “Head” then the player wins
# $10. Otherwise, the player losses the investment.

#  1. What is the probability of winning the game? 1/8 = 0.125
(1/2)^3

#  2. What is the probability of losing the game? 7/8 = 0.875
1 - 1/8

#  3. What is the expected gain for the player that plays this game? (Notice 
#     that the expectation can obtain a negative value.) E(X) = -0.75
Xval <- c(-2,8)
Probval <- c(7,1)/8
Exp <- sum(Xval*Probval)
Exp


#Chapter 6

# Question 6.1. Consider the problem of establishing regulations concerning the
# maximum number of people who can occupy a lift. In particular, we would like
# to assess the probability of exceeding maximal weight when 8 people are allowed
# to use the lift simultaneously and compare that to the probability of allowing 9
# people into the lift.

# Assume that the total weight of 8 people chosen at random follows a normal
# distribution with a mean of 560kg and a standard deviation of 57kg. Assume
# that the total weight of 9 people chosen at random follows a normal distribution
# with a mean of 630kg and a standard deviation of 61kg.

#   1. What is the probability that the total weight of 8 people exceeds 650kg?
1 - pnorm(650, 560, 57) # 1 - P(total weight of 8 people <= 650kg)
  # 0.0572

#   2. What is the probability that the total weight of 9 people exceeds 650kg?
1 - pnorm(650, 630, 61) # 1 - P(total weight of 9 people <= 650kg)
  # 0.3715

#   3. What is the central region that contains 80% of distribution of the total
#      weight of 8 people?  [486.9516, 633.0484]
qnorm(0.1, 560, 57)
qnorm(0.9, 560, 57)

  # [486.9516, 633.0484]

#   4. What is the central region that contains 80% of distribution of the total
#      weight of 9 people? [551.8254, 708.1746]
qnorm(0.1, 630, 61)
qnorm(0.9, 630, 61)

  # [551.8254, 708.1746]


