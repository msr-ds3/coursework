library(ISLR2)
library(MASS)
library(dplyr)


lm.fit <- lm(medv ~ lstat + age, data = Boston)
summary (lm.fit)
lm(formula = medv ~ lstat + age , data = Boston)

lm.fit <- lm(medv ~ ., data = Boston)
summary (lm.fit)
install.packages(car)
library (car)
vif (lm.fit)
lm.fit1 <- lm(medv ~ . - age , data = Boston)
summary (lm.fit1)

lm.fit1 <- update (lm.fit , ~ . - age)


summary (lm(medv ~lstat * age , data = Boston))


lm.fit2 <- lm(medv ~lstat + I(lstat^2), data = Boston)
summary (lm.fit2)
lm.fit <- lm(medv ~ lstat, data = Boston)
anova (lm.fit , lm.fit2)

par (mfrow = c(2, 2))
plot (lm.fit2)


lm.fit5 <- lm(medv ~ poly (lstat , 5), data=Boston)
summary (lm.fit5)



summary (lm(medv ~ log(rm), data = Boston))


#3.6.6
head(Carseats)
lm.fit <- lm(Sales ~ . + Income:Advertising + Price:Age, data = Carseats)
summary(lm.fit)

attach (Carseats)
contrasts (ShelveLoc)



