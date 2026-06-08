##################################################################################
# ISRS Exercise 5.20
# Part III. Exercise 5.13 introduces data on shoulder girth and
# height of a group of individuals. The mean shoulder girth is 
# 108.20 cm with a standard deviation of 10.37 cm. The mean height 
# is 171.14 cm with a standard deviation of 9.41 cm. The correlation
# between height and shoulder girth is 0.67
# See textbook for image

# a. Write the equation of the regression line for predicting height.
y - 171.14 = ((9.41/10.37)*.67)(x - 108.20)
y =  0.6079749x + 105.3571
# b. Intepret the slope and the intercept in this context.
# The slope tells us that for each additional 1 cm of shoulder girth, we expect the height to increase by ~.60797 cm. 
# The intercept is the baseline - the amount of cm more than girth that height is always expected to be at least - not contingent on the actual height.
# It means that the height of a person with 0 cm shoulder girth would be 108.2 cm - which doesn't make sense in this context.
# c. Calculate R^2 of the regression line for predicting height from 
#    shoulder girth, and interpret in the context of the application. 
.67**2 = 0.4489 # This means about 45% of the variation in height is explained by shoulder girth. 
# d. A randomly selected student from your class has a shoulder girth 
#    of 100 cm. Predict the height of this student using the model.
# 166.15 cm
# e. The student from part (d) is 160 cm tall. Calculate the residual, 
#    and explain what this residual means.
# -6.15 cm - This is a small, negative residual, meaning that the equation underestimated the height by a bit.
# f. A one year old has a shoulder girth of 56 cm. Would it be 
#    appropriate to use this linear model to predict the height of this child?
# No. Since the model only goes down to a girth of ~80 cm, we cannot assume it extends past what we see-    
# consider the example of the intercept which is physically impossible.
##################################################################################
# ISRS Exercise 5.29
# The scatterplot and least squares summary below show the relationship
# between weight measured in kilograms and height measured in centimeters
# of 507 physically active individuals
# See textbook for scatterplot.

# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000

# a. Describe the relationship between height and weight.
# For each additional cm of height, the weight is expected to increase by 1.0176 kg.
# b. Write the equation of the regression line. Interpret the slope
#    and intercept in context.
y = 1.0176x - 105.0113
# The slope tells us that for each additional 1 cm of height, we expect a 1.0176 cm increase in height.
# The intercept is the baseline - it tells us that a person with 0 cm height is expected to have a weight of -105.0113 kg.
# This doesn't make sense in this context - it wouldn't actually occur.
# c.Do the data provide strong evidence that an increase in height 
#   is associated with an increase in weight? State the null and 
#   alternative hypotheses, report the p-value, and state your conclusion.
# H0: There is no linear relationship between an increase in height and weight
# HA: There is a positive linear relationship between an increase in height and weight.
#  Since the p value is lower than .0001, lower than the chosen alpha of .05, we reject
# the null hypothesis. Yes, an increase in height is associated with an increase in weight.
# The correlationcoefficient forheight andweight is 0.72. Calculate R^2 and interpret it in context.
0.72^2 = 0.5184 # This means that about 52% of the variation in weight can be explained by the variation in height. 