library(tidyverse)
library(dplyr)

####################################################################################
# IST Chapter 9, Exercise 9.1
magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")
head(magnets)
# 1. What is the sample average of the change in score between the
#    patient's rating before the application of the device and the
#    rating after the application?
samp <- sample(magnets$change,50)
sampavg <- mean(samp)
sampavg
#3.5
# 2. Is the variable "active" a factor or a numeric variable?
# -> it is a facor variable 
# 3. Compute the average value of the variable "change" for the patients that
#    received an active magnet and average value for those that received an
#    inactive placebo. (Hint: Notice that the first 29 patients received an
#    active magnet and the last 21 patients received an inactive placebo. The
#    subsequence of the first 29 values can be obtained via "change[1:29]" and
#    the last 21 values via "change[30:50]".)
activerows <- magnets[1:29, ]
activerows
activeavg <- mean(activerows$change)
activeavg
inacvtiverows <- magnets[30:50, ]
inacvtiverows 
inactiveavg <-mean(inacvtiverows$change)
inactiveavg
# 4. Compute the sample standard deviation of the variable "change" for the
#    patients that received an active magnet and the sample standard deviation
#    for those that received an inactive placebo.
activerow <- magnets[1:15, ]
sdactive <- sd(activerow$change)
sdactive
inacvtiverow <- magnets[30:45, ]
sdinactive <- sd(inacvtiverow$change)
sdinactive
# 5. Produce a boxplot of the variable "change" for the patients that received
#    an active magnet and for patients that received an inactive placebo. What
#    is the number of outliers in each subsequence?
boxplot(activerows$change)
magnetplot <- magnets[1:29, ] %>% select(change)
boxplot(magnetplot)
boxplot(inacvtiverows$change)
magnetplot <- magnets[30:50, ] %>% select(change)
boxplot(magnetplot)
#Outliers
####################################################################################
# IST Chapter 10, Exercise 10.1
#
# In Subsection 10.3.2 we compare the average against the midrange as estimators
# of the expectation of the measurement. The goal of this exercise is to repeat
# the analysis, but this time compare the average to the median as estimators of
# the expectation in symmetric distributions.
#
# 1. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Normal(3, 2) distribution. Compute the expectation
#    and the variance of the sample average and of the sample median. Which of
#    the two estimators has a smaller mean square error?
mu <- 3
sig <- sqrt(2)
X.bar <-  rep(0,10^5)
X.median <- rep(0,10^5)
for(i in 1:10^5)
{
 X <- rnorm(100,mu,sig)
 X.bar[i] <- mean(X)
 X.median[i] <- median(x)
}

bias1 <- mean(X.bar) - mu

bias2 <- mean(X.median) - mu 
#smaller varianace as well 
var(X.bar)
var(X.median)

mse1 <- bias1*bias1 + var(X.bar)
mse2 <- bias2^2 + var(X.median)
mse1
# 0.01997002
mse2
# 0.1858664

# 2. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Uniform(0.5, 5.5) distribution. Compute the
#    expectation and the variance of the sample average and of the sample
#    median. Which of the two estimators has a smaller mean square error?
a <- 0.5
b <- 5.5
X.bar <- rep(0,10^5)
X.median <- rep(0,10^5)
for(i in 1:10^5)
{
X <- runif(100,a,b)
X.bar[i] <- mean(X)
X.median[i] <- median(x)
}
var(X.bar)
#0.02075356
var(X.median)
#0.001207595


####################################################################################
# IST Chapter 10, Exercise 10.2
#
# The goal in this exercise is to assess estimation of a proportion in a
# population on the basis of the proportion in the sample.
#
# The file "pop2.csv" was introduced in Exercise 7.1 of Chapter 7. This file
# contains information associated to the blood pressure of an imaginary
# population of size 100,000. One of the variables in the file is a factor by
# the name "group" that identifies levels of blood pressure. The levels of this
# variable are "HIGH", "LOW", and "NORMAL".
#
# The file "ex2.csv" contains a sample of size n = 150 taken from the given
# population. The file "ex2.csv" corresponds to the observed sample and the file
# "pop2.csv" corresponds to the unobserved population.

pop2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv")
ex2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/ex2.csv")

# 1. Compute the proportion in the sample of those with a high level of blood
#    pressure.
highbp <- ex2 %>% select(group) %>% filter(group == "HIGH")
prop <-nrow(highbp)/nrow(ex2) 
prop

# 2. Compute the proportion in the population of those with a high level of
#    blood pressure.
highbp <- pop2 %>% select(group) %>% filter(group == "HIGH")
nrow(highbp)/nrow(pop2) 
# 3. Simulate the sampling distribution of the sample proportion and compute
#    its expectation.
samp <- sample(pop2$group,150)
X.bar <- rep(0,10^5)
for(i in 1:10^5)
{
    samp<- sample(pop2$group,150)
    X.bar[i]<-mean(samp=="HIGH")
}
mean(X.bar)
# 0.2811051
# 4. Compute the variance of the sample proportion.
var(X.bar)
#0.001352851
# 5. It is proposed in Section 10.5 that the variance of the sample proportion
#    is Var(P_hat) = p(1 - p)/n, where p is the probability of the event (having
#    a high blood pressure in our case) and n is the sample size (n = 150 in our
#    case). Examine this proposal in the current setting.
# 
prop*(1-prop)/nrow(ex2)
# 0.001238815
####################################################################################
# ISRS Exercise 2.2 - Heart transplants, Part II
#
# Exercise 1.50 introduces the Stanford Heart Transplant Study. Of the 34
# patients in the control group, 4 were alive at the end of the study. Of the 69
# patients in the treatment group, 24 were alive.
#
# Contingency table:
#                                    Group
#                       --------------------------
#                        Control  Treatment  Total
#          ---------------------------------------
#                Alive      4        24       28
#          ---------------------------------------
#  Outcome       Dead       30       45       75
#          ---------------------------------------
#                Total      34       69      103
#          ---------------------------------------
#
# (a) What proportion of patients in the treatment group and what proportion
#     of patients in the control group died?
control <- 30/34
control
# 0.8823529
treatment <-  45/69
treatment
# 0.6521739
# (b) One approach for investigating whether or not the treatment is effective
#     is to use a randomization technique.
#     i. What are the claims being tested? Use the same null and alternative
#          hypothesis notation used in the section.
#-> The claim being tested is that the death rate for the heart transplant is the same in every group 
#-> The null hypothesis claims that the heart transplant has no effect on the death rate 
#-> The alternative hypothesis claims that the death rate change is caused by the haert transplant  
#     ii. The paragraph below describes the set up for such approach, if we were
#     to do it without using statistical software. Fill in the blanks with a
#     number or phrase, whichever is appropriate. 
#          We write alive on -> 28 cards representing patients who were
#          alive at the end of the study, and dead on ->75 cards representing
#          patients who were not. Then, we shuffle these cards and split them
#          into two groups: one group of size -> 69 representing treatment, and
#          another group of size -> 34 representing control. We calculate the
#          difference between the proportion of dead cards in the treatment and
#          control groups (treatment - control) and record this value. We repeat
#          this many times to build a distribution centered at -> 0  Lastly, we
#          calculate the fraction of simulations where the simulated differences
#          in proportions are -> <=-0.2302.If this fraction is low, we conclude that it is
#          unlikely to have observed such an outcome by chance and that the null
#          hypothesis should be rejected in favor of the alternative.
#     iii. What do the simulation results suggest about the effectiveness of
#          the transplant program? (See textbook for figure.)
diff = treatment-control
diff
# The difference is - 0.2302 and this is at the end of the distribution so the p value is small. this means 
# that it is spossible for the heart transplant to reduce the death rate 

####################################################################################
# ISRS Exercise 2.6 
# An experiment conducted by the MythBusters, a science entertainment TV program
# on the Discovery Channel, tested if a person can be subconsciously influenced
# into yawning if another person near them yawns. 50 people were randomly
# assigned to two groups: 34 to a group where a person near them yawned
# (treatment) and 16 to a group where there wasn't a person yawning near them
# (control). The following table shows the results of this experiment.
#
# Contingency table:
#                         --------------------------
#                         Control  Treatment  Total
#          ---------------------------------------
#               Yawn         10       4        14
#  Result       Not Yawn     24       12       36
#          ---------------------------------------
#                Total       34       16       50
#          ---------------------------------------
#
# A simulation was conducted to understand the distribution of the test
# statistic under the assumption of independence: having someone yawn near
# another person has no influence on if the other person will yawn. In order to
# conduct the simulation, a researcher wrote yawn on 14 index cards and not yawn
# on 36 index cards to indicate whether or not a person yawned. Then he shuffled
# the cards and dealt them into two groups of size 34 and 16 for treatment and
# control, respectively. He counted how many participants in each simulated
# group yawned in an apparent response to a nearby yawning person, and
# calculated the difference between the simulated proportions of yawning as
# ˆptrtmt,sim − pˆctrl,sim. This simulation was repeated 10,000 times using
# software to obtain 10,000 differences that are due to chance alone. The
# histogram shows the distribution of the simulated differences.
#
# (a) What are the hypotheses?
#-> The null hypothesis is that having a person yawn nearby  does not affect that person's probability of yawning (treatment = control)
#-> The alternative Hypothesis  is that a person yawning nearby increases your probability of yawning (treatment>control)
# (b) Calculate the observed difference between the yawning rates under the
#     two scenarios.
difference <- 4/16 -10/34
difference 
# (c) Estimate the p-value using the figure and determine the conclusion of
#     the hypothesis test.
#-> the observed difference is -0.04411765 and this is definitely atround zero which is centered around the 0, the center of the graph 
# This means that the experiment does not have enough evidence to prove that there is no convincing evidence that haveing 
# a person yawn nearby does not ffect their yawnin gprobability 
####################################################################################
# IST Exercise 9.2 
# In Chapter 13 we will present a statistical test for testing
# if there is a difference between the patients that received the active magnets
# and the patients that received the inactive placebo in terms of the expected
# value of the variable that measures the change. The test statist for this
# problem is taken to be
#  T = (X_bar_1 - X_bar_2) / sqrt(S_1^2/29 + S_2^2/21)
#
# where X_bar_1 and X_bar_2 are the sample averages for the 29 patients that 
# receive active magnets and for the 21 patients that receive inactive placebo, 
# respectively. The quantities S_1^2 and S_^2 are the sample variances for each
# of the two samples. Our goal is to investigate the sampling distribution 
# of this statistic in a case where both expectations are equal to each other 
# and to compare this distribution to the observed value of the statistic.
#
# 1. Assume that the expectation of the measurement is equal to 3.5, regardless
#    of what the type of treatment that the patient received. We take the
#    standard deviation of the measurement for patients the receives an active
#    magnet to be equal to 3 and for those that received the inactive placebo we
#    take it to be equal to 1.5. Assume that the distribution of the
#    measurements is Normal and there are 29 patients in the first group and 21
#    in the second. Find the interval that contains 95% of the sampling
#    distribution of the statistic.
magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")
head(magnets)
X.bar1 <- rep(0,10^5)
X.bar2 <- rep(0,10^5)
for(i in 1:10^5)
{
X1 <-  rnorm(29,3.5,3)
X2 <-  rnorm(21,3.5,1.5)
X.bar1[i] <-  mean(X1)
X.bar2[i] <-  mean(X2)
T[i] <- (X.bar1[i] - X.bar2[i])/(sqrt((var(X1)/29)+(var(X2)/21)))
}
quantile(T,c(0.025,0.975))
#-2.012591  2.022862 
# 2. Does the observed value of T (computed from the "magnets" data) fall
#    inside or outside the interval computed in 1?
activerows <- magnets[1:29, ]
activerows
activeavg <- mean(activerows$change)
activeavg
inacvtiverows <- magnets[30:50, ]
inacvtiverows 
inactiveavg <-mean(inacvtiverows$change)
inactiveavg

T <- (activeavg-inactiveavg)/sqrt(
    var(activerows$change)/29+
    var(inacvtiverows$change)/21)
T
 5.985601 
#does not belong in interval -2.012591  2.022862 