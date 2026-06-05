library(tidyverse)

####################################################################################
# IST Chapter 12, Exercise 12.1
magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")

#  Consider a medical condition that does not have a standard
# treatment. The recommended design of a clinical trial for a new treatment
# to such condition involves using a placebo treatment as a control. A placebo
# treatment is a treatment that externally looks identical to the actual treatment
# but, in reality, it does not have the active ingredients. The reason for using
# placebo for control is the “placebo effect”. Patients tent to react to the fact that
# they are being treated regardless of the actual beneficial effect of the treatment

# As an example, consider the trial for testing magnets as a treatment for pain
# that was described in Question 9.1. The patients that where randomly assigned
# to the control (the last 21 observations in the file “magnets.csv”) were treated
# with devises that looked like magnets but actually were not. The goal in this
# exercise is to test for the presence of a placebo effect in the case study “Magnets
# and Pain Relief” of Question 9.1 using the data in the file “magnets.csv”.


# 1. Let X be the measurement of change, the difference between the score of
#   pain before the treatment and the score after the treatment, for patients
#   that were treated with the inactive placebo. Express, in terms of the
#   expected value of X, the null hypothesis and the alternative hypothesis
#   for a statistical test to determine the presence of a placebo effect. The null
#   hypothesis should reflect the situation that the placebo effect is absent

# Null hypothesis: There is no effect so E(X) = 0.
# Alternative hypothesis: There is a statistically significant effect, so E(X) =/= 0. 

# 2. Identify the observations that can be used in order to test the hypotheses.

# From the patients who received the placebo, measure the mean change (X) between the patients and see where that falls in the null distribution.

# 3. Carry out the test and report your conclusion. (Use a significance level of
#    5%.)

# mean of the null distribution is 0
# by central limit theorem, we can simulate a normal distribution of X

n <- 21
mu <- 0
# calculate sd
sd <- magnets %>%
    filter(grepl("2", active)) %>%
    select(change) %>%
    summarize(sd=sd(change)) %>%
    pull()

null_distribution <- replicate(1e4, mean(rnorm(n, mu, sd))) # our null distribution

# now calculate the actual effect

actual_test_mean_X <- magnets %>%
    filter(grepl("2", active)) %>%
    select(change) %>%
    summarize(mean=mean(change)) %>%
    pull()

# plot to find the p-value
ggplot(data.frame(null_distribution), aes(x=null_distribution)) +
    geom_histogram(bins=20) +
    geom_vline(xintercept=actual_test_mean_X, color="red")

# generate the p-value
p_value <- mean(abs(null_distribution) >= abs(actual_test_mean_X))
p_value

# Conclusions:
# the number is 0.001, which is less than 0.05, meaning that we can reject the null hypothesis and state that this placebo effect is statistically significant


# --
# another way is by conducting a t-test
placebo <- magnets %>%
    filter(grepl("2", active)) %>%
    pull(change)

t.test(placebo, mu=mu)

#        One Sample t-test

# data:  placebo
# t = 3.1804, df = 20, p-value = 0.004702
# alternative hypothesis: true mean is not equal to 0
# 95 percent confidence interval:
#  0.3768845 1.8135916
# sample estimates:
# mean of x 
#  1.095238 

# Conclusions:
# again, reject the null hypothesis since the p-value 0.004702 < 0.05
# There is a real placebo effect

####################################################################################
# IST Chapter 13, Exercise 13.1

magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")
#  In this exercise we would like to analyze the results of the
# trial that involves magnets as a treatment for pain. The trial is described in
# Question 9.1. The results of the trial are provided in the file “magnets.csv”

# Patients in this trail where randomly assigned to a treatment or to a control.
# The responses relevant for this analysis are either the variable “change”, which
# measures the difference in the score of pain reported by the patients before and
# after the treatment, or the variable “score1”, which measures the score of pain
# before a device is applied. The explanatory variable is the factor “active”.
# This factor has two levels, level “1” to indicate the application of an active
# magnet and level “2” to indicate the application of an inactive placebo.

# In the following questions you are required to carry out tests of hypotheses.
# All tests should conducted at the 5% significance level:
# 1. Is there a significance difference between the treatment and the control
#    groups in the expectation of the reported score of pain before the application of the device?

# Perform a test to determine this
# Suppose X = E(score1 | treatment) - E(score1 | control)

# Null Hypothesis(H0): There is no significant difference, so X = 0
# Alternate Hypothesis(H1): There is a significant difference, so X =/= 0

# Perform a t-test
t.test(score1 ~ active, data = magnets)

# Welch Two Sample t-test

# data:  score1 by active
# t = 0.41483, df = 38.273, p-value = 0.6806
# alternative hypothesis: true difference in means between group "1" and group "2" is not equal to 0
# 95 percent confidence interval:
#  -0.3757896  0.5695498
# sample estimates:
# mean in group "1" mean in group "2" 
#           9.62069           9.52381 

# Conclusions:
# Since the p-value is 0.6806, this is much higher than the significance level of 0.05
# Therefore we fail to reject the null hypothesis - the difference is not statistically significant

# 2. Is there a significance difference between the treatment and the control
#    groups in the variance of the reported score of pain before the application
#    of the device?

# Suppose X = var(score1 | treatment) / var(score2 | control)
# Null Hypothesis(H0): X = 1
# Alternative Hypothesis(H1): X =/= 1

var.test(score1 ~ active, data = magnets)

# F test to compare two variances

# data:  score1 by active
# F = 0.69504, num df = 28, denom df = 20, p-value = 0.3687
# alternative hypothesis: true ratio of variances is not equal to 1
# 95 percent confidence interval:
#  0.2938038 1.5516218
# sample estimates:
# ratio of variances 
#          0.6950431 

# Conclusions: 
# The p-value is 0.3687, which is significantly larger than the significance level
# Therefore we fail to reject the null hypothesis - the difference in variance is not statistically significant


# 3. Is there a significance difference between the treatment and the control
#    groups in the expectation of the change in score that resulted from the
#    application of the device?

# Suppose X = E(change | treatment) - E(change | control)

# Null Hypothesis(H0): X is 0
# Alternative Hypothesis(H1): X is not 0

t.test(change ~ active, data = magnets)

#         Welch Two Sample t-test

# data:  change by active
# t = 5.9856, df = 42.926, p-value = 3.86e-07
# alternative hypothesis: true difference in means between group "1" and group "2" is not equal to 0
# 95 percent confidence interval:
#  2.749137 5.543145
# sample estimates:
# mean in group "1" mean in group "2" 
#          5.241379          1.095238 

# Conclusions: 
# The p-value is incredibly small this time, at 3.86e-07 which is way smaller than 0.05
# Therefore the difference between expectation of change in in score between the two groups is statistically significant


# 4. Is there a significance difference between the treatment and the control
#    groups in the variance of the change in score that resulted from the application of the device?

# Suppose X = var(change | treatment) / var(change | control)

# Null Hypothesis(H0): X = 1
# Alternative Hypothesis(H1): X =/= 1

var.test(change ~ active, data = magnets)
#         F test to compare two variances

# data:  change by active
# F = 4.2062, num df = 28, denom df = 20, p-value = 0.001535
# alternative hypothesis: true ratio of variances is not equal to 1
# 95 percent confidence interval:
#  1.778003 9.389902
# sample estimates:
# ratio of variances 
#           4.206171 

# Conclusions:
# The p-value is 0.001535 which is smaller than 0.05
# Therefore, the difference in variance in change between the two groups is statistically significant