##################################################################################
# ISRS Exercise 5.20
# Part III. Exercise 5.13 introduces data on shoulder girth and
# height of a group of individuals. The mean shoulder girth is 
# 108.20 cm with a standard deviation of 10.37 cm. The mean height 
# is 171.14 cm with a standard deviation of 9.41 cm. The correlation
# between height and shoulder girth is 0.67
# See textbook for image

# a. Write the equation of the regression line for predicting height.
 # y = b0 + b1x
 # b1 = (Sy / Sx) * R 
    # with R --> correlation between the shoulder girth and the height
    # Sy --> standard deviation of the height 
    # Sx --> standard deviation of the shoulder girth
 # b0 = y_bar - b1 * x_bar
    # with y_bar --> mean height
    # x_bar --> mean shoulder girth
 b1 = (9.41 / 10.37) * 0.67
 b1 # 0.608
 b0 = 171.14 - 0.6079749 * 108.20
 b0 # 105.357
 # The equation of the regression is: y = 105.357 + 0.608x

# b. Intepret the slope and the intercept in this context.
 # Slope: 0.608
 # This means that for any additional 1cm of shoulder girth, the model 
 # predicts the height to increase by 0.608 on average.
 # Intercept: 105.357
 #The estimated intercept b0 = 105.357cm describes the height if 
 # the shoulder girth is 0cm, something that's far outside of the observed data range.

# c. Calculate R^2 of the regression line for predicting height from 
#    shoulder girth, and interpret in the context of the application. 
R2 = (0.67)^2
R2  # 0.4489
 # About 44.89% of the variability in height is explained by the 
 # linear relationship between height and shoulder girth.

# d. A randomly selected student from your class has a shoulder girth 
#    of 100 cm. Predict the height of this student using the model.
y = 105.357 + 0.608 * (100)
y # The height of the student  is 166.157 cm

# e. The student from part (d) is 160 cm tall. Calculate the residual, 
#    and explain what this residual means.
Residual = 160 - 166.157
Residual # -6.157 cm 
 # I believe that the student's height is 6.157 cm shorter than 
 # what the regression model predicted.

# f. A one year old has a shoulder girth of 56 cm. Would it be 
#    appropriate to use this linear model to predict the height of this child?
 # No, it wouldn't be appropriate to use this linear model to 
 # predict the height of the child because 56cm is far away from the 
 # given shoulder girth range


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
 # There's a slightly strong positive linear relationship between 
 # height and weight among the physically active individuals. 
 # Taller individuals tend to weigh more based on the scatterplot.

# b. Write the equation of the regression line. Interpret the slope
#    and intercept in context.
 # The equation of the regression line is: W_hat = -105.0113 + 1.0176h
 # Slope: 1.0176
 # This means that for any additional 1cm of height, the predicted 
 # weight increases by 1.0176 kg on average
 # Intercept: -105.0113
 # The estimated intercept -105.0113 describes the weight for a person 
 # whose height is 0cm, something that's far outside of the observed data range.

# c.Do the data provide strong evidence that an increase in height 
#   is associated with an increase in weight? State the null and 
#   alternative hypotheses, report the p-value, and state your conclusion.
 # Let b1 be the population slope
 # H0: b1 = 0 --> null hypothesis
 # Ha: b1 > 0 --> alternative hypothesis
 # Based on the table, p-value = 0.0000
 # p-value < 0.05 therefore, we reject the null hypothesis H0
 # We can conclude that greater height is associated with greater weight.
 # The taller individuals tend to weigh more.

# d. The correlation coefficient for height and weight is 0.72. 
#    Calculate R^2 and interpret it in context.
R2 = (0.72)^2
R2  # 0.5184 
 # About 51.84% of the variation in weight among the physically 
 # active individuals is explained by the linear relationship betwen 
 # height and weight.

