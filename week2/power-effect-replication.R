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
 # Null hypothesis: E(X) = 0
 # Alternative hypothesis: E(X) != 0

# 2. Identify the observations that can be used in order to test the hypotheses.
magnets$change[30:50]

# 3. Carry out the test and report your conclusion. (Use a significance level of
#    5%.)
 t.test(magnets$change[30:50], sig.level=0.05)
 # p-value = 0.004702 < 0.05
 # Therefore, we reject the null hypothesis, 
 # meaning that a "placebo effect" seems to be present.

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
 
 # magnets$score1 --> the scores of pain before a device is applied
 # ~ --> score1 as a function of active group
 # magnets$active --> factor indicating which level each pain belongs to
 t.test(magnets$score1 ~ magnets$active, sig.level=0.05)
 # p-value = 0.6806 > 0.05
 # Therefore, we can't reject the null hypothesis that the expectations
 # in the two groups are equal. There's no significant difference between the treatment
 # and the control groups.

# 2. Is there a significance difference between the treatment and the control
#    groups in the variance of the reported score of pain before the application
#    of the device?
 var.test(magnets$score1 ~ magnets$active, sig.level=0.05)
 # p-value = 0.3687 > 0.05
 # Therefore, we can't reject the null hypothesis that the variances
 # in the two groups are equal. There's no significant difference between the treatment
 # and the control groups in the variance of the reported score of pain.

# 3. Is there a significance difference between the treatment and the control
#    groups in the expectation of the change in score that resulted from the
#    application of the device?
 t.test(magnets$change ~ magnets$active, sig.level=0.05)
 # p-value = 3.86e-07 < 0.05
 # Therefore, we reject the null hypothesis that the expectation of the change
 # in the two groups are equal. 
 # There's a significant difference between the treatment and the control groups.
 # According to this, magnets have an effect on the expectation of the response 

# 4. Is there a significance difference between the treatment and the control
#    groups in the variance of the change in score that resulted from the application of the device?
 var.test(magnets$change ~ magnets$active, sig.level=0.05)
 # p-value = 0.001535 < 0.05
 # Therefore, we reject the null hypothesis that the variances in the two groups are equal. 
 # There's a significant difference between the treatment and the control groups 
 # in the variance of the reported score of pain.
 # According to this, magnets also have an effect on the variance of the response 
