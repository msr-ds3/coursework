##################################################################################
# ISRS Exercise 5.20
# Part III. Exercise 5.13 introduces data on shoulder girth and
# height of a group of individuals. The mean shoulder girth is 
# 108.20 cm with a standard deviation of 10.37 cm. The mean height 
# is 171.14 cm with a standard deviation of 9.41 cm. The correlation
# between height and shoulder girth is 0.67
# See textbook for image

# a. Write the equation of the regression line for predicting height.

# Correlation Coefficient 
r = 0.67

# Shoulder Girth 
mu_x <- 108.20
sigma_x <- 10.37

# Height
mu_y <- 171.14
sigma_y <- 9.41

# y = B0 + B1x
b1 = r * sigma_y/sigma_x
b1
# b1 = 0.6079749

b0 = mu_y - b1 * mu_x
b0
# b0 = 105.3571

# y = 105.3571 + 0.6079749x
# b. Intepret the slope and the intercept in this context.

# The slope means the rate of change of height is 105cm.
# B1 is the predictor variable of shoulder girth.
# For every 1 cm change of the height, the shoulder girth will 
# increase by 0.6079749 cm

# c. Calculate R^2 of the regression line for predicting height from 
#    shoulder girth, and interpret in the context of the application. 

# Coefficient of Determination
r_squared = r^2
r_squared 
# R^2 = 0.4489. 44.89% of the data can be explained by the linear relationship
# between shoulder length and height

# d. A randomly selected student from your class has a shoulder girth 
#    of 100 cm. Predict the height of this student using the model.

y_hat = b0 + b1 * 100
y_hat
# Output: 166.1546cm

# e. The student from part (d) is 160 cm tall. Calculate the residual, 
#    and explain what this residual means.

y = 160
residual = y_hat - y 
residual 

# residual = 6.154606; we overestimated the student's height
# by 6.154606cm.

# f. A one year old has a shoulder girth of 56 cm. Would it be 
#    appropriate to use this linear model to predict the height of this child?

# Let's test it out!
y_hat2 = b0 + b1 * 56
y_hat2
# Output: 139.4037cm, which scales to 4ft 6.883 inches.
# It would not be appropriate to use this linear model to predict the height of a
# one year old.

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

# Weight is a function of height

# b. Write the equation of the regression line. Interpret the slope
#    and intercept in context.

b0 = -105.0113
b1 = 1.0176
# y = -105.0113 + 1.0176x
# b0 (slope) = The predicted weights change at a rate of -105.0113 kg.
# b1 (predictor variable of height) = For every one kg decrease in weight,
# the height increases by 1.0176 cm.

# c.Do the data provide strong evidence that an increase in height 
#   is associated with an increase in weight? State the null and 
#   alternative hypotheses, report the p-value, and state your conclusion.

# Null Hypothesis H0: b1 = 0 
# Alternative Hypothesis Ha: b1 > 0

# The p-value is approximately 0. We reject the null hypothesis
# and conclude there is strong evidence that an increase in height
# is associated with an increase in weight.



# d. The correlation coefficient for height and weight is 0.72. 
#    Calculate R^2 and interpret it in context.

r = 0.72
r_squared = r^2
r_squared
# The coefficient of determination is 0.4489. 44.89% of the data can be explained
# by the relationship between height and weight