# Chapter 7

# 7.1
pop2 <- read.csv(file = 'pop2.csv')

# 1. Compute the population average of the variable “bmi”.
popavg = mean(pop2$bmi)
popavg

# 2. Compute the population standard deviation of the variable “bmi”.
popsd = sd(pop2$bmi)
popsd

# 3. Compute the expectation of the sampling distribution for the sample 
#    average of the variable.
popbar <- rep(0,10^5)
for(i in 1:10^5)
{
  popsamp <- sample(pop2$bmi, 150)
  popbar[i] <- mean(popsamp)
}
mean(popbar)

#Alternative method
p_hat <- replicate(1e5, mean(sample(pop2$bmi, 150)))
expectation <- mean(p_hat)
expectation

# 4. Compute the standard deviation of the sampling distribution for the 
#    sample average of the variable.
sd(popbar) # actually the standard error

# 5. Identify, using simulations, the central region that contains 80% of the
# sampling distribution of the sample average.
quantile(popbar, c(0.1, 0.9))

# 6. Identify, using the Central Limit Theorem, an approximation of the 
#    central region that contains 80% of the sampling distribution of the sample
#    average
qnorm(c(0.1, 0.9), mean(popbar), sd(popbar))


# Chapter 9

# 9.1
magnets <- read.csv(file = 'magnets.csv')
summary(magnets)

# 1. What is the sample average of the change in score between the patient’s
#    rating before the application of the device and the rating after the 
#    application?
mean(magnets$change)
  # 3.5

#   2. Is the variable “active” a factor or a numeric variable?

  # The variable "active" is a factor, there isn't any numeric data that can
  # be used from this variable, since it's just classifying whether the 
  # patients received the inactive placebo or the active magnet, which are
  # strings.

# 3. Compute the average value of the variable “change” for the patients that
# received and active magnet and average value for those that received an
# inactive placebo. 
#   (Hint: Notice that the first 29 patients received an active
#    magnet and the last 21 patients received an inactive placebo. 
#    The subsequence of the first 29 values of the given variables 
#    can be obtained via the expression “change[1:29]” and the last 
#    21 values are obtained via the expression “change[30:50]”.)

mean(magnets$change[1:29])
  # Active magnet mean = 5.241379

mean(magnets$change[30:50])
  # Inactive placebo mean = 1.095238

# 4. Compute the sample standard deviation of the variable “change” for the
#    patients that received and active magnet and the sample standard deviation 
#    for those that received an inactive placebo.

sd(magnets$change[1:29])
# Active magnet sd = 3.236568

sd(magnets$change[30:50])
# Inactive placebo sd = 1.578124

# 5. Produce a boxplot of the variable “change” for the patients that received
#    and active magnet and for patients that received an inactive placebo.
#    What is the number of outliers in each subsequence?

boxplot(magnets$change[1:29])
  # 0 outliers

boxplot(magnets$change[30:50])
table(magnets$change[30:50])
  # 4 outliers --> there are two outliers at 4


#Chapter 10

# Question 10.1. In Subsection 10.3.2 we compare the average against the 
# mid-range as estimators of the expectation of the measurement. The goal of this
# exercise is to repeat the analysis, but this time compare the average to the
# median as estimators of the expectation in symmetric distributions.

# 1. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Normal(3, 2) distribution. Compute the expectation 
#    and the variance of the sample average and of the sample median.
#    Which of the two estimators has a smaller mean square error?

mu <- 3
sig <- sqrt(2)

normdist <- rep(0,10^5)
normmed <- rep(0,10^5)
for(i in 1:10^5)
{
  normsamp <- rnorm(100, mu, sig)
  normdist[i] <- mean(normsamp)
  normmed[i] <- median(normsamp)
}

mean(normdist)
var(normdist)

mean(normmed)
var(normmed)

  # The sample average has a smaller mean square error than the sample median
  # since the variance of the sample average is smaller than that of the
  # sample median.

# 2. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Uniform(0.5, 5.5) distribution. Compute the
#    expectation and the variance of the sample average and of the sample
#    median. Which of the two estimators has a smaller mean square error?

unifdist <- rep(0,10^5)
unifmed <- rep(0,10^5)
for(i in 1:10^5)
{
  unifsamp <- runif(100, min = 0.5, max = 5.5)
  unifdist[i] <- mean(unifsamp)
  unifmed[i] <- median(unifsamp)
}

mean(unifdist)
var(unifdist)

mean(unifmed)
var(unifmed)

  # The mean square error of the sample average is smaller than that of the
  # sample median.


# Question 10.2. The goal in this exercise is to assess estimation of a proportion
# in a population on the basis of the proportion in the sample.
# The file “pop2.csv” was introduced in Exercise 7.1 of Chapter 7. This file
# contains information associated to the blood pressure of an imaginary 
# population of size 100,000. One of the variables in
# the file is a factor by the name “group” that identifies levels of blood pressure.
# The levels of this variable are “HIGH”, “LOW”, and “NORMAL”.
# The file “ex2.csv” contains a sample of size n = 150 taken from the given
# population. It contains the same variables
# as in the file “pop2.csv”. The file “ex2.csv” corresponds in this exercise to
# the observed sample and the file “pop2.csv” corresponds to the unobserved
# population.

# Download both files to your computer and answer the following questions:
pop2file <- read.csv(file = 'pop2.csv')
ex2 <- read.csv(file = 'ex2.csv')

#   1. Compute the proportion in the sample of those with a high level of blood
# pressure.

mean(ex2$group == 'HIGH')
  # 0.2466667

# 2. Compute the proportion in the population of those with a high level of
# blood pressure.

mean(pop2file$group == 'HIGH')
  # 0.28126

# 3. Simulate the sampling distribution of the sample proportion and compute
# its expectation.

p_hat1 <- replicate(1e5, mean(sample(pop2file$group == 'HIGH', 150)))
expectation1 <- mean(p_hat1)
expectation1

# 4. Compute the variance of the sample proportion.

variance1 <- var(p_hat1)
variance1

# 5. It is proposed in Section 10.5 that the variance of the sample proportion
# is Var(Pˆ) = p(1 − p)/n, where p is the probability of the event 
# (having a high blood pressure in our case) and n is the sample size 
# (n = 150 in our case). Examine this proposal in the current setting.

probability <- mean(pop2$group == 'HIGH')
probability*(1-probability)/150

  # The proposed variance here is 0.001347685 which is very similar to the 
  # variance found in the previous question of 0.001345185 (obtained in the 
  # simulaton). 



