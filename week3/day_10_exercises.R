library(tidyverse)
library(scales)

library(modelr)
options(na.action = na.warn)

library(broom)

theme_set(theme_bw())
options(repr.plot.width=4, repr.plot.height=3)

# Reproduce table from ISRS 5.29

body <- read.table("body.dat.txt")

body <- body %>% rename("age" = V22, "weight" = V23, "height" = V24, "gender" = V25)

lm.fit <- lm(weight ~ height, body)
summary(lm.fit)

# Lab 3.6.3

library(ISLR2)

lm.fit <- lm(medv ~ lstat + age, data = Boston)
summary(lm.fit)

lm.fit <- lm(medv ~ ., data = Boston)
summary(lm.fit)

?summary.lm

#install.packages("car")
library(car)
vif(lm.fit)

lm.fit1 <- lm(medv ~ . - age, data = Boston)
summary(lm.fit1)

lm.fit <- update(lm.fit, ~ . - age)

# Lab 3.6.4

summary(lm(medv ~ lstat * age, data = Boston))

# Lab 3.6.5

lm.fit2 <- lm(medv ~ lstat + I(lstat^2), Boston)
summary(lm.fit2)

lm.fit <- lm(medv ~ lstat, Boston)
anova(lm.fit, lm.fit2)


par(mfrow = c(2,2))
plot(lm.fit2)

lm.fit5 <- lm(medv ~ poly(lstat, 5), Boston)
summary(lm.fit5)

summary(lm(medv ~ log(rm), Boston))

# Lab 3.6.6

head(Carseats)

lm.fit <- lm(Sales ~ . + Income:Advertising + Price:Age, Carseats)
summary(lm.fit)

attach(Carseats)
contrasts(ShelveLoc)

?contrasts

# Exercise 6.1

babyweight <- read.table("babyweights.txt", header = TRUE)
lm.fit <- lm(bwt ~ smoke, babyweight)
summary(lm.fit)

#>(a) Write the equation of the regression line
#>      bwt.approx = 123.05 - 8.94(smoke)
#>  
#>(b) Interpret the slope in this context, and calculate the predicted birth weight of babies
#>    born to smoker and non-smoker mothers.
#>      The intercept over here is the average birth weight (in ounces) predicted by the model
#>      for a baby whose mother did not smoke at all during pregnancy.
#>      
#>      Predicted non-smoke = 123.05
#>      Predicted smoke = 123.05 - 8.94 = 114.11
#>      
#>(c) Is there a statistically significant relationship between the average bwt and smoking?
#>      The p-value here is much less than 0 (listed here as 0.0000) so it is very small so there
#>      is a significant relationship between avg bwt and smoking. 

# Exercise 6.2

lm.fit <- lm(bwt ~ parity, babyweight)
summary(lm.fit)

#>(a) Write the equation of the regression line.
#>      120.07 - 1.93(parity)
#>      
#>(b) Interpret the slope in this context, and calculate the predicted birth weight of first borns and others.
#>      The slope here is the predicted average bwt of a first born baby.
#>      
#>      Predicted first born = 120.07
#>      Predicted non-first born = 120.07 - 1.93 = 118.14
#>
#>(c) Is there a statistically significant relationship between avg bwt and parity?
#>      The p-value here is 0.1052 so there is not a significant relationship between avg bwt and parity.

# Exercise 6.3

lm.fit <- lm(bwt ~ ., babyweight)
summary(lm.fit)

#>(a) Write the equation of the regression line that includes all of the variables.
#>      -80.41 + 0.44(gestation) - 3.33(parity) - 0.01(age) + 1.15(height) + 0.05(weight) - 8.40(smoke)
#>      
#>(b) Interpret the slopes of gestation and age in this context.
#>      The slope for gestation here indicates a predicted increase of 0.44 ounces for every
#>      day of gestation. The slope for age shows a predicted decrease of 0.01 ounces for every 
#>      year of the mother's age. 
#>      
#>(c) The coefficient for parity is different than in the linear model in exercise 6.2. 
#>    Why might there be a difference?
#>      This might be bc the pattern of effect is different when comparing just bwt against parity
#>      vs. in addition to all the other variables. I.e. The relationship between parity and bwt is different
#>      than the relationship between bwt and parity in addition with the other variables in the dataset. 
#>      
#>(d) Calculate the residual for the first observation in the data set.
#>      bwt.obs = 120
#>      bwt.pred = -80.41 + 0.44(284) - 3.33(0) - 0.01(27) + 1.15(62) + 0.05(100) - 8.40(0)
#>                = 120.58
#>      residual = bwt.pred - bwt.obs = 120.58 - 120 = 0.58
#>      
#>(e) The variance of the residuals is 249.28 and the variance of the bwts of all babies in the dataset
#>    is 332.57. Calculate the R^2 and the adjusted R^2. Note there are 1,236 observation in the dataset.
#>        R^2 = 1 - (249.28 / 332.57) = 0.2504
#>        
#>        n = 1,236
#>        k = 6
#>        Adjusted R^2 = 1 - (249.28 / 332.57) * (1235 / 1229) = 0.2468


# Lab 5.3.1

set.seed(1)
train <- sample(392,196)

lm.fit <- lm(mpg ~ horsepower, data = Auto, subset = train)

attach(Auto) # error: objects are masked 
mean((mpg - predict(lm.fit, Auto))[-train]^2) # error: non-numeric argument to binary operator

lm.fit2 <- lm(mpg ~ poly(horsepower, 2), data = Auto, subset = train)
mean((mpg - predict(lm.fit2, Auto))[-train]^2) # error: non-numeric argument to binary operator

lm.fit3 <- lm(mpg ~ poly(horsepower, 3), data = Auto, subset = train)
mean((mpg - predict(lm.fit3, Auto))[-train]^2) # error: non-numeric argument to binary operator

set.seed(2)
train <- sample(392, 196)
lm.fit <- lm(mpg ~ horsepower, data = Auto, subset = train)
mean((mpg - predict(lm.fit, Auto))[-train]^2) # error: non-numeric argument to binary operator

# Lab 5.3.2

glm.fit <- glm(mpg ~ horsepower, data = Auto)
coef(glm.fit)

lm.fit <- lm(mpg ~ horsepower, data = Auto)
coef(lm.fit)

library(boot)
glm.fit <- glm(mpg ~ horsepower, data = Auto)
cv.err <- cv.glm(Auto, glm.fit)
cv.err$delta

cv.error <- rep(0, 10)
for (i in 1:10)
{
  glm.fit <- glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error[i] <- cv.glm(Auto, glm.fit)$delta[1]
}
cv.error


# Lab 5.3.3

set.seed(17)
cv.error.10 <- rep(0, 10)
for(i in 1:10)
{
  glm.fit <- glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error.10[i] <- cv.glm(Auto, glm.fit, K = 10)$delta[1]
}
cv.error.10
