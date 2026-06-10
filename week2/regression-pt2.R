#################################################################################
# Reproduce this table in ISRS 5.29 using the original dataset in body.dat.txt
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000
body <- read.table("body.dat.txt", header = FALSE)
lm.fit <- lm(V23 ~ V24, data = body)
summary(lm.fit)

###################################################################################
# ISRS Exercise 6.1
#  The Child Health and Development Studies investigate a range of
# topics. One study considered all pregnancies between 1960 and 1967 among women in the Kaiser
# Foundation Health Plan in the San Francisco East Bay area. Here, we study the relationship
# between smoking and weight of the baby. The variable smoke is coded 1 if the mother is a
# smoker, and 0 if not. The summary table below shows the results of a linear regression model for
# predicting the average birth weight of babies, measured in ounces, based on the smoking status of
# the mother.
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)    123.05        0.65   189.60    0.0000
# smoke           -8.94        1.03    -8.65    0.0000

# The variability within the smokers and non-smokers are about equal and the distributions are
# symmetric. With these conditions satisfied, it is reasonable to apply the model. (Note that we
# don’t need to check linearity since the predictor has only two levels.)
babyweights <- read.table("babyweights.txt", header = FALSE)
lm.fit <- lm(bwt ~ smoke, data = babyweights)
summary(lm.fit)


# a. Write the equation of the regression line.
# y = 123.05 - .8.94x

# b. Interpret the slope in this context, and calculate the predicted birth weight of babies born to
# smoker and non-smoker mothers.
# In this context, slope or -8.94 means if a mother is a smoker, the baby's weight will be 8.94 oz less.
# Smoker mother: 114.11
# Non-smoker mother: 123.05

# c. Is there a statistically significant relationship between the average birth weight and smoking?
# The p-value is 0, it seems like there is a statistically significant relationship between birth weight and smoking.
# We reject the null hypothesis.

###################################################################################
# ISRS Exercise 6.2
# Exercise 6.1 introduces a data set on birth weight of babies.
#Another variable we consider is parity, which is 0 if the child is the first born, and 1 otherwise.
#The summary table below shows the results of a linear regression model for predicting the average
# birth weight of babies, measured in ounces, from parity
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)    120.07        0.60   199.94    0.0000
# parity          -1.93        1.19    -1.62    0.1052
#
lm.fit <- lm(bwt ~ parity, data = babyweights)
summary(lm.fit)

# a. Write the equation of the regression line.
#  y = 120.07 - 1.93x

# b. Interpret the slope in this context, and calculate the predicted birth weight of first borns and
#    others.
# Here, the slope indicates that if the child is not the first born, their birth weight will be 1.93 less.
# First-born: 120.07
# Others: 118.14

# c. Is there a statistically significant relationship between the average birth weight and parity?
# The p-value is 0.1052. I would say there isn't a statistically significant relationship. 
# We fail to reject the null hypothesis. 

###################################################################################
# ISRS Exercise 6.3
# We considered the variables smoke and parity, one at a time, in
# modeling birth weights of babies in Exercises 6.1 and 6.2. A more realistic approach to modeling
# infant weights is to consider all possibly related variables at once. Other variables of interest
# include length of pregnancy in days (gestation), mother’s age in years (age), mother’s height in
# inches (height), and mother’s pregnancy weight in pounds (weight). Below are three observations
# from this data set.

# Data set observations (n = 1,236):
#        bwt  gestation  parity  age  height  weight  smoke
# 1      120        284       0   27      62     100      0
# 2      113        282       0   33      64     135      0
# ...
# 1236   117        297       0   38      65     129      0

# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)    -80.41       14.35    -5.60    0.0000
# gestation        0.44        0.03    15.26    0.0000
# parity          -3.33        1.13    -2.95    0.0033
# age             -0.01        0.09    -0.10    0.9170
# height           1.15        0.21     5.63    0.0000
# weight           0.05        0.03     1.99    0.0471
# smoke           -8.40        0.95    -8.81    0.0000
#
lm.fit <- lm(bwt ~ gestation + parity + age + height + weight + smoke, data = babyweights)
summary(lm.fit)

# a. Write the equation of the regression line that includes all variables:
# y = b + m1(gestation) + m2(parity) + m3(age) + m4(height) + m5(smoke) 
# y = (0.44)gestation + (-3.33)parity + (-0.01)age + (1.15)height + (0.05)weight + (-8.40)smoke

# b. Interpret the slopes of gestation and age in this context:
# Slope of gestation: this indicates that for each day longer of pregnancy, the weight of the baby increase
# by 0.44 oz.
# slope of age: this indicates that for every increase of a year for a mother, the weight of the baby decreases
# by 0.01 oz.

# c. The coefficient for parity is different than in the linear model shown in Exercise 6.2. Why
#    might there be a difference?
#   Parity might be correlated to other predictor values, so doing the multiple regression helps reduce
#   the underlying bias from when we do regression with only parity.

# d. Calculate the residual for the first observation in the dataset.
# y = (0.44)(284) + (-3.33)(0) + (-0.01)(27) + (1.15)(62) + (0.05)(100) + (-8.40)(0) - 80.41
# y = (0.44)(284) + (-0.01)(27) + (1.15)(62) + (0.05)(100) - 80.41
# y = 120.58
# Res = -0.58
# The model overpredicts.

# e. The variance of the residuals is 249.28, and the variance of the birth weights of all babies
#    in the data set is 332.57. Calculate the R^2 and the adjusted R^2. Note that there are 1,236
#    observations in the data set.
#   R^2 = 332.57 - 249.28 / 332.57 = .2504
#   adjusted R^2 = 1 - (Var(es)/Var(y)) * (n-1/n-k-1)
#   1 - (249.28/332.57) * (1235/1229)
#   1 - (0.7495) * 1.0048
#   1 - .7531
#    = .2468
#
#   n = 1236
#   k = 6
#   Var(estimator) = 249.28
#   Var(actual) = 332.57

library(pwr)
sig.level <- 0.10
pwr <- .80
d <- 0.025

power.prop.test(p1 = .40, p2 = .40001, sig.level = sig.level, power = pwr, alternative = "one.sided")
# Sample size required: 21.000.000.000 (21 billion) - too large not possible
