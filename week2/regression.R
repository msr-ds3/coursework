##################################################################################
# ISRS Exercise 5.20
# Part III. Exercise 5.13 introduces data on shoulder girth and
# height of a group of individuals. The mean shoulder girth is 
# 108.20 cm with a standard deviation of 10.37 cm. The mean height 
# is 171.14 cm with a standard deviation of 9.41 cm. The correlation
# between height and shoulder girth is 0.67
# See textbook for image

# a. Write the equation of the regression line for predicting height.

# Finding the least squares line: calculate m (slope) as R * s_y/s_x

r <- 0.67
s_x <- 10.37
s_y <- 9.41

m <- r * (s_y/s_x)
m

# calculate b 
# textbook says (mean_x, mean_y) should be a point 
mean_x <- 108.2
mean_y <- 171.4
b <- mean_y - mean_x * m
b

# So the formula is:
# height = 0.6079749(shoulder_girth) + 105.6171

# define it as a function
height <- function(shoulder_girth) {
    m * shoulder_girth + b
}

# b. Intepret the slope and the intercept in this context.

# The slope 0.6079749 is the proportion between height and shoulder girth in the least squares line.

# The intercept 105.6171 what the height would approximately be if the shoulder girth was 0.

# c. Calculate R^2 of the regression line for predicting height from 
#    shoulder girth, and interpret in the context of the application. 

r.2 <- r^2
r.2
# The number is 0.4489
# This value represents the relative change variation the predicted heights (using the regression formula) from the actual heights.

# d. A randomly selected student from your class has a shoulder girth 
#    of 100 cm. Predict the height of this student using the model.

x <- 100
y_hat <- height(x)
y_hat
# The height according to the regression formula from (a) is 166.4146 cm.


# e. The student from part (d) is 160 cm tall. Calculate the residual, 
#    and explain what this residual means.

y <- 160
res = y_hat - y
res

# The residual here is the difference between the observed height and expected height.
# It is a score used to determine error of the model.


# f. A one year old has a shoulder girth of 56 cm. Would it be 
#    appropriate to use this linear model to predict the height of this child?

height_baby <- height(56)
height_baby
# The model says the baby is 139.6637 cm, which is around 4'7. This is unrealistically tall for a one-year-old.
# Therefore, the linear model is not appropriate to predict the height of the baby. 

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

# According to the scatterplot, generally as height increases, weight increases (positive correlation).

# b. Write the equation of the regression line. Interpret the slope
#    and intercept in context.

# The equation is weight = 1.0176 * height - 105.0113
# Define it as a function

height <- function(weight) {
    1.0176 * weight - 105.0113
}

# c.Do the data provide strong evidence that an increase in height 
#   is associated with an increase in weight? State the null and 
#   alternative hypotheses, report the p-value, and state your conclusion.

# The slope can be used to determine this "increase".
# The p-value here is Pr(>|t|) which is 0. This means that the chance of seeing a t-value
# that extreme is 0%. Since this is under the standard significance level of 5%, we reject
# the null hypothesis, therefore the relationship between change in height and change in 
# weight is statistically significant. 

# d. The correlation coefficient for height and weight is 0.72. 
#    Calculate R^2 and interpret it in context.

r.2 <- 0.72^2
r.2
# The r^2 score here is 0.5184. This is the relative change in variation the predicted weights (using the regression formula) from the actual weights.