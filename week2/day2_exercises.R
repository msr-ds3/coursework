
p <- 1/21
value <- c(0, 1, 2, 3, 4, 5)
probability <- c(p, 2*p, 3*p, 4*p, 5*p, 6*p)

y <- data.frame(value, probability)

# 4.1 
# What is the value of p?
#   2. P(Y < 3) = ?
#   3. P(Y = odd) = ?
#   4. P(1 ≤ Y < 4) = ?
#   5. P(|Y − 3| < 1.5) = ?
#   6. E(Y ) = ?
#   7. Var(Y ) = ?
#   8. What is the standard deviation of Y .

# 1
# These probabilities sum to 1
# p + 2p + 3p + 4p + 5p + 6p = (1 + 2 + 3 + 4 + 5 + 6) p = 21p = 1 =⇒ p = 1/21 .

# 2

# P(Y < 3) = P(Y = 0) + P(Y = 1) + P(Y = 2) =  1/21 + 2/21 + 3/21 = 6/21 = 0.2857

# 3
 
# P(Y = odd) = P(Y = 1)+P(Y = 3)+P(Y = 5) = 2/21 + 4/21 + 6/21 = 12/21 = = 0.5714

# 4

# P(1 ≤ Y < 4) = P(Y = 1)+P(Y = 2)+P(Y = 3) = 2/21 + 3/21 + 4/21 = 9/21 = 0.4286

# 5 

# P(0) or P(1) --> |2-3| = 1; |3-3| = 0; |4-3| = 1 --> P(2) + P(3) + P(4) = 2/21 + 3/21 + 4/21 = 12/21 = = 0.5714

# 6

# Expectation: multiplication of the values by their respective probabilities 
# and the summation of the products 

E <- sum(value * probability)
E

# 7
# Var(X) = SUM((x − E(X))**2 × P(x))
Var <- sum((value - E)**2 * probability )
Var

# 8
# Standard deviation 
sd <- sqrt(Var)
sd

 
# 4.2
# One invests $2 to participate in a game of chance. In this game
# a coin is tossed three times. If all tosses end up “Head” then the player wins
# $10. Otherwise, the player losses the investment.

# 1. What is the probability of winning the game?
# the probability of getting Heads when tossing a coin is 1/2, if you want 3 in a row its (1/2) ** 3 = 1/8

# 2. The probability of losing the game is 1 - 1/8 = 7/8

# 3. E(x) = ((10 - 2) * 1/8) + ((-2) * 7/8) = −0.75

# 6.1 
#   1. What is the probability that the total weight of 8 people exceeds 650kg?
mean <- 560 
sd <- 57
prob <- 1 - pnorm(650, mean, sd)

#   2. What is the probability that the total weight of 9 people exceeds 650kg?
mean_9 <- 630
sd_9 <- 61
prob_9 <- 1 - pnorm(650, mean_9, sd_9)
prob_9

#   3. What is the central region that contains 80% of distribution of the total
# weight of 8 people?
# 10% region to 90% region 
qnorm(0.9, mean, sd)
qnorm(0.1, mean, sd)
# from 486.95 to 633.05

#   4. What is the central region that contains 80% of distribution of the total
# weight of 9 people?
qnorm(0.9, mean_9, sd_9)
qnorm(0.1, mean_9, sd_9)
# from 551.83 to 708.17