#################################################################################
# Reproduce this table in ISRS 5.29 using the original dataset in body.dat.txt
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000
body <- read.table("body.dat.txt", header = TRUE)

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
y = -8.94x + 123.05 
# b. Interpret the slope in this context, and calculate the predicted birth weight of babies born to
# smoker and non-smoker mothers.
# Smoking lowers average birth weights by 8.94 oz. 
# Babies of smokers are predicted to be around 114.11 oz, while babies of non-smokers are expected to be 123.05 oz.
# c. Is there a statistically significant relationship between the average birth weight and smoking?
# Yes. Since the p-value is less than our .05 alpha value, we reject the null that there is no relationship.
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
y = -1.93x + 120.07
# b. Interpret the slope in this context, and calculate the predicted birth weight of first borns and
#    others.
# Not being a first born lowers average birth weights by 1.93 oz. 
# c. Is there a statistically significant relationship between the average birth weight and parity?
# No. Since the p-value is greater than our .05 alpha value, we fail to reject our null hypothesis that
# parity has no effect on birth weight.
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
y = -80.41 + .44x1 -3.33x2 - 0.01x3 + 1.15x4 + 0.05x5 - 8.40x6
# b. Interpret the slopes of gestation and age in this context:
# For each additional day of gestation, if all else is equal, the weight increases by .44 oz.
# For each additional inch of mother's height, if all else is equal, the weight increases by 1.15 oz.
# c. The coefficient for parity is different than in the linear model shown in Exercise 6.2. Why
#    might there be a difference?
# In the linear model, not all other variables were considered equal, diluting, and possibly confounding the effect.
# d. Calculate the residual for the first observation in the dataset.
line_one <- babyweights[1,]
line_one$bwt - (-80.41 + (.44*line_one$gestation) -3.33*(line_one$parity) - 0.01*(line_one$age) + 1.15*(line_one$height) + 0.05*(line_one$weight) - 8.40*(line_one$smoke))
# Answer: -0.58
# e. The variance of the residuals is 249.28, and the variance of the birth weights of all babies
#    in the data set is 332.57. Calculate the R^2 and the adjusted R^2. Note that there are 1,236
#    observations in the data set.
1 - (249.28/332.57) #R squared = 0.2504435
1 - ((249.28/332.57) * ((1236-1)/(1236-6-1))) #adjusted R squared = 0.2467842