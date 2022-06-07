# Chapter 4 Exercises
# 4.1
# 1. p is the probability of each value of Y. Y is {0, 1, 2, 3, 4, 5} and the probabilities are {p, 2p, 3p, 4p, 5p, 6p}. p is 1/21
# 2. P(Y < 3) = P(Y = 0) + P(Y = 1) + P(Y = 2) = 1/21 + 2/21 + 3/21 = 6/21 = 0.2857
# 3. P(Y = odd) = P(Y = 1) + P(Y = 3) + P(Y = 5) = 2/21 + 4/21 + 6/21 = 12/21 = 0.5714
# 4. P(1 <= Y < 4) = P(Y = 1) + P(Y = 2) + P(Y = 3) = 2/21 + 3/21 + 4/21 = 9/21 = 0.4286
# 5. P(|Y - 3| < 1.5) = P(Y = 2) + P(Y = 3) + P(Y = 4) = 0.5714
# 6. E(Y) =  (0 * 1/21) + (1 * 2/21) + (2 * 3/21) + (3 * 4/21) + (4 * 5/21) + (5 * 6/21) = 70/21 = 3.3333
# 7. Var(Y) = [(0 - 3.3333)^2 * 1/21] + [(1 - 3.3333)^2 * 2/21] + [(2 - 3.3333)^2 * 3/21] + [(3 - 3.3333)^2 * 4/21] + [(4 - 3.3333)^2 * 5/21] + [(5 - 3.3333)^2 * 6/21] = 2.2222
# 8. sd(Y) = sqrt(Var(Y)) = 1.4907

# 4.2
# 1. The probabiliy of winning is 1/8
# 2. The probability of losing is 8/8 - 1/8 = 7/8
# 3. The expected gain is E(X) = (10 - 2) * 1/8 + (-2) * 7/8 = -0.75

# Chapter 6 Exercises
# 6.1
# 1
pnorm(650, 560, 57) # The probability of being less than 650kg
1 - pnorm(650, 560, 57) # The probability of being more than 650kg
# 2
pnorm(650, 630, 61) # The probability of being less than 650kg
1 - pnorm(650, 630, 61) # The probability of being more than 650kg
# 3
qnorm(0.1, 560, 57) = 486.9516 # 10%-percentile of the total weight of 8 people
qnorm(0.9, 560, 57) = 633.0484 # 90%-percentile of the total weight of 8 people
# The central region that contains 80% of distribution of the total weight of 8 people is [486.9516, 633.0484]
# 4
qnorm(0.1, 630, 61) = 551.8254 # 10%-percentile of the total weight of 9 people
qnorm(0.9, 630, 61) = 708.1746 # 90%-percentile of the total weight of 9 people
# The central region that contains 80% of distribution of the total weight of 9 people is [551.8254, 708.1746]

