library(tidyverse)

####################################################################################
# IST Chapter 9, Exercise 9.1
magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")

# 1. What is the sample average of the change in score between the
#    patient's rating before the application of the device and the
#    rating after the application?

mean(magnets$change)#3.5

# 2. Is the variable "active" a factor or a numeric variable?

summary(magnets)
str(magnets)
# No it is not a factor, it is a character variable 

# 3. Compute the average value of the variable "change" for the patients that
#    received an active magnet and average value for those that received an
#    inactive placebo. (Hint: Notice that the first 29 patients received an
#    active magnet and the last 21 patients received an inactive placebo. The
#    subsequence of the first 29 values can be obtained via "change[1:29]" and
#    the last 21 values via "change[30:50]".)

magnets%>%group_by(active)%>%summarize(mean(change))

# 4. Compute the sample standard deviation of the variable "change" for the
#    patients that received an active magnet and the sample standard deviation
#    for those that received an inactive placebo.

magnets%>%group_by(active)%>%summarize(sd(change))

# 5. Produce a boxplot of the variable "change" for the patients that received
#    an active magnet and for patients that received an inactive placebo. What
#    is the number of outliers in each subsequence?

boxplot(magnets$change[1:29])
boxplot(magnets$change[30:50])
#3 out liers in placebo

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

size <- 100
std <- 2
mu <- 3
N <- 10^5
mean_stat <- rep(0,N)
median_stat <- rep(0,N)
for (n in 1:N){
    X <- rnorm(size,mu,std)
    mean_stat[n] <- mean(X)
    median_stat[n] <- median(X)
}
mean(mean_stat)
mean(median_stat)
var(mean_stat)
var(median_stat)
#since var(median_stat) > var(mean_stat) so mean has smaller mean squared error

# 2. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Uniform(0.5, 5.5) distribution. Compute the
#    expectation and the variance of the sample average and of the sample
#    median. Which of the two estimators has a smaller mean square error?

size <- 100
max <- 5.5
min <- 0.5
N <- 10^5
mean_stat_uni <- rep(0,N)
median_stat_uni <- rep(0,N)
for (n in 1:N){
    X <- runif(size,min,max)
    mean_stat_uni[n] <- mean(X)
    median_stat_uni[n] <- median(X)
}
mean(mean_stat_uni)
mean(median_stat_uni)
var(mean_stat_uni)
var(median_stat_uni)
# agian we arrive similar conclusion as above mean sample has minimun mean squared error

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

ex2%>%group_by(group)%>%summarize(count = n())%>%mutate(count/150)# 0.247
# 2. Compute the proportion in the population of those with a high level of
#    blood pressure.

mean(pop2$group == "HIGH") #0.28126
# 3. Simulate the sampling distribution of the sample proportion and compute
#    its expectation.

expected_val <-replicate(1e5,mean(sample(pop2$group,150)=="HIGH"))
mean(expected_val) #0.281216
ggplot(data.frame(expected_val),aes(x = expected_val))+
geom_histogram()+
geom_vline(xintercept=mean(expected_val))

# 4. Compute the variance of the sample proportion.

var(expected_val) # 0.001334978

# 5. It is proposed in Section 10.5 that the variance of the sample proportion
#    is Var(P_hat) = p(1 - p)/n, where p is the probability of the event (having
#    a high blood pressure in our case) and n is the sample size (n = 150 in our
#    case). Examine this proposal in the current setting.

p<-mean(expected_val)
(p-p^2)/150
var(expected_val)

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

#Control : 30/34 , # Treatment : 45/69

# (b) One approach for investigating whether or not the treatment is effective
#     is to use a randomization technique.
#     i. What are the claims being tested? Use the same null and alternative
#          hypothesis notation used in the section.

#H_0 : Null hypthesis: Heart transplant treatment is not effective 
#H_A : Alternate hypothesis: Heart transplant treatment is effective

#     ii. The paragraph below describes the set up for such approach, if we were
#     to do it without using statistical software. Fill in the blanks with a
#     number or phrase, whichever is appropriate. 
#          We write alive on ___28____ cards representing patients who were
#          alive at the end of the study, and dead on ___75___ cards representing
#          patients who were not. Then, we shuffle these cards and split them
#          into two groups: one group of size ___69____ representing treatment, and
#          another group of size _____34____ representing control. We calculate the
#          difference between the proportion of dead cards in the treatment and
#          control groups (treatment - control) and record this value. We repeat
#          this many times to build a distribution centered at ____0____. Lastly, we
#          calculate the fraction of simulations where the simulated differences
#          in proportions are _____-0.230179____. If this fraction is low, we conclude that it is
#          unlikely to have observed such an outcome by chance and that the null
#          hypothesis should be rejected in favor of the alternative.
#     iii. What do the simulation results suggest about the effectiveness of
#          the transplant program? (See textbook for figure.)

# -0.230179 falls at extreme left tail of the distribution, where almost zero data points lie so
# this simulation provides strong evidence for alternate hypothesis that is heart transplant treatment is effective

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
#                         Treatment  Control  Total
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

#H_0: Null hypothesis: There is no influence on another person, that is they are independent.
#H_A: Alternate hypothesis : There is influence of another person in yawning, that is they are dependent.

# (b) Calculate the observed difference between the yawning rates under the
#     two scenarios.

#(10/34-4/16)= 0.04412

# (c) Estimate the p-value using the figure and determine the conclusion of
#     the hypothesis test.

# 0.04412 falls very close to the zero in distribution so its p-value is well above 40-45 % so we have 
# the conclusion that we can't reject Null hypothesis.

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

m = 3.5
std1 <- 3
std2 <- 1.5
N <- 10^5
test_stat <- rep(0,N)
for (n in 1:N){
    X1 <- rnorm(29,m,std1)
    X1_mean <- mean(X1)
    X1_var <- var(X1)
    X2 <- rnorm(21,m,std2)
    X2_mean <- mean(X2)
    X2_var <- var(X2)
    test_stat[n] <- (X1_mean-X2_mean)/sqrt((X1_var)/29+(X2_var)/21)
}
quantile(test_stat,c(0.025,0.975))#-2.003993 , 1.996529


# 2. Does the observed value of T (computed from the "magnets" data) fall
#    inside or outside the interval computed in 1?

X1_m <- mean(magnets$change[1:29])
X2_m <- mean(magnets$change[30:50])
X1_v <- var(magnets$change[1:29])
X2_v <- var(magnets$change[30:50])
T <- (X1_m-X2_m)/sqrt((X1_v/29)+(X2_v/21))
T
# 5.986 is the observed value of T which falls outside the interval computed in 1 (-2.003993 , 1.996529)