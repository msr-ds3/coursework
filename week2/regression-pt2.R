#################################################################################
# Reproduce this table in ISRS 5.29 using the original dataset in body.dat.txt
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000
body <- read.table("body.dat.txt", header = FALSE)

# 506 Observations / Physically Active Individuals
# Note: The study states there are 507 individuals who participated. One observation is missing.
nrow(body)

# Compute summary statistics
summary(body)

# Weight: 40-120kg -> 90-260lbs
# Height: 150-200cm 

#V23 = Weight (y)
#V24 = Height (x)

# Rename columns using dplyr
library(dplyr)

body <- body %>% rename("weight" = "V23", "height" = "V24")

# Use the method of least squares to fit model
mod = lm(weight ~ height, data = body)
summary(mod)
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
babyweights <- read.table("babyweights.txt", header = TRUE)

# a. Write the equation of the regression line.

model = lm(bwt ~ smoke, data = babyweights)
summary(model)

b0 = coef(model)[1]
b1 = coef(model)[2]

glue::glue("y = {b0} + {b1} * x")

# b. Interpret the slope in this context, and calculate the predicted birth weight of babies born to
# smoker and non-smoker mothers.

# b0 (slope) = The weight of the baby changes at a rate of 123.05 ounces

predict(model, newdata = tibble(smoke = c(0,1)))

# c. Is there a statistically significant relationship between the average birth weight and smoking?

# Null Hypothesis H0: b1 = 0
# Alternative Hypothesis H1: b1 != 0

# The p-value is approximately zero. We reject the null hypothesis and conclude
# there is a statistically significant relationship between the average birth weight
# and smoking


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
# a. Write the equation of the regression line.

mod2 = lm(bwt ~ parity, data = babyweights)
summary(mod2)

b0 = coef(mod2)[1]
b1 = coef(mod2)[2]

glue::glue("y = {b0} + {b1} * x")

# b. Interpret the slope in this context, and calculate the predicted birth weight of first borns and
#    others.

# B1 = For every one ounce increase in weight, the parity decreases by 1.93.

predict(mod2, newdata = tibble(parity = c(0,1)))

# c. Is there a statistically significant relationship between the average birth weight and parity?

# Null Hypothesis H0: b1 = 0
# Alternative Hypothesis H1: b1 != 0

# The p-value is 0.1052, and is greater than a significance value at 5% and 10%. We fail to reject the
# null hypothesis. There is no statisticaly significant relationship between the average birth weight
# and parity.

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
# a. Write the equation of the regression line that includes all variables:

mod3 = lm(bwt ~ gestation + parity + age + height + weight + smoke, data = babyweights)
summary(mod3)

coefs <- coef(mod3)

glue::glue("y = { coefs['(Intercept)'] } + { coefs['gestation'] } * x1 + { coefs['parity'] } * x2 + { coefs['age'] } * x3 + 
            { coefs['height'] } * x4 + { coefs['weight'] } * x5 + { coefs['smoke'] } * x6")

# b. Interpret the slopes of gestation and age in this context:

# b1 (gestation): For every one ounce increase in baby weight, the length of pregnancy in days 
# increases by 0.44, holding all other variables fixed.

# b3 (age): For every one ounce increase in baby weight, the age of the mother decreases by 0.01 years,
# holding all other variables fixed.

# c. The coefficient for parity is different than in the linear model shown in Exercise 6.2. Why
#    might there be a difference?

# The coefficient for parity is different than in the linear model shown in Exercise 6.2 because 
# multiple linear regression model assumes all other variables are held fixed. Whereas, in a single
# linear regression model, no other variables are considered.

# d. Calculate the residual for the first observation in the dataset.

resid(mod3)[1]
# Output: -2.003102

# e. The variance of the residuals is 249.28, and the variance of the birth weights of all babies
#    in the data set is 332.57. Calculate the R^2 and the adjusted R^2. Note that there are 1,236
#    bservations in the data set.

# Variance of Residuals
var(resid(mod3))
# Output: 249.2832

# Variance of Birthweight
var(babyweights$bwt)
# Output: 332.5682

# Number of Observations in the Data Set
nrows(babyweights)
# Output: 1,236

# Inspect Valid Names
names(summary(mod3))

# R^2 = 0.2579535
summary(mod3)$r.squared

# Adjusted R^2 = 0.2541383
summary(mod3)$adj.r.squared

