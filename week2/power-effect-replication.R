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
#   The null hypothesis is when the E[x], the expected change in th pain score is 0 
#   when the placebo is used and then the alternative hypothesis is when the E[X]  the expected change in th pain score is 0 
# 2. Identify the observations that can be used in order to test the hypotheses.
#    The observation used can be the pain score change provided for the placebo group 
# 3. Carry out the test and report your conclusion. (Use a significance level of
#    5%.)
placebo <- magnets[30:50, ] %>% select(change)
placebo
t.test(placebo,mu=0)
# the p-value = 0.004702 this is less than 0.05 this means that the null hypothesis is rejected proving that 
# the expected change in painscore when the placebo is taken is due to chance
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
t.test(magnets$score1 ~ magnets$active )
#  The pvalue is 0.6806 so therefore there is no significance between the treatment and the control 
# 2. Is there a significance difference between the treatment and the control
#    groups in the variance of the reported score of pain before the application
#    of the device?
var.test(magnets$score1 ~ magnets$active )
#  The p value is 0.3 which means that there is also no significance between the treatemt and the control 
# 3. Is there a significance difference between the treatment and the control
#    groups in the expectation of the change in score that resulted from the
#    application of the device?
t.test(magnets$change ~ magnets$active )
#  The p value is 3.86e-07 (< 0.05) which means that there is a significance between the treatemt and the control 
# 4. Is there a significance difference between the treatment and the control
#    groups in the variance of the change in score that resulted from the application of the device?
var.test(magnets$change ~ magnets$active )
# The p value is  0.001535 (<0.05) which means that there is a significance between the treatemt and the control  9