##################################################################################
# ISRS Exercise 5.20
# Part III. Exercise 5.13 introduces data on shoulder girth and
# height of a group of individuals. The mean shoulder girth is 
# 108.20 cm with a standard deviation of 10.37 cm. The mean height 
# is 171.14 cm with a standard deviation of 9.41 cm. The correlation
# between height and shoulder girth is 0.67
# See textbook for image

# a. Write the equation of the regression line for predicting height.
# y - 171.14 = 0.608(x - 108.20)
# b. Intepret the slope and the intercept in this context.
# for 1 unit increase in shoulder girth our model predicts there is 0.608 increase in height.
# when shoulder girth is zero, our model predicts 105.35 cm which is the intercept of our model.
# c. Calculate R^2 of the regression line for predicting height from 
#    shoulder girth, and interpret in the context of the application.
# 0.4489, R^2 in this context means there is decrease in 44.89 % in data's variation to predict height by using should girth with this model, 
# d. A randomly selected student from your class has a shoulder girth 
#    of 100 cm. Predict the height of this student using the model.
# 166.154 cm
# e. The student from part (d) is 160 cm tall. Calculate the residual, 
#    and explain what this residual means.
# 160 - 166.154 = -6.154
# f. A one year old has a shoulder girth of 56 cm. Would it be 
#    appropriate to use this linear model to predict the height of this child?
# for shoulder girth of  56 cm our model outputs the height of 139.4 cm, which will be wired for 1 year old child,
# so this linear model is not appropriate to predict the height of this child

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
# There is a postive correlation between height and weight, both grow with almost similar rate as weigth = 1.0176* height - 105.0113
# b. Write the equation of the regression line. Interpret the slope
#    and intercept in context.
# weight = 1.0176 * height - 105.0113, so from slope it can be concluded that for 1 unit increase in height our model predict 1.0176 increase in weight.
# similarly for intercept, given that height is zero our model will predict weight as -105.0113 kg
# c.Do the data provide strong evidence that an increase in height 
#   is associated with an increase in weight? State the null and 
#   alternative hypotheses, report the p-value, and state your conclusion.
# Null hypothesis : There is no realtioship between height and weight.
# Alternate hypothesis : There is a strong correaltion between height and weight either negative or positive.
# our p-value is 0, so we can reject our Null hypothesis,
# Yes data do provide strong evidence that increase in height is associated with increase in weight as our slope is positive and also alternate hypothesis is true.
# d. The correlation coefficient for height and weight is 0.72. 
#    Calculate R^2 and interpret it in context.
#0.72*0.72 = 0.5184, R^2 means by using information about height with our model we were able reduce variation of about 51.84% in data for predicting weight.
