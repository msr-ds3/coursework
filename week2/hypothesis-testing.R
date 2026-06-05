library(tidyverse)

####################################################################################
# IST Chapter 9, Exercise 9.1
magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")

# 1. What is the sample average of the change in score between the
#    patient's rating before the application of the device and the
#    rating after the application?
summary(magnets)
 # "change" is the one that contains the difference between the patient's rating 
 # before the application of the device and the rating after the application.
 # The sample average of the change is: Mean = 3.5

# 2. Is the variable "active" a factor or a numeric variable?
 # The variable "active" is a factor. We can see that the levels are 
 # coded with numbers but between double quotes.

# 3. Compute the average value of the variable "change" for the patients that
#    received an active magnet and average value for those that received an
#    inactive placebo. (Hint: Notice that the first 29 patients received an
#    active magnet and the last 21 patients received an inactive placebo. The
#    subsequence of the first 29 values can be obtained via "change[1:29]" and
#    the last 21 values via "change[30:50]".)
mean(magnets$change[1:29])
 # Average value of "change" for the patients that
 # received an active magnet is 5.241379

mean(magnets$change[30:50])
 # Average value of "change" for the patients that
 # received an inactive placebo is 1.095238

# 4. Compute the sample standard deviation of the variable "change" for the
#    patients that received an active magnet and the sample standard deviation
#    for those that received an inactive placebo.
sd(magnets$change[1:29])
 # Standard deviation of "change" for the patients that
 # received an inactive placebo is 3.236568

sd(magnets$change[30:50])
 # Standard deviation of "change" for the patients that
 # received an inactive placebo is 1.578124
 

# 5. Produce a boxplot of the variable "change" for the patients that received
#    an active magnet and for patients that received an inactive placebo. What
#    is the number of outliers in each subsequence?
boxplot(magnets$change[1:29])
 # Based on this plot, there's no outliers

boxplot(magnets$change[30:50])
 # Based on this plot, the values 3, 4, and 5 are associated with outliers
table(magnets$change[30:50])
 # 1 outlier is associated with the number 3 
 # 2 outliers with the number 4 and
 # 1 outlier with the number 5
 # Then there's a total of 4 outliers on this plot

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
X.bar <- rep(0, 1e5)
X.med <- rep(0,1e5)
for (i in 1:1e5) {
   sample_dist <- rnorm(100, 3, sqrt(2))
   X.bar[i] <- mean(sample_dist)
   X.med[i] <- median(sample_dist)
}
 # The expectation of the sample average
 mean(X.bar) # 2.999551
 # The expectation of the sample median
 mean(X.med) # 2.999686

 # The variance of the sample average
 var(X.bar) # 0.01993027
 # The variance of the sample median
 var(X.med) # 0.03081534

 # We note that the variance of the sample average is almost equal to
 # 0.02 and the variance of the sample median is almost equal to 0.031.
 # These 2 numbers represent the mean square errors of the the estimators.
 # Therefore, the sample average has a smaller mean square error.

#
# 2. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Uniform(0.5, 5.5) distribution. Compute the
#    expectation and the variance of the sample average and of the sample
#    median. Which of the two estimators has a smaller mean square error?
X.bar <- rep(0, 1e5)
X.med <- rep(0,1e5)
for (i in 1:1e5) {
   sample_dist <- runif(100, 0.5, 5.5)
   X.bar[i] <- mean(sample_dist)
   X.med[i] <- median(sample_dist)
}
 # The expectation of the sample average
 mean(X.bar) # 3.000136
 # The expectation of the sample median
 mean(X.med) # 3.000006

 # The variance of the sample average
 var(X.bar) # 0.02074843
 # The variance of the sample median
 var(X.med) # 0.06028367

 # We can see that the sample average has a smaller mean square error.


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
mean(ex2$group == "HIGH") # 0.2466667

# 2. Compute the proportion in the population of those with a high level of
#    blood pressure.
mean(pop2$group == "HIGH") # 0.28126

# 3. Simulate the sampling distribution of the sample proportion and compute
#    its expectation.
P.hat <- rep(0, 100000)
for(i in 1:10^5) {
    X <- sample(pop2$group,150)
    P.hat[i] <- mean(X == "HIGH")
}

# The expected value is: 
mean(P.hat) # 0.2813492

# 4. Compute the variance of the sample proportion.
var(P.hat) # 0.001338008

# 5. It is proposed in Section 10.5 that the variance of the sample proportion
#    is Var(P_hat) = p(1 - p)/n, where p is the probability of the event (having
#    a high blood pressure in our case) and n is the sample size (n = 150 in our
#    case). Examine this proposal in the current setting.
p <- mean(pop2$group == "HIGH")
p* (1 - p) /150
 # 0.001347685
 # We see that the proposed variance in section 10.5 is 0.001347685
 # which is quite good with the value 0.001338008 that was obtained in 
 # the simulation.


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
 # Proportion of death patients in the treatment group:
 Pt = 45/69
 # Proportion of death patients in the control group:
 Pc = 30/34

# (b) One approach for investigating whether or not the treatment is effective
#     is to use a randomization technique.
#     i. What are the claims being tested? Use the same null and alternative
#          hypothesis notation used in the section.
 # Let 
 # Pt: true proportion of deaths for treatment patients
 # Pc: true proportion of deaths for control patients
 # Null hypothesis --> no treatment effect: Pt = Pc
 # Alternative hypothesis --> the transplant reduces the death rate: Pt < Pc

#     ii. The paragraph below describes the set up for such approach, if we were
#     to do it without using statistical software. Fill in the blanks with a
#     number or phrase, whichever is appropriate. 
#          We write alive on 28 cards representing patients who were
#          alive at the end of the study, and dead on 75 cards representing
#          patients who were not. Then, we shuffle these cards and split them
#          into two groups: one group of size 69 representing treatment, and
#          another group of size 34 representing control. We calculate the
#          difference between the proportion of dead cards in the treatment and
#          control groups (treatment - control) and record this value. We repeat
#          this many times to build a distribution centered at 0. Lastly, we
#          calculate the fraction of simulations where the simulated differences
#          in proportions are <= -0.23 . If this fraction is low, we conclude that it is
#          unlikely to have observed such an outcome by chance and that the null
#          hypothesis should be rejected in favor of the alternative.
#     iii. What do the simulation results suggest about the effectiveness of
#          the transplant program? (See textbook for figure.)
    # The observed difference is -0.23 
    # Based on the plot, (-0.23) lies in the far left side, with
    # very few simulated outcomes as extreme. 
    # -0.23 < 0.05 --> reject the null hypothese. There's a strong evidence that the 
    # transplant reduces the death rate and improves survival.


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
 # We want to know whether having someone yawn nearby increases 
 # the chance that a person yawns. Let
 # ˆptrtmt: true yawning rate when a yawner is nearby
 # pˆctrl: true yawning rate when no yawner is nearby
 # Null hypothesis --> there's no association: ˆptrtmt = pˆctrl
 # Alternative hypothesis --> yawning is contagious: ˆptrtmt > pˆctrl


# (b) Calculate the observed difference between the yawning rates under the
#     two scenarios.
 # Treatment yawning rate:
 # ˆptrtmt = 10/34
 # Control yawning rate:
 # pˆctrl = 4/16
 # Difference between the yawning rates under the scenarios:
 # ˆptrtmt - pˆctrl = 0.044 

# (c) Estimate the p-value using the figure and determine the conclusion of
#     the hypothesis test.
 # The observed value 0.044 is very close to 0 and lies near the center of the distribution
 # Based on the alternative hypothesis, the p-value is the proportion with 
 # ptrtmt - pˆctrl >= 0.044 
 # Based on the histogram, almost half of tge values are >0, and since 
 # 0.044 is only slightly above 0, a large fraction of simulations are at least this large
 # We can then estimate that p-value is around 0.4
 # p-value > 0.05 --> can't reject the null hypothesis
 # We are not convinced that having someone yawn nearby increases the likelihood of yawning


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
test.stat <- rep(0,10^5)
for(i in 1:100000) {
    X1 <- rnorm(29,3.5,3)
    X2 <- rnorm(21,3.5,1.5)
    X1.bar <- mean(X1)
    X2.bar <- mean(X2)
    X1.var <- var(X1)
    X2.var <- var(X2)
    test.stat[i] <- (X1.bar-X2.bar)/sqrt(X1.var/29 + X2.var/21)
}
quantile(test.stat, c(0.025, 0.975))
# The interval that contains 95% of the sampling 
# distribution of the statistic is [-2.015342, 2.024001 ]

# 2. Does the observed value of T (computed from the "magnets" data) fall
#    inside or outside the interval computed in 1?
x1.bar <- mean(magnets$change[1:29])
x2.bar <- mean(magnets$change[30:50])
x1.var <- var(magnets$change[1:29])
x2.var <- var(magnets$change[30:50])
(x1.bar-x2.bar)/sqrt(x1.var/29 + x2.var/21)
 # 5.985601 doesn't belong to [-2.015342, 2.024001 ]
 # It's outside the interval computed in 1.
