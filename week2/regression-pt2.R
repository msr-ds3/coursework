library(stringr)

#################################################################################
# Reproduce this table in ISRS 5.29 using the original dataset in body.dat.txt
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000
body <- read.table("body.dat.txt")

summary(body) # This tells me which cols would be weight and height columns
# weight is V23
# height is V24

model <- lm(V23 ~ V24, data = body)
summary(model)
# Below is the output
#               Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -105.01125    7.53941  -13.93   <2e-16 ***
# V24            1.01762    0.04399   23.14   <2e-16 ***

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

# y = -8.94x + 123.05 

# Create a function
birth_weight_if_mom_smokes <- function(smoker_mom) {
    -8.94 * smoker_mom + 123.05
}

# b. Interpret the slope in this context, and calculate the predicted birth weight of babies born to
# smoker and non-smoker mothers.

# The slope is the "proportional" relationship between if a mom smokes and the weight of the baby when it's born.

weight_smoker <- birth_weight_if_mom_smokes(1)
weight_smoker
# The weight would be 114.11 oz

weight_non_smoker <- birth_weight_if_mom_smokes(0)
weight_non_smoker
# The weight would be 123.05 oz

# c. Is there a statistically significant relationship between the average birth weight and smoking?

# Yes because the p-value of smoke (Pr(>|t|)) is 0.000 which is below the standard significance level of 0.05.
# Here, the p-value is the probability of seeing a t-value greater than the computed t-value

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

# y = -1.93x + 120.07

# Create a function for this
birth_weight_by_parity <- function(parity) {
    -1.93 * parity + 120.07
}

# b. Interpret the slope in this context, and calculate the predicted birth weight of first borns and
#    others.

# The slope is the "proportional" relationship between the parity of the baby and the weight of the baby when it's born.

birth_weight_first_born <- birth_weight_by_parity(0)
birth_weight_first_born
# This is 120.07 oz

birth_weight_not_first_born <- birth_weight_by_parity(1)
birth_weight_not_first_born
# This is 118.14

# c. Is there a statistically significant relationship between the average birth weight and parity?

# Here the p-value is 0.1052, which is above the standard significance level of 0.05. Therefore, there is no statistically significant relationship.

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

# x1 = gestation
# x2 = parity
# x3 = age
# x4 = height
# x5 = weight
# x6 = smoke
# y = birth_weight 

# Regression line:
# y = 0.44x1 - 3.33x2 - 0.01x3 + 1.15x4 + 0.05x5 - 8.4x6 - 80.41

# Create a function
birth_weight <- function(gestation, parity, age, height, weight, smoke) {
    (0.44 * gestation) - (3.33 * parity) - (0.01 * age) + (1.15 * height) + (0.05 * weight) - (8.4 * smoke) - 80.41
}

# b. Interpret the slopes of gestation and age in this context:

# This would be the "weight" for the gestation variable in birth_weight. 

# c. The coefficient for parity is different than in the linear model shown in Exercise 6.2. Why
#    might there be a difference?

# It may be because all the values of the weights are their relative contribution to birth_weight.

# d. Calculate the residual for the first observation in the dataset.

bw_1 <- birth_weight(
    gestation = 284,
    parity = 0, 
    age = 27,
    height = 62,
    weight = 100, 
    smoke = 0
)
bw_1
# The value is 120.58 oz
res = abs(120 - bw_1)
res
# The residual is 0.58 oz

# e. The variance of the residuals is 249.28, and the variance of the birth weights of all babies
#    in the data set is 332.57. Calculate the R^2 and the adjusted R^2. Note that there are 1,236
#    bservations in the data set.

r.2 <- (332.57 - 249.28) / 249.28
r.2
# The r^2 value is 0.3341223

bwt_info <- lm(bwt ~ gestation + parity + age + height + weight + smoke, data = babyweights)
summary(bwt_info)
# Adjusted R-squared:  0.2541
