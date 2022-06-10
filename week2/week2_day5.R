# 5.20
# a) y - 171.14 = .67(x-108.20) -> y = .67x + 98.646
# b) slope: for each cm gained in shoulder girth, height increases by
#    .67
#    intercept: if someone has 0 shoulder girth, their height is 98.646
# c) corr^2 = .67^2 -> .4488
#    about 45% of the variation in height is explained by shoulder girth
# d) .67(100) + 98.646 = 165.646 cm
# e) residual = 165.646 - 160 = 5.646. This residual means that the model 
#    was off in its prediction by 5.646 cm
# f) No, the average 1 year old height is 75 cm, which is below the minimum of 98.646
#    Also, there's a huge difference in body proportion between babies and adults
#    so it's unlikely that this can translate to babies

# 5.29
# a) for every cm gained in height, weight increases by 1.0176 kg
# b) y = 1.0176x - 105.0113
# slope: for every cm gained in height, weight increases by 1.0176 kg
# intercept: if someone is 0cm tall, their weight is predicted to be -105.0113
# c)null hypothesis: slope is 0
#   alt hypothesis: slope isn't 0 and is positive
#   p-value = 23.13
#   conclusion is that the probability of that p-value occuring in a world where
#   the slope is 0 is 0.000. So we reject the null hypothesis
# d) .72^2 = .5184. 51.84% of weight is explained by height

#lab

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
