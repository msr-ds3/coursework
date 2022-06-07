#############Chapter 4

####Question 4.1

##part 1
#add up p's for each Value and use algebra to find p
#(p + 2p + 3p + 4p + 5p + 6p) = 21p
#21p = 0 
#p = 1/21

#part 2
#take the sum of the probabltiies where Y < 3 (this means values 0, 1, 2)
#p = 1/21
#2p = 2/21
#3p = 3/21
#P(Y < 3) = 6/21 = 2/7

#part 3
##take the sum of the probabltiies where Y = odd (this means values 1, 3, 5)
#2p = 2/21
#4p = 4/21
#6p = 6/21
#P(Y = odd) = 12/21 = 4/7

#part 4
##take the sum of the probabltiies where 1<=Y<4 (this means values 1, 2, 3)
#2p = 2/21
#3p = 3/21 
#4p = 4/21
#P(1<=Y<4) = 9/21 = 3/7

#part 5
##take the sum of the probabltiies where |Y-3| < 1.5 (this means values 2, 3, 4)
#3p = 3/21
#4p = 4/21
#5p = 5/21
#P(|Y-3| < 1.5) = 12/21  = 4/7

#part 6
Y_Values <- c(0,1,2,3,4,5) #adding y values 
Probability_Values <- c(1,2,3,4,5, 6)/21 # divide by 21 applies to each observation, 
                                      #this allows us to get the probability 

Expectation <- sum(Y_Values*Probability_Values)
Expectation # Expectation = 3.33 repeating 

#part 7 
Variance <- sum((Y_Values-Expectation)^2*Probability_Values)
Variance # Variance = 2.22 repeating

#part 8 
Standard_Deviation <- sqrt(Variance)
Standard_Deviation #Standard_Deviation = 1.49.....

####Question 4.2

#part 1 
#we want 3 heads if a coin is tossed 3 times 
# (3 choose 3)/2^3 = 1/8 = 0.125
#probability of winning the game is 12.5% 

#part 2 
#probability of winning is 12.5%
#100-12.5 = 87.5%
#probability of losing the game is 87.5%

#part 3
winning <- c(8)
losing <- c(-2)
Expectation <- winning*0.125+(-2)*(.875) 
Expection #Expectation = -0.75


#############Chapter 6


####Question 6.1

?qnorm #documentation


#part 1 
#total weight of 8 people follow the normal distribution
#with the mean of 560kg and Standard deviation of 57kg. 
#what is probability that total weight of 8 people exceed 650?

P_greater_650_with_8 <- 1-pnorm(650, 560, 57)
P_greater_650_with_8 #P_greater_650_with_8 = 5.7%

#part 2
#total weight of 9 people follow the normal distribution
#with the mean of 630kg and Standard deviation of 61kg. 
#what is probability that total weight of 9 people exceed 650?

P_greater_650_with_9 <- 1-pnorm(650, 630, 61)
P_greater_650_with_9 #P_greater_650_with_9 = 37.15%

#part 3
#for 8 people
#to find the central region of the 80% distribution we need to find the top and bottom 10% regions 
?qnorm
qnorm(.1, 560, 57) #486.9516
qnorm(.9, 560, 57) #633.0484
#central region is [486.9516, 633.0484]

#part 4 
#for 9 people
#to find the central region of the 80% distribution we need to find the top and bottom 10% regions 
qnorm(.1, 630, 61) #551.8254
qnorm(.9, 630, 61) #708.1746
#central region is [551.8254, 708.1746]

