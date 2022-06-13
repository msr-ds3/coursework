
#######################table reproduction
library(tidyverse)
library(scales)

library(modelr)
options(na.action = na.warn)

library(broom)

theme_set(theme_bw())
options(repr.plot.width=4, repr.plot.height=3)


body_model <- read.table("body.dat.txt", sep = "")


#reference
# https://stackoverflow.com/questions/10085806/extracting-specific-columns-from-a-data-frame
library(dplyr)
#okay so here is my 2 columns, weight and height
my_table <- body_model %>% select(V23, V24)

#reference https://www.marsja.se/how-to-rename-column-or-columns-in-r-with-dplyr/#:~:text=To%20rename%20a%20column%20in,dataframe%2C%20B%20%3D%20A)%20.
my_table <- my_table %>% rename(weight = V23, height = V24)

#there is a formula given from the website which is Weight (kg) = -105 + 1.018 Height (cm)
#i don't think i can plug in constant numbers though, I think
#i can only give the columns and let the computer do it itself
form <- as.formula(weight ~ height)

model <- lm(form, my_table)
tidy(model)

###################end of table reproduction


#######lab 3.6.3 - 3.6.6
# i think the previous sections need to be run so that these next ones
# can work, so i copy/pasted my commands from last week to just get that out of the way
install.packages("ISLR2")
library(MASS)
library(ISLR2)
head(Boston)
?Boston
lm.fit <- lm(medv ~ lstat, data = Boston)
attach(Boston)
lm.fit <- lm(medv~lstat)
lm.fit
summary(lm.fit)
names(lm.fit)
coef(lm.fit)
confint(lm.fit)
predict(lm.fit, data.frame(lstat = (c(5, 10, 15))), interval = "confidence")
predict(lm.fit, data.frame(lstat = (c(5, 10, 15))), interval = "prediction")
plot (lstat, medv)
abline(lm.fit)
abline(lm.fit, lwd = 3)
abline(lm.fit, lwd = 3, col="red")
plot(lstat,medv,col="red")
plot(lstat,medv,pch=20)
plot(lstat,medv,pch="+")
plot(1:20,1:20,pch = 1:20)
par(mfrow = c(2,2)) 
plot(lm.fit)
plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))
plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))

#okay, now starting 3.6.3

lm.fit <- lm(medv ~ lstat + age, data = Boston)
summary(lm.fit)

lm.fit <- lm(medv ~ ., data = Boston)
summary(lm.fit)


install.packages("car")
library(car)
vif(lm.fit)

lm.fit1 <- lm(medv ~ . - age, data = Boston)
summary(lm.fit1)

lm.fit1 <- update(lm.fit, ~ . - age)

#starting 3.6.4
summary(lm(medv ~ lstat * age, data = Boston))

#starting 3.6.5
lm.fit2 <- lm(medv ~ lstat + I(lstat^2))
summary(lm.fit2)

lm.fit <- lm(medv ~ lstat)
anova(lm.fit, lm.fit2)

par(mfrow = c(2,2))
plot(lm.fit2)

lm.fit5 <- lm(medv ~ poly(lstat, 5))
summary(lm.fit5)

summary(lm(medv ~ log(rm), data = Boston))

#starting 3.6.6
head(Carseats)

lm.fit <- lm(Sales ~ . + Income:Advertising + Price:Age, data = Carseats)
summary(lm.fit)

attach(Carseats)
contrasts(ShelveLoc)

##########################end of lab

##########################beginning of chap 6 questions

# 6.1
#a) bwt = 123.05 - 8.94*smoke
#b) slope: if the person smokes, it'll take away 8.94 ounces of the baby's average weight
#   non-smoker = 123.05      smoker: 114.11
#c) it is statistically significant since the p-value is very close to 0

# 6.2
#a) bwt = 120.05 - 1.93*parity
#b) slope: if the child is not a first born, their average weight goes down by 1.93
    #ounces
    # first-borns: 120.05    non-first-borns: 118.12
#c) no. the p-value is 0.1052. So assuming the alpha is at most 5%, it
#   isn't lower than the threshold to be significant

# 6.3
#a) bwt = -80.41 + .44*gestation - 3.33*parity -.01*age + 1.15*height
#   + .05*weight - 8.40*smoke
#b) for every extra day in gestation, the average birth weight increases by .44 ounces
#   for every year in age, the average birht weight goes down by -.01 ounces
#c) apparently one of the independent variables, such as age or height, was correlated
#   with parity. Since it wasn't included in the previous table, the program couldn't
#   account for that and therefore it biased the variable. Since it's now included, 
#   it's less biased.
#d)
vary <- -80.41 + 284*.44 - 3.33*0 - .01*27 + 1.15*62 +.05*100 - 8.40*0
vary
#the residual is 120.58 - 120 = .58

#e) R^2 = 1 - (var(res)/var(outcome))
my_rsquare = 1- ( 249.28 / 332.57)
my_rsquare
# 0.2504435

my_adj_r = 1- ( (249.28 / (1236 - 6 - 1)) / (332.57 / (1236 - 1) )  )
my_adj_r
# 0.2467842

###########################end of chapter 6 questions

##################replicating tables in quesstions
#6.1
#reference https://www.statology.org/dplyr-error-in-select-unused-arguments/
babies <- read.table("babyweights.txt", sep = "")
baby_smoke <- babies %>%  dplyr::select(bwt, smoke)
form <- as.formula(bwt ~ smoke)

model <- lm(form, baby_smoke)
tidy(model)

#6.2
baby_parity <- babies %>% dplyr::select(bwt, parity)
form <- as.formula(bwt ~ parity)

model <- lm(form, baby_parity)
tidy(model)

#6.3
form <- as.formula(bwt ~ gestation + parity + age + height + weight + smoke)
model <- lm(form, babies)
tidy(model)

######################end of replicating tables

######labs of chapter 5
library(ISLR2)
set.seed(1)
train <- sample(392,196)

lm.fit <- lm(mpg ~ horsepower, data = Auto, subset = train)

attach(Auto)
mean((mpg - predict(lm.fit, Auto))[-train]^2)

lm.fit2 <- lm(mpg ~ poly(horsepower, 2), data = Auto, subset = train)
mean((mpg - predict(lm.fit2, Auto))[-train]^2)

lm.fit3 <- lm(mpg ~ poly(horsepower, 3), data = Auto, subset = train)
mean((mpg - predict(lm.fit3, Auto))[-train]^2)


set.seed(2)
train <- sample(392, 196)
lm.fit <- lm(mpg ~ horsepower, subset = train)
mean((mpg - predict(lm.fit, Auto))[-train]^2)

lm.fit2 <- lm(mpg ~ poly(horsepower, 2), data = Auto, subset = train)
mean((mpg - predict(lm.fit2, Auto))[-train]^2)

lm.fit3 <- lm(mpg ~ poly(horsepower, 3), data = Auto, subset = train)
mean((mpg - predict(lm.fit3, Auto))[-train]^2)


glm.fit <- glm(mpg ~ horsepower, data = Auto)
coef(glm.fit)

lm.fit <- lm(mpg ~ horsepower, data = Auto)
coef(lm.fit)

library(boot)
glm.fit <- glm(mpg ~ horsepower, data = Auto)
cv.err <- cv.glm(Auto, glm.fit)
cv.err$delta

cv.error <- rep(0,10)
for (i in 1:10) {
  glm.fit <- glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error[i] <- cv.glm(Auto, glm.fit)$delta[1]
}
cv.error



set.seed(17)
cv.error.10 <- rep(0,10)
for (i in 1:10) {
  glm.fit <- glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error.10[i] <- cv.glm(Auto, glm.fit, K = 10)$delta[1]
}
cv.error.10
