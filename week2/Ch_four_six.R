
#Chapter 4

Value <- c(0,1,2,3,4,5)
Probability <- c("p", "2p", "3p", "4p", "5p", "6p")
df <- data.frame(Value, Probability)
print(df)

#What is the value of p?
#Probability is always 1 so adding up the value of p totals one. 
#i.e. 21p = 1
#       p= 1/21


#P(Y<3) = ? 
#focusing on the values for Y that is less than 3
p_of_Y_less_than_three <- 1/21+2/21+3/21 
print(p_of_Y_less_than_three)

#P(Y=odd) = ? 
#focusing on the values for Y that are odd. 
p_of_Y_odd <- 2/21 + 4/21 + 6/21 
print(p_of_Y_odd) 

#P(1<=Y<4) = ? 
#Focusing on the values for Y that includes 1 upto 3. 
# 2/21 + 3/21 + 4/21 = 9/21 = 0.4286

# P(|Y-3| < 1.5) = ?
#The value that gives values less than 1.5 are 2,3 &4 
#So, focusing on Y =2, Y=3, & Y =4
p_of_mod_less_than_oneandhalf <-   3/21 + 4/21+ 5/21
print(p_of_mod_less_than_oneandhalf) 

#E(Y)
  #For the expectation we need to multiply the values with their probability. 
  #Converting both the columns to variable and dividing each row in Probability column
  
  Y_value.val <- c(0,1,2,3,4,5)
  Prob.val <- c(1,2,3,4,5,6)/21
  Multiplication <- (Y.val*P.val)
  Expectation <- sum(Multiplication) 
  print(Expectation)

#Var(Y) 
  
  Variance <- sum((Y_value.val - Expectation)^2*Prob.val)
  print(Variance)
 
#Standard Deviation
  Standard_deviation <- sqrt(Variance)
  print(Standard_deviation)

#4.2
  #1. what is the probability of winning the game ? 
#We can create the sample space of tossing the coin 3 times.
  #from which the possible outcome for HHH is 1 out of 8 outcomes.
  #Hence, 1/8 is the probability of winning. 
  
  #2. What is the probability of loosing the game? 
  p_of_winning_game <- 1-1/8 
  print(p_of_winning_game)
  
  #3.What is the expected gain for the player that plays this game? (Notice
  #that the expectation can obtain a negative value.)
  
  #   If the player wins, the player gets $10-$2 =$8
  #   IF the player loses, the player loses -$2
  # hence 
  expected_gain <- 8*1/8 + (-2)*7/8
  print(expected_gain)
  
  #Chapter 6 
  
  #6.1
  #Given
  #   for 8 people: Mean = 560, sd = 57 
  #   for 9 people: Mean = 630, sd = 61
  
  #1.  What is the probability that the total weight of 8 people exceeds 650kg?
  # we have to find cumulative distribution with the given random variable so we use pnorm.
      1- pnorm(650,mean = 560, sd = 57)
      
      
  #2. . What is the probability that the total weight of 9 people exceeds 650kg?
  # Same as 1
      1-pnorm(650, mean= 630, sd = 61)
      
  #3. What is the central region that contains 80% of distribution of the total
   #   weight of 8 people?
#The question gives the boundary of 80% distribution so using qnorm.
      qnorm(0.10, mean =560, sd = 57)
      qnorm(0.90, mean =560, sd = 57)
  #4. What is the central region that contains 80% of distribution of the total
   #   weight of 9 people?
      qnorm(0.10, mean =630, sd =61)
      qnorm(0.90, mean =630, sd =61)
  