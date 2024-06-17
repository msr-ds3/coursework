#Exercise 1
library(tidyverse)
library(ggplot2)


bodystat <- read.table("C:/Users/jane/Downloads/body.dat.txt")

#convert to dataframe
as.data.frame.matrix(bodystat)

model <- lm(V23~V24, data = bodystat)
summary(model)


#Lab 3.6.3
library(MASS)
install.packages("ISLR2")
library(ISLR2)

head(Boston)

lm.fit <- lm(medv ~ lstat + age, data = Boston)

summary(lm.fit)

lm.fit <- lm(medv ~ ., data = Boston)

summary(lm.fit)

summary(lm.fit)$r.sq

summary(lm.fit)$sigma

library(car)
vif(lm.fit)

lm.fit1 <- lm(medv ~ . - age, data = Boston)
summary(lm.fit1)

#3.6.4
summary(lm(medv ~ lstat * age, data = Boston))

#3.6.5
lm.fit2 <- lm(medv ~ lstat + I(lstat^2))
summary(lm.fit2)

lm.fit <- lm(medv ~ lstat)
anova(lm.fit, lm.fit2)

 par(mfrow = c(2, 2))
  plot(lm.fit2)
  
lm.fit5 <- lm(medv ~ poly(lstat, 5))
summary(lm.fit5)

#3.6.6
head(Carseats)
lm.fit <- lm(Sales ~ . + Income:Advertising + Price:Age, data = Carseats)
summary(lm.fit)

attach(Carseats)
contrasts(ShelveLoc)

#Exercise 6.1
babyweight <- read.csv('C:/Users/jane/Downloads/babyweights.txt')

