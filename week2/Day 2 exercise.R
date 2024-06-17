library(tidyverse)

library(ggplot2)

magnet <- read.csv('C:/Users/jane/Downloads/magnets.csv')
#What is the sample average of the change in score between the patient’s
#rating before the application of the device and the rating after the application?
summary(magnet)

#is the variable "active" a factor or a numeric value: 
#answer: the variable "active" is a factor

# Compute the average value of the variable “change” for the patients that
#received and active magnet and average value for those that received an
#inactive placebo. 
mean(magnet$change[1:29])
mean(magnet$change[30:50])

# Compute the sample standard deviation of the variable “change” for the
#patients that received and active magnet and the sample standard deviation for those that received an inactive placebo.
sd(magnet$change[1:29])
sd(magnet$change[30:50])

#Produce a boxplot of the variable “change” for the patients that received
#and active magnet and for patients that received an inactive placebo.
#What is the number of outliers in each subsequence?

magnet%>%
  ggplot(mapping=aes(x= active, y=change))+ 
  geom_boxplot() 

#There are 3 numbers of outliers for subjects treated with inactive placebo 


#Question 10.1
#Simulate the sampling distribution of average and the median of a sample
#of size n = 100 from the Normal(3, 2) distribution. Compute the expectation and the variance of the sample average and of the sample median.
#Which of the two estimators has a smaller mean square error?

estimate_var <- function(mu, std) {
  var(rnorm(100,mu,std))
}

mu <- 3
std <- 2
X.var <- replicate(1e5, estimate_var(mu, std))
mean(X.var)
var(X.var)

estimate_med <- function(mu, std) {
  median(rnorm(100,mu,std))
}

X.med <- replicate(1e5, estimate_med(mu, std))
mean(X.med)
var(X.med)

#Simulate the sampling distribution of average and the median of a sample
#of size n = 100 from the Uniform(0.5, 5.5) distribution. Compute the
#expectation and the variance of the sample average and of the sample
#median. Which of the two estimators has a smaller mean square error?

a = 0.5
b = 0.5

estimate_var_uniform <- function(a, b) {
  mean(runif(100,a,b))
}

X.var2 <- replicate(1e5, estimate_var_uniform(a, b))
mean(X.var2)

estimate_med_uniform <- function(a, b) {
  median(runif(100,a,b))
}

X.var2 <- replicate(1e5, estimate_med_uniform(a, b))
median(X.var2)

#Question 10.2

#Part 1
ex2 <- read.csv("C:/Users/jane/Downloads/ex2.csv")
summary(ex2)

ex2%>%
  filter(group == "HIGH")%>%
  summarize(count = n(), high_pressure_proportion = count/150)

#Part2
summary(pop2)

pop2%>%
  filter(group == "HIGH")%>%
  summarize(count = n(), high_pressure_proportion = count/100000)

#Part3: Simulate the sampling distribution of the sample proportion and compute
#its expectation

ex2.var <- replicate(1e5, mean(sample(ex2$group == 'HIGH',150)))
mean(ex2.var)

#Part4: Compute the variance of the sample proportion
var(ex2.var)

#Part5: It is proposed in Section 10.5 that the variance of the sample proportion
#is Var(Pˆ) = p(1 − p)/n, where p is the probability of the event (having a
#high blood pressure in our case) and n is the sample size (n = 150 in our
#case). Examine this proposal in the current setting.
                                                                                                                             
pop2%>%
  filter(group == "HIGH")%>%
  summarize(count = n(), high_pressure_proportion = count/100000, 
            variance_sample_proportion = high_pressure_proportion*(1-high_pressure_proportion)/150)
  
#Guided Practice 2.2 If we don’t think the side of the room a person sits on in
#class is related to whether the person owns an Apple product, what assumption are
#we making about the relationship between these two variables?1

#Question 9.2
mu1 <- 3.5
mu2 <- 3.5
sd1 <- 3
sd2 <- 1.5

estimate_active <- function(mu1, sd1) {
  rnorm(29,mu1,sd1)
}

active <- replicate(1e5, estimate_active(mu1, sd1))
x1 <- mean(active)
var1 <- var(active)

estimate_inactive <- function(mu2, sd2) {
  rnorm(21,mu2,sd2)
}

inactive <- replicate(1e5, estimate_inactive(mu2, sd2))

x2 <- mean(inactive)
var2 <- var(inactive)

test_stat <- (x1 - x2)/sqrt((var1/29)+ (var2/21))

quantile(test_stat, c(0.025, 0.975))




