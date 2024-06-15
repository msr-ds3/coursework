# Read Chapter 5 of Intro to Stats with Randomization and Simulation
# Do exercises 5.20 and 5.29

"
5.20 Body measurements, Part III. Exercise 5.13 introduces data on shoulder girth and
height of a group of individuals. The mean shoulder girth is 108.20 cm with a standard deviation
of 10.37 cm. The mean height is 171.14 cm with a standard deviation of 9.41 cm. The correlation
between height and shoulder girth is 0.67.
"

# (a) Write the equation of the regression line for predicting height.
slope <- (9.41/10.37) * 0.67
# Equation is y = 0.61x + 105.138

# (b) Interpret the slope and the intercept in this context.
# The slope means that for every cm of shoulder girth, there is an increase of 0.61 cm of height
# The intercept of 105.138 is the baseline. 0 cm of shoulder girth equates to about 105.138 cm of height

# (c) Calculate R^2 of the regression line for predicting height from shoulder girth, and interpret it in the context of the application.
# R^2 = 0.4489 
# This means that 44.89% of the variation can be explained by the least squares line.

# (d) A randomly selected student from your class has a shoulder girth of 100 cm. Predict the height of this student using the model.
y = 0.61*(100) + 105.138
# Height is predicted to be 166.138

# (e) The student from part (d) is 160 cm tall. Calculate the residual, and explain what this residual means.
residual <- 160 - 166.138
# Residual is -6.138. This means that the model has an error of -6.138 for this particular point.

# (f) A one year old has a shoulder girth of 56 cm. Would it be appropriate to use this linear model to predict the height of this child?
y = 0.61*(56) + 105.138
# Height would be 139.298 cm. This model would not be appropriate to use for a one year old
# No one year old is 139.298 cm tall. This model cannot be extrapolated.

# 5.29 Body measurements, Part IV. The scatterplot and least squares summary below show
# the relationship between weight measured in kilograms and height measured in centimeters of 507
# physically active individuals.

# (a) Describe the relationship between height and weight.
# There is a positive correlation between height and weight, as seen in the chart and with the
# positive slope of 1.0176.

# (b) Write the equation of the regression line. Interpret the slope and intercept in context.
# Regression line: y = 1.0176x - 105.0113
# Slope: For every cm of height, weight will increase by 1.0176 kg.
# Intercept: The base line is -105.0113 (height of 0 cm)

# (c) Do the data provide strong evidence that an increase in height is associated with an 
#     increase in weight? State the null and alternative hypotheses, 
#     report the p-value, and state your conclusion.
# Null Hypothesis: There is no correlation with height and weight
# Alternate Hypothesis: There is a positive correlation with height and weight
# Using a two-tailed T-test with T-score of 23.127, the p score is < 0.010, so we can reject the null hypothesis.
# This means that it is likely that there is a positive correlation with height and weight.

# (d) The correlation coefficient for height and weight is 0.72. Calculate R^2 and interpret it in context.
# R^2 = 0.5184
# This means that 51.84% of the the variation can be explained by the least squares line.


# Read Section 3.1 of Intro to Statistical Learning, do Lab 3.6.2
library(ISLR2)
head(Boston)

lm.fit <- lm(medv ~ lstat, data = Boston)
summary(lm.fit)

names(lm.fit)

# continued on day 5 book