library(tidyverse)

# Read Chapter 9 of IST and do exercise 9.1
magnets = read.csv("magnets.csv")

# 1. What is the sample average of the change in score between the patient’s rating 
# before the application of the device and the rating after the application?
magnets |> 
  summarize(mean(change))
# The sample average of the change in score between the patient's rating is 3.5


# 2. Is the variable “active” a factor or a numeric variable?
# The variable "active" is a factor since there are two groups (1 and 2)


# 3. Compute the average value of the variable “change” for the patients that
# received and active magnet and average value for those that received an
# inactive placebo. (Hint: Notice that the first 29 patients received an active
#                  magnet and the last 21 patients received an inactive placebo. The subsequence of the first 29 values of the given variables can be obtained via
#                  the expression “change[1:29]” and the last 21 vales are obtained via the
#                  expression “change[30:50]”.)

# Active Magnet
magnets |> 
  summarize(mean(change[1:29]))
# Average value for change is 5.241379 for the active magnet patients

# Inactive Placebo
magnets |> 
  summarize(mean(change[30:50]))
# Average value for change is 1.095238 for the inactive placebo patients


# 4. Compute the sample standard deviation of the variable “change” for the
# patients that received and active magnet and the sample standard deviation for those that received an inactive placebo.
# Active Magnet
magnets |> 
  summarize(sd(change[1:29]))
# Standard deviation for change is 3.236568 for the active magnet patients

# Inactive Placebo
magnets |> 
  summarize(sd(change[30:50]))
# Standard deviation for change is 1.578124 for the inactive placebo patients


# 5. Produce a boxplot of the variable “change” for the patients that received
# and active magnet and for patients that received an inactive placebo.
# What is the number of outliers in each subsequence?
magnets |> 
  ggplot(aes(x=active, y=change)) +
  geom_boxplot()
# Based on the box plot, there are 3 outliers in the inactive placebo group.
# There are no outliers in the active magnet group


# Read Chapter 10 of IST and do exercises 10.1 and 10.2
# 10.1
# 1. Simulate the sampling distribution of average and the median of a sample
# of size n = 100 from the Normal(3, 2) distribution. Compute the expectation and the variance of the sample average and of the sample median.
# Which of the two estimators has a smaller mean square error?
mu <- 3
sig <- sqrt(2)
X.mean <- rep(0,10^5)
X.median <- rep(0,10^5)
for(i in 1:10^5)
{
  X <- rnorm(100,mu,sig)
  X.mean[i] <- mean(X)
  X.median[i] = median(X)
}
# Expectation sample average and sample median
mean(X.mean)
mean(X.median)
# Because estimations pretty much equal the true value, they are unbiased estimators

# Variance of sample average and sample median
var(X.mean)
var(X.median)
# MSE of unbiased estimator is equal to the variance. We can see that variance of mean (0.01995872) is less than
# the variance of the median (0.03087899). This shows that the mean has the smaller MSE.

# 2. Simulate the sampling distribution of average and the median of a sample
# of size n = 100 from the Uniform(0.5, 5.5) distribution. Compute the
# expectation and the variance of the sample average and of the sample
# median. Which of the two estimators has a smaller mean square error?
a <- 0.5
b <- 5.5
X.mean <- rep(0,10^5)
X.median <- rep(0,10^5)
for(i in 1:10^5)
{
  X <- runif(100,a,b)
  X.mean[i] <- mean(X)
  X.median[i] = median(X)
}
# Expectation sample average and sample median
mean(X.mean)
mean(X.median)
# Because estimations pretty much equal the true value, they are unbiased estimators

# Variance of sample average and sample median
var(X.mean)
var(X.median)
# MSE of unbiased estimator is equal to the variance. We can see that variance of mean (0.02094777) is less than
# the variance of the median (0.0612047). This shows that the mean has the smaller MSE.

# 10.2
pop2 = read.csv("pop2.csv")
ex2 = read.csv("ex2.csv")
# 1. Compute the proportion in the sample of those with a high level of blood
# pressure
ex2 |> 
  filter(group == "HIGH") |> 
  summarize(proportions = n() / nrow(ex2))

# 2. Compute the proportion in the population of those with a high level of
# blood pressure.
pop2 |> 
  filter(group == "HIGH") |> 
  summarize(proportions = n() / nrow(pop2))

# 3. Simulate the sampling distribution of the sample proportion and compute
# its expectation.
P.hat <- rep(0,10^3)
for(i in 1:10^3)
{
  X.samp <- sample(pop2$group, 150)
  P.hat[i] <- mean(X.samp == "HIGH")
}
mean(P.hat)

# 4. Compute the variance of the sample proportion.
var(P.hat)

# 5. It is proposed in Section 10.5 that the variance of the sample proportion
# is Var(Pˆ) = p(1 − p)/n, where p is the probability of the event 
# (having a high blood pressure in our case) and n is the sample size (n = 150 in our case). 
# Examine this proposal in the current setting.
p <- mean(P.hat)
n = 150

p*(1-p)/n #0.001348443
var(P.hat) #0.001382094
# It seems that this proposal holds true in this current setting. Using the sampling distribution
# of proportions, the formula holds.

# Read Chapter 2 of the online textbook Intro to Stat with Randomization and Simulation (ISRS) and do exercises 2.2 and 2.6
# 2.2
# (a) What proportion of patients in the treatment group and what proportion of patients in the
# control group died?
# Treatment: 
45/69
# Control: 
30/34

# (b) One approach for investigating whether or not the treatment is effective is to use a randomization technique.
# i. What are the claims being tested? Use the same null and alternative hypothesis notation
# used in the section.
# Null Hypothesis: The treatment does not have any effect on the results
# Alternate Hypothesis: The treatment does have an affect on the results

# iii. What do the simulation results shown below suggest about the effectiveness of the transplant program?
30/34 - 45/69
# 0.230179 is the difference between the proportions.
# Based on the simulation data, it appears that there is a significant difference between the two groups.

#2.6
# (a) What are the hypotheses?
# Null Hypothesis:  Yawning has no effect on surrounding people
# Alternate Hypothesis: Yawning is contageous

# (b) Calculate the observed difference between the yawning rates under the two scenarios.
30/34 - 4/16
# diff (treatment - control) = 0.6323529

# (c) Estimate the p-value using the figure above and determine the conclusion of the hypothesis test.
# The p-value should be extremely low since 0.6 is very far and probability is small.
# This suggests that we reject the numm hypothesis since it is unlikely that there is no effect.

# Read Sections 3.1 and 3.2 of ISRS

# Do exercise 9.2 in IST
