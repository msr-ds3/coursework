# Read section 5.1 of An Introduction to Statistical Learning on cross-validation 

# Do labs 5.3.1, 5.3.2, and 5.3.3

library(ISLR2)
set.seed(1)

# Split the data into training and testing samples
train <- sample(392, 196)
# This notation allows us to train a model using data only from the subset
lm.fit <- lm(mpg ~ horsepower, data = Auto, subset = train)

attach(Auto)

# This calculates the MSE for this model
# mean() function will calculate the MSE of the 196 observations in the validation set 
# ([-train] index selects only the observations not in the training set)
mean((mpg - predict(lm.fit, Auto))[-train]^2)

# Calculate the MSE for other powers
lm.fit2 <- lm(mpg ~ poly(horsepower, 2), data = Auto,
              subset = train)
mean((mpg - predict(lm.fit2, Auto))[-train]^2)

lm.fit3 <- lm(mpg ~ poly(horsepower, 3), data = Auto,
              subset = train)
mean((mpg - predict(lm.fit3, Auto))[-train]^2)

# This only calculates the MSE for one training and validation set

# glm() and cv.glm() can be used to estimate LOOCV value
# LOOCV = Leave one out cross validation
library(boot) # includes cv.glm()
glm.fit <- glm(mpg ~ horsepower, data = Auto)
cv.err <- cv.glm(Auto, glm.fit) # Runs the LOOCV algorithm
cv.err$delta

# Repeat the test for different order polynomials
cv.error <- rep(0, 10)
for (i in 1:10) {
  glm.fit <- glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error[i] <- cv.glm(Auto, glm.fit)$delta[1]
}
cv.error

# The cv.glm() function can also be used to implement k-fold CV
set.seed(17)
cv.error.10 <- rep(0, 10)
for (i in 1:10) {
  glm.fit <- glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error.10[i] <- cv.glm(Auto, glm.fit, K = 10)$delta[1] # Run k-fold by specifiying the k value
}
cv.error.10


# Think about a power analysis for the "Is yawning contagious" experiment in Exercise 2.6 of Intro to Stat with Randomization and Simulation (ISRS). 
# What's your estimate of the power from the experiment that was run? 
# How big of an experiment would you run if you could design the experiment yourself

# Power calculations
# n = 50 (34 treatment, 16 control) "use 25 to be more conservative"
# p1 (probability in control group)   : 0.75 not yawn (12/16)
# p2 (probability in treatment group) : 0.7059 not yawn (24/34)
power.prop.test(n = 25, p1=0.2941176, p2=0.25, sig.level=0.05, alternative="one.sided")
# Power is 0.03558882 in the experiment that was run
# 3.56% of the time we will correctly reject null

# If I could design the experiment myself:
# I would want a power of 80% or more
power.prop.test(p1=0.72, p2=0.7059, sig.level=0.05, power=0.80, alternative="two.sided")
# Calculations show that I would need n = 16157.88 for 80% power
