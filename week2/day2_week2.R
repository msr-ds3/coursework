## day 2 week 2 

# chapter 4, questions 4.1:
# 1. The value of p is 1/21. 
#     The probabilities sum to one: p + 2p + 3p + 4p + 5p + 6p = 1 -> 
#       p = 1/21

# 2: P(Y < 3) = p + 2p + 3p
  # 1/21 + 2/21 + 3/21 = 6/21 = 0.28

# 3: P(Y = odd) = 2p + 4p + 6p
#   2/21 + 4/21 + 6/21 = 12/21

# 4: P(1 <= Y < 4) = 2p + 3p 
  # 2/21 + 3/21 = 5/21

# 5: P(|Y - 3| < 1.5) = 2p + 3p + 4p 
#   3/21 + 4/21 + 5/21 = 12/21

# work: |Y - 3| < 1.5, Y = 2 -> |-1| < 1.5 -->> True so use. 


# 6. E(Y) = 3.33
  # 0(1/21) + 1(2/21) + 2(3/21) + 3(4/21) + 4(5/21) + 5(6/21) =  3.33

# 7. Var(Y) = 2.22
# ((0 - 3.33)^2 * 1/21) + ((1 - 3.33)^2 * 2/21) + ((2 - 3.33)^2 * 3/21) + ((3 - 3.33)^2 * 4/21) + ((4 - 3.33)^2 * 5/21) + ((5 - 3.33)^2 * 6/21)  = 2.22


# 8. What is the standard deviation of Y?
  # the square root of the variance is the standard deviation
  # square root (2.2) = 1.49



# Question 4.2:

# 1. 1/2 * 1/2 * 1/2 = 1/8

# 2. 7/8  One loses every time if they do not win 

# 3. expected gains?
#  E(X) = 8(1/8) + (-2)(7/8) = -0.75




# Chapter 6, question 6.1:
 
# 1. prob that total weight of 8 people exceeds 650kg
  # > 1 - pnorm(mean = 560, sd = 57, 650)
  # answer = 0.05717406

# 2. 9 people higher than 650kg
  # > 1 - pnorm(mean = 630, sd = 61, 650)
  # 0.3715054

# 3. central region that contains 80% of total weight of 8 people
  # [10%, 90%] 
  # [qnorm(0.1, 560, 57), qnorm(0.9, 560, 57)]
  # [486.9516, 633.0484]

# 4. central region that contains 80% of total weight of 9 people
  # [10%, 90%] 
  # [qnorm(0.1, 630, 61), qnorm(0.9, 630, 61)]
  # [551.8254, 708.1746]





