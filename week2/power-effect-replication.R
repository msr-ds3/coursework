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
# H0: E(X) = 0
# HA: E(X) > 0
# 2. Identify the observations that can be used in order to test the hypotheses.
# Survey a group of people on their pain level. Then, 'treat' them with the placebo
# and survey their pain level. The observations that can be used is the difference
# between the original pain level and after the 'treatment'.
# 3. Carry out the test and report your conclusion. (Use a significance level of
#    5%.)
magnets[30:50, 3] %>% t.test(alternative="greater", mu = 0, conf.level = .95)
# The p-value is 0.002351, meaning there is a .2351% chance that the null is true and 
# we got these results or more extreme. That is less than our 5% alpha cutoff. Therefore,
# we reject the null hypothesis, concluding that the placebo effect is present, causing 
# people 'treated' by the placebo to report experiencing lower pain after 'treatment'.
####################################################################################
# IST Chapter 13, Exercise 13.1

magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")
#  In this exercise we would like to analyze the results of the
# trial that involves magnets as a treatment for pain. The trial is described in
# Question 9.1. The results of the trial are provided in the file “magnets.csv”

# Patients in this trial where randomly assigned to a treatment or to a control.
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
t.test(x=slice(magnets, 1:29)$score1, y=slice(magnets, 30:50)$score1, alternative="two.sided", mu = 0, conf.level = .95)
# Not necessarily. We fail to reject the null hypothesis because our p-calue is 0.68 - much greater than our .05 alpha value.
# 2. Is there a significance difference between the treatment and the control
#    groups in the variance of the reported score of pain before the application
#    of the device?
var.test(x=slice(magnets, 1:29)$score1, y=slice(magnets, 30:50)$score1, ratio=1, alternative="two.sided", conf.level = .95)
# The p-value = 0.3687, which is greater than our alpha cutoff of .05. Therefore, we fail to reject our null hypothesis and 
# conclude that there does not seem to be a significant difference between the variances of the two groups.
# 3. Is there a significance difference between the treatment and the control
#    groups in the expectation of the change in score that resulted from the
#    application of the device?
t.test(x=slice(magnets, 1:29)$score2, y=slice(magnets, 30:50)$score2, alternative="two.sided", mu = 0, conf.level = .95)
# Yes, there does seem to be a significant difference between the expected second scores for the two groups. 
# The p-value is 8.058e-07, which is significantly lower than our alpha value of .05. Therefore, we reject the null hypothesis.
# 4. Is there a significance difference between the treatment and the control
#    groups in the variance of the change in score that resulted from the application of the device?
var.test(x=slice(magnets, 1:29)$score2, y=slice(magnets, 30:50)$score2, ratio=1, alternative="two.sided", conf.level = .95)
# Yes, there does seem to be a significant difference between the variances of the second scores for the two groups. 
# The p-value is 0.01779, which is  lower than our alpha value of .05. Therefore, we reject the null hypothesis.
