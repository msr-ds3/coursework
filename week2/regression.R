##################################################################################
# ISRS Exercise 5.20
# Part III. Exercise 5.13 introduces data on shoulder girth and
# height of a group of individuals. The mean shoulder girth is 
# 108.20 cm with a standard deviation of 10.37 cm. The mean height 
# is 171.14 cm with a standard deviation of 9.41 cm. The correlation
# between height and shoulder girth is 0.67
# See textbook for image

# a. Write the equation of the regression line for predicting height.
# b(x-x_hat) = y -y_hat  
# b <- (9.41/10.37 )* 0.67
# b
# 0.608621
# y - 171.14 = 0.608621(x-108.20) 

# b. Intepret the slope and the intercept in this context.
#  The slope , 0.608621 means that for every increase in shoulder girth there is a 0.608621 increase in height on average. higher shoulder girth  leads to higher height. 
#  The estimated intercept, - 105.48 is the shoulder girth if the height was 0 
#  the intercept in this context is the estimated intercept aka the average hieght is 0 
# c. Calculate R^2 of the regression line for predicting height from 
#    shoulder girth, and interpret in the context of the application. 
R.square <- 0.67^2
R.square
# 0.4489
# The R^2 in this context means that there is an increase of 44.8% in the data's variation by using 
# infromation about the the shoulder girth to predict the height
# d. A randomly selected student from your class has a shoulder girth 
#    of 100 cm. Predict the height of this student using the model.
y.ans <- (0.608621*(100-108.20))+171.14
y.ans  
#166.14931
# e. The student from part (d) is 160 cm tall. Calculate the residual, 
#    and explain what this residual means.
residual <-   160 -y.ans
residual
# -6.149308
# This residual means that the difference between the observed hieght and the hieght poredicted based on the model is -6.149308. 
# The model overestimated the observation and therefore the residual is negative 
# f. A one year old has a shoulder girth of 56 cm. Would it be 
#    appropriate to use this linear model to predict the height of this child?
 child.hieght <- (0.608621*(56-108.20))+171.14
 child.hieght
# 139.37
# No it would not be appropriate to use this model to predict it because a child cannot be 139 cm tall. it is impossible 
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
# This means that an increase in weigth also leads to a an increase in the height. The slope is positive and overall this shows that it is a positive correlation 
# b. Write the equation of the regression line. Interpret the slope
#    and intercept in context.
#  weight =  -105.0113 + 1.0176(height) 
# The slope , 1.0176 means that for every increase in weight there is a 1.0176 increase in height on average. higher weight leads to higher height. 
# The estimated intercept, -105.0113 is the height if the weight was 0 
# c.Do the data provide strong evidence that an increase in height 
#   is associated with an increase in weight? State the null and 
#   alternative hypotheses, report the p-value, and state your conclusion.
#  The null hypothesis is that when the slope of the model is is 0  and the altenative hypothesis is that  the slope of the linear model is not 0  
#  the p value is 0.000 (larger than 0.2) so this means that there is strong enough evidence to prove that the slope is not 0 and that an increase in height 
#  #  also leads to an increase in weight so we reject the null hypotheisis 
# d. The correlation coefficient for height and weight is 0.72. 
#    Calculate R^2 and interpret it in context.
 r.squared <- 0.72^2
 r.squared 
 0.5184
# The R^2 in this context means that there is an increase of  51% in the data's variation by using 
# infromation about the height to predict the weight