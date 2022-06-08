library(tidyverse)
 

#######Red the csv file and assign it to a data frame

pop_df <- read.csv(file = "pop2.csv")


########################Chapter 7

####Question 7.1


#Part 1
mean(pop_df$bmi) # mean ~= 24.98

#Part 2
sd(pop_df$bmi) # standard deviation ~= 4.18

#Part 3
#reference 7.2.3 Theoretical models pg. 112
X.bar <- rep(0, 10^5)
for(i in 1:10^5){
  X.sample <- sample(pop_df$bmi, 150)
  X.bar[i] <- mean(X.sample)
}
mean(X.bar) #Expectation of the sample distribution for the sample average ~= 24.98

#Part 4

X.bar2 <- rep(0, 10^5)
for(i in 1:10^5){
  X.sample <- sample(pop_df$bmi, 150)
  X.bar2[i] <- mean(X.sample)
}
sd(X.bar2) #Standard deviation of the sample distribution for the sample average ~= 0.3410

#Part 5
?quantile
X.bar3 <- rep(0, 10^5)
for(i in 1:10^5){
  X.sample <- sample(pop_df$bmi, 150)
  X.bar3[i] <- mean(X.sample)
}
quantile(X.bar3, c(0.1, 0.9))
#10% ~= 24.54
#90% ~= 25.42

#Part 6
?qnorm
X.bar4 <- rep(0, 10^5)
for(i in 1:10^5){
  X.sample <- sample(pop_df$bmi, 150)
  X.bar4[i] <- mean(X.sample)
}
qnorm(c(0.1, 0.9), mean(X.bar4), sd(X.bar4))
# ans = 24.54717 25.42298

########################Chapter 9

####Question 9.1

magnets_df <- read.csv(file = 'magnets.csv')

#Part 1
mean(magnets_df$change)

#Part 2

#see documentation below if confused on the difference between factor and numeric variables
?factor
?numeric
summary(as.factor(magnets_df$active))
#the variable 'active' is a factor because it contain two levels of the variable. 
#Note the level names '1' & '2' are irrelevant 

#Part 3 
mean(magnets_df$change[1:29])
#mean ~= 5.24
mean(magnets_df$change[30:50])
#mean ~= 1.09

#Part 4
sd(magnets_df$change[1:29])
#sd ~= 3.23
sd(magnets_df$change[30:50])
#sd ~= 1.57

#Part 5
boxplot(magnets_df$change[1:29]) #no outliers
boxplot(magnets_df$change[30:50]) 
#note in the boxplot we can see three  
#outliers. They are 3, 4, 5
#Use table to find the number of observations for each outlier
table(magnets_df$change[30:50])
#Observations of 3 = 1
#Observations of 4 = 2
#Observations of 5 = 1




########################Chapter 10

####Question 10.1 

#Part 1
?Normal

X.bar5 <- rep(0, 10^5)
X.median <- rep(0, 10^5)
for(i in 1:10^5){
  Norm <- rnorm(100, 3, sqrt(2)) #taken from question 
  X.bar5[i] <- mean(Norm)
  X.median[i] <- median(Norm)
  
}
mean(X.bar5) # mean ~= 3
mean(X.median) # mean ~= 3

var(X.bar5) # variance ~= 0.02
var(X.median) #variance ~= 0.03

#Part 2

?Uniform
X.bar6 <- rep(0, 10^5)
X.median2 <- rep(0, 10^5)
for(i in 1:10^5){
  Norm2 <- runif(100, 0.5, 5.5) #taken from question 
  X.bar6[i] <- mean(Norm2)
  X.median2[i] <- median(Norm2)
  
}

mean(X.bar6) # mean ~= 3
mean(X.median2) # mean ~= 3

var(X.bar6) # variance ~= 0.02
var(X.median2) #variance ~= 0.06

####Question 10.2

ex2 <- read.csv("ex2.csv")

#Part 1
summary(as.factor(ex2$group))
porportion_with_high_BP <- mean(as.factor(ex2$group) == "HIGH")
porportion_with_high_BP # sample has 24% with high blood pressure

#Part 2
summary(as.factor(pop_df$group))
porportion_with_high_BP_pop <- mean(as.factor(pop_df$group) == "HIGH")
porportion_with_high_BP_pop #population has 28% with high blood pressure

#Part2 
Sim_pop <- rep(0, 10^5)
for(i in 1:10^5){
  sam <- sample(pop_df$group, 150)
  Sim_pop[i] <- mean(sam == "HIGH")
}
mean(Sim_pop) # mean ~= 0.28
 
#Part 4
var(Sim_pop) # variance ~= 0.001
