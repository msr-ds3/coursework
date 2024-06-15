# See if you can reproduce the table in ISRS 5.29 using the original dataset in body.dat.txt, taken from here

# Read tabular data into R
body <- read.table("body.dat.txt")

# Weight is col V23
# Height is col V24

model <- lm(V23 ~ V24, data = body)
summary(model)



# Do Labs 3.6.3 through 3.6.6 of Intro to Statistical Learning to get practice with linear models in R
library(MASS)
library(ISLR2)

head(Boston)

# To fit the model to medv (y-value) to lstat (x-value) using Boston as the data
lm.fit <- lm(medv ~ lstat, data = Boston)
attach(Boston)
lm.fit <- lm(medv ~ lstat)

# Get summary info about the model
lm.fit
summary(lm.fit)

# Get name info about the model
names(lm.fit)
# Get coefficient info about the model
coef(lm.fit)
# Get confidence interval
confint(lm.fit)

# Predict using the model (predict medv using lstat)
predict(lm.fit, data.frame(lstat = (c(5, 10, 15))),
        interval = "confidence")
predict(lm.fit, data.frame(lstat = (c(5, 10, 15))),
        interval = "prediction")

# Plot and add least squares regression line
plot(lstat, medv)
abline(lm.fit)

# Modifications to plot and line
abline(lm.fit, lwd = 3)
abline(lm.fit, lwd = 3, col = "red")

plot(lstat, medv, col = "red")
plot(lstat, medv, pch = 20)
plot(lstat, medv, pch = "+")
plot(1:20, 1:20, pch = 1:20)

# Plotting the residual plots
par(mfrow = c(2, 2))
plot(lm.fit)

plot(predict(lm.fit), residuals(lm.fit)) # return residuals
plot(predict(lm.fit), rstudent(lm.fit)) # return studentized residuals

plot(hatvalues(lm.fit)) # get the hat values
which.max(hatvalues(lm.fit)) # idetifies largest element in the hat values

# Multiple Linear Regression
# medv (y value) fitted using age and lstat (x values)
lm.fit <- lm(medv ~ lstat + age, data = Boston)
summary(lm.fit)

# Using all the predictors
lm.fit <- lm(medv ~ ., data = Boston)
summary(lm.fit)

library(car)
vif(lm.fit) # variance inflation factors

# Using all predictors except for age
lm.fit1 <- lm(medv ~ . - age, data = Boston)
summary(lm.fit1)

#lm.fit1 <- update(lm.fit, ∼ . - age) - update function can also work

summary(lm(medv ~ lstat * age, data = Boston)) # specify the parameters we want to use and their interaction


# Non linear models
# We raise lstat x variable to the power of 2 to make the model more complex
lm.fit2 <- lm(medv ~ lstat + I(lstat^2))
summary(lm.fit2)

lm.fit <- lm(medv ~ lstat)
anova(lm.fit, lm.fit2)

par(mfrow = c(2, 2))
plot(lm.fit2)

# Shortcut to increase the power of the function
lm.fit5 <- lm(medv ~ poly(lstat, 5)) # 5th power for lstat
summary(lm.fit5)

# Log function
summary(lm(medv ~ log(rm), data = Boston))

# Qualitative variables as predictors
head(Carseats)
lm.fit <- lm(Sales ~ . + Income:Advertising + Price:Age,
             data = Carseats)
summary(lm.fit) # we can see that R handles the qualitative data for us

attach(Carseats)
contrasts(ShelveLoc) # shows us what dummy variables R uses behind the scenes



# Read Sections 6.1 through 6.3 of ISRS on regression with multiple features
# Multiple Regression / R^2 Adjusted / Model Selection Strategies / Checking Model Assumptions using residual graphs

# Do Exercises 6.1, 6.2, and 6.3, and use the original data set in babyweights.txt, taken from here, to reproduce the results from the book
# 6.1
# (a) Write the equation of the regression line.
# weight = -8.94*(smoke) +  123.05

# (b) Interpret the slope in this context, and calculate the predicted birth weight of babies born to smoker and non-smoker mothers.
# The variable smoke is coded
# 1 if the mother is a smoker
# 0 if not
# The slope means that smoking (x=1) results in a decrease in weight by 8.94
smoke_weight <- -8.94*(1) +  123.05 #114.11
non_smoke_weight <- -8.94*(0) +  123.05 #123.05

# (c) Is there a statistically significant relationship between the average birth weight and smoking?
# Yes, it seems that there is a statistically significant relationship between average birth weight and smoking
# The p-value reported is very low (0.000 reported)

# 6.2
# Another variable we consider is parity, which is 0 if the child is the first born, and 1 otherwise
# (a) Write the equation of the regression line.
# weight = -1.93*(parity) + 120.07

# (b) Interpret the slope in this context, and calculate the predicted birth weight of first borns and others.
# The slope means that non-first born children have decreased weight
# Another variable we consider is parity:
# which is 0 if the child is the first born
# and 1 otherwise

first_born_weight <- -1.93*(0) + 120.07 #120.07
non_first_born_weight <- -1.93*(1) + 120.07 # 118.14

# (c) Is there a statistically significant relationship between the average birth weight and parity?



# 6.3
# (a) Write the equation of the regression line that includes all of the variables.
# weight = -80.41 + 0.44*(gestation) + -3.33*(parity) + -0.01*(age) + 1.15*(height) + 0.05*(weight) + -8.40*(smoke)

# (b) Interpret the slopes of gestation and age in this context.
# An increase in gestation results in an increased by 0.44
# An increase in age results in a decreased weight by 0.01

# (c) The coefficient for parity is different than in the linear model shown in Exercise 6.2. 
# Why might there be a difference
# Most likely parity has a lower or higher impact on the multiple regression model than in the linear model:
# This results in a change in the coefficient (which represents the weight of the variable)

# (d) Calculate the residual for the first observation in the data set.
actual_btw <- 120
predicted_btw <- -80.41 + 0.44*(284) + -3.33*(0) + -0.01*(27) + 1.15*(62) + 0.05*(100) + -8.40*(0) # 120.58
residual <- actual_btw - predicted_btw #0.579999

# (e) The variance of the residuals is 249.28, and the variance of the birth weights of all babies 
#     in the data set is 332.57. Calculate the R^2 and the adjusted R^2. 
#     Note that there are 1,236 observations in the data set.

R.2 <- 1 - (249.28/332.57) # 0.25044...
R.2.adj <- 1 - (249.28/332.57)*((1236-1)/(1236-6-1)) # 0.24678...
