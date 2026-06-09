library(tidyverse)
library(ggplot2)
library(dplyr)

# 1. Coffee and cancer
# Note: This is taken from a discussion by David Spiegelhalter.
# In March of 2018 there was a court case in California that hinged on whether 
# a chemical called acrylamide found in coffee causes cancer. The judge asked 
# the defendants to show that coffee was "safe" in that drinking coffee caused 
# fewer than 1 in 100,000 extra cases of cancer. The defendants were unable to
# demonstrate this. As a result, companies selling coffee in California must now
# display a cancer warning alongside it. Imagine you were the defendants and
# wanted to set up a randomized experiment to demonstrate that coffee is indeed 
# "safe" and causes fewer than 1 in 100,000 extra cases of cancer. Assuming the
# lifetime risk of getting cancer is 40%, this means that your experiment would 
# have to tell the difference between 40,000 out of 100,000 non-coffee drinkers 
# getting cancer versus 40,001 out of 100,000 coffee drinkers getting cancer.

# a) Assuming you could actually pull of such an experiment, how many participants 
# would you need to reject the null hypothesis that fewer than 1 in 100,000 extra 
# cases of cancer occur among people assigned to drink coffee?
# For the sake of the calculation assume you'd like to have the following long-run 
# error rates. If coffee is indeed "safe", you'd like your test to falsely return 
# "unsafe" at most 1 in 10 times. If, however, coffee is "unsafe", you'd like your 
# test to detect this effect 4 out of 5 times.
# You can use one of R's built-in power functions to calculate an answer.
power.prop.test(n=NULL, p1 = .4, p2 = .40001, sig.level = 0.1, power = .8,
                alternative = "one.sided")
# n = 21637831282
# b) Comment on challenges you might face in running this experiment.
# Since we are trying to detect a teeny difference, we would need a sample size of 
# 21637831282 - many more than the amount of people we have in the world today. 
# Even if that would be discovered, it could be due to a confounding variable - 
# something else that differentiates coffee-drinkers and non-coffee-drinkers, but
# the sample size issue is problematic enough alone that it would not enable this 
# to be tested properly. 