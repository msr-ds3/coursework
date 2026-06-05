##################################################################################
# ISRS Exercise 5.20
# Part III. Exercise 5.13 introduces data on shoulder girth and
# height of a group of individuals. The mean shoulder girth is 
# 108.20 cm with a standard deviation of 10.37 cm. The mean height 
# is 171.14 cm with a standard deviation of 9.41 cm. The correlation
# between height and shoulder girth is 0.67
# See textbook for image

# a. Write the equation of the regression line for predicting height.
#           shoulder girth (x)  height (y)
# mean      108.20              171.14    
# std. dev  10.37               9.14
#   LSR line slope = 9.14/10/37 (0.67) = 0.591
#   LSR line = height - 171.14 = 0.591(girth - 108.20)
#   In typical format = height = 0.591(girth) + 107.1938

# b. Intepret the slope and the intercept in this context.
#   The intercept indicates that given a person with shoulder girth of 0
#   their height is 107.1938 cm
#   The slope indicates that for each increase of girth by one,
#   a person's height will increase by .591 cm

# c. Calculate R^2 of the regression line for predicting height from 
#    shoulder girth, and interpret in the context of the application. 
#   R^2 = 0.67^2 = 0.4489
#   This indicates that the variance of the LSR line is around 0.4489, 
#   which also means that .4489 of responses for height can be 
#   explained by shoulder girth.

# d. A randomly selected student from your class has a shoulder girth 
#    of 100 cm. Predict the height of this student using the model.
#   height = 0.591(100) + 107.1938 = 59.1 + 107.1938 = 166.2938 cm

# e. The student from part (d) is 160 cm tall. Calculate the residual, 
#    and explain what this residual means.
#   If the height of student is 160 cm and our model's prediction if 166.2938,
#   the residual is -6.2938 cm. The residual (-6.2938) represents some leftover
#   variation from the LSR model.

# f. A one year old has a shoulder girth of 56 cm. Would it be 
#    appropriate to use this linear model to predict the height of this child?
#   No, this model would predict the one year old's height to be 140.2898 which 
#   is highly unlikely. 

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
#   According to the software output, the LSR line
#   indicates a positive relationship between height and weight.

# b. Write the equation of the regression line. Interpret the slope
#    and intercept in context.
#   weight = 1.0176(height) - 105.0113
#   The intercept indicates that given a person with height 0, they weigh
#   -105.0113.
#   The slope indicates that each increase of height by 1, the person's
#   predicted weight increases by 1.0176. 

# c. Do the data provide strong evidence that an increase in height 
#   is associated with an increase in weight? State the null and 
#   alternative hypotheses, report the p-value, and state your conclusion.
#   H0(Increase in height is related to an increase in weight)
#   HA(Increase in height is unrelated to an increase in weight)
#   p-value = 0.000
#   The p-value is 0.000, we must reject the null hypothesis.

# d. The correlation coefficient for height and weight is 0.72. 
#    Calculate R^2 and interpret it in context.
#   If the correlation coefficient for height and weight is 0.72,
#   R^2 is .5184. This represents the proportion of variability
#   in weight that can be explained by height.