library(ISLR2)
library(MASS)
head (Boston)
lm.fit <- lm(medv ~ lstat)
lm.fit <- lm(medv ~ lstat , data = Boston)
attach (Boston)
lm.fit <- lm(medv ~ lstat)

lm.fit

summary (lm.fit)

confint (lm.fit)

predict(lm.fit , data.frame(lstat = (c(5, 10, 15))), interval="confidence")
plot (lstat , medv)
abline (lm.fit)


abline (lm.fit , lwd = 3)
abline (lm.fit , lwd = 3, col = " red ")
plot (lstat , medv , col = " red ")
plot (lstat , medv , pch = 20)
plot (lstat , medv , pch = "+")
plot (1:20, 1:20, pch = 1:20)

par (mfrow = c(2, 2))
plot (lm.fit)

plot ( predict (lm.fit), residuals (lm.fit))
plot ( predict (lm.fit), rstudent (lm.fit))

plot ( hatvalues (lm.fit))
which.max ( hatvalues (lm.fit))