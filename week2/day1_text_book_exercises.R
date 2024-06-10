# Chapter 4
# Q. 4.1

# 1. p = 1/21
# 2. P(Y < 3) = 6/21
# 3. P(Y = ODD) = 12/21
# 4. P(1 <= Y < 4) = 9/21
# 5. P(|Y-3| < 1.5) = 12/21
# 6. E(Y) = 3.333
# 7. Var(Y) = 2.222
# 8. Standard Deviation(Y) = 1.490

# Q. 4.2

# 1. 1/8 chance of winning the game
# 2. 7/8 chance of losing the game
# 3. Expected gain of playing this game is -0.75


# Chapter 6
# Q. 6.1

# 8 People: Mean = 560 kg, SD = 57 kg
# 9 People: Mean = 630 kg, SD = 61 kg

# 1. What is the probability that the total weight of 8 people exceeds 650kg?
1 - pnorm(650, 560, 57)

# 0.05717406 is the probability that the total weight of 8 people exceeds 650kg

# 2. What is the probability that the total weight of 9 people exceeds 650kg?
1 - pnorm(650, 630, 61) 

# 0.3715054 is the probability that the total weight of 9 people exceeds 650kg

# 3. What is the central region that contains 80% of distribution of the total weight of 8 people?
qnorm(0.10, 560, 57) # 486.9516
qnorm(0.90, 560, 57) # 633.0484

# The central region is from 486.9516 kg to 633.0484 kg: [486.9516, 633.0484]

# 4. What is the central region that contains 80% of distribution of the total weight of 9 people?
qnorm(0.10, 630, 61) # 551.8254
qnorm(0.90, 630, 61) # 708.1746

# The central region is from 551.8254 kg to 708.1746 kg: [551.8254, 708.1746]


# Chapter 7
# Q. 7.1

library(tidyverse)
pop2 = read.csv('pop2.csv')

# Our goal in this question is to investigate the sampling distribution of the sample 
# average of the variable “bmi”. We assume a sample of size n = 150.

# 1. Compute the population average of the variable “bmi”.
pop2 |> 
  summarize(mean(bmi))

# 2. Compute the population standard deviation of the variable “bmi”.
pop2 |> 
  summarize(sd(bmi))

# 3. Compute the expectation of the sampling distribution for the sample average of the variable.
X.bar <- rep(0,10^3)
for(i in 1:10^3)
{
  X.samp <- sample(pop2$bmi,150)
  X.bar[i] <- mean(X.samp)
}
mean(X.bar)

# 4. Compute the standard deviation of the sampling distribution for the sample average of the variable.
sd(X.bar)

# 5. Identify, using simulations, the central region that contains 80% of the sampling distribution of the sample average.
quantile(X.bar, c(0.1, 0.9))

# 6. Identify, using the Central Limit Theorem, an approximation of the central region that contains 80% of the sampling distribution of the sample average.
qnorm(c(0.1,0.9),mean(X.bar),sd(X.bar))
