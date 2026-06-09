#################################################################################
# Reproduce this table in ISRS 5.29 using the original dataset in body.dat.txt
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000
body <- read.table("body.dat.txt", header = FALSE)
lm.fit <- lm(V23 ~ V24, data = body)
attach(body)
#V23 - WEIGHT IN KG 
#V24 = HIEGHT IN CM 
lm.fit <- lm(V23 ~ V24)
lm.fit
summary(lm.fit)
#Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
#(Intercept) -105.01125    7.53941  -13.93   <2e-16 ***
#V24            1.01762    0.04399   23.14   <2e-16 ***

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
# # babywieght = 123.05 - 8.94(smoke) 
# b. Interpret the slope in this context, and calculate the predicted birth weight of babies born to
# smoker and non-smoker mothers.
# The slope, -8.94 means that every ounce of babyweight descreases by 8.94 on average if the mother smokes compared to when the mother doesnt smoke 
# c. Is there a statistically significant relationship between the average birth weight and smoking?
# Yes , it sis statistically significant as thep valu e 0.000<0.05 (our threshold) proving that there is enough evidence to reject the null hypothesis and 
# prove that smoking does affect the baby's weight.
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
# babywieght = 120.07 - 1.93(parity)
# b. Interpret the slope in this context, and calculate the predicted birth weight of first borns and
#    others.
# The slope, -1.93 tells us that theis ia net difference of 1.93 between the average baby weight and the if the child is a finest born 
# c. Is there a statistically significant relationship between the average birth weight and parity?
# No it is not statistically significant as the pvalue is 0.1 which is greater than 0.05 prove that there is not enough evidence to show that 
# that the the child's weight is affected if its the first born or not. So we accept the null hypothesis

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
# babyweight = -80.41 + 0.44(x1)(gestation) - 3.33(x2)(parity) - 0.01(x3)(age) + 1.15(x4)(height) + 0.05(x5)(weight) - 8.40(x6)(smoke)
# b. Interpret the slopes of gestation and age in this context:
# For the slope of geststaion, 0.44 we can say that for every 0.44 increase in average baby weight depends on a increase in gestation period. the higher the wieght of the baby the longer te gestation period
# For slope of age, -0.01 we can say that that evry increase in the mother's age can cause a 0.01 decrease in the baby's average weight. the older the mother , the lower the baby's weight 
# c. The coefficient for parity is different than in the linear model shown in Exercise 6.2. Why
#    might there be a difference?
#  There might be a difference because some predictors might be correlated and the addition of other predictors, allows us to control for other variables
#  when we use a combination of variables for prediction , any underlying or uniintentional bias is reduced even though  bias from other variables remain.
# d. Calculate the residual for the first observation in the dataset.
# residual = data - fit
residual <- -1.93 -3.33
residual 
# - 5.26
# e. The variance of the residuals is 249.28, and the variance of the birth weights of all babies
#    in the data set is 332.57. Calculate the R^2 and the adjusted R^2. Note that there are 1,236
#    bservations in the data set.
R1 <-  1 - (249.28/332.57)
R1 
#  0.2504435
R2 <- 1 - (249.28/1236-6-1)/(332.57/1236-6-1)
R2
# -0.0100115
