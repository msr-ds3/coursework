library(ggplot2)
library(tidyverse)
# CHAPTER 7 
pop.2 <- read.csv(file="pop2.csv")
ex.2 <- read.csv(file="ex2.csv")

# 1. Compute the population average of the variable “bmi”.
mean(pop.2$bmi)
# 24.98446

# 2. Compute the population standard deviation of the variable “bmi”.
sd(pop.2$bmi)
# 4.188511

# 3. Compute the expectation of the sampling distribution for the sample average of the variable.
p_hat <- replicate(1e5, mean(sample(pop.2$bmi, 150)))
expectation <- mean(p_hat)
# 24.98435

# 4. Compute the standard deviation of the sampling distribution for the sample average of the variable. 
# --> this is really the standard error
sd(p_hat)
# 0.3399277
# n = 150
# sd of sample avg distribution = standard deviation of a single measurement = 4.189 / sqrt(sample size = 150)



# 5. Identify, using simulations, the central region that contains 80% of the
# sampling distribution of the sample average.
quantile(p_hat, c(0.1, 0.9))
#     10%      90% 
# 24.54850 25.42085 

# 6. Identify, using the Central Limit Theorem, an approximation of the central region that contains 80% of the sampling distribution of the sample
# average.
qnorm(c(0.1,0.9),mean(p_hat),sd(p_hat))
# 24.54872 25.41999

#CHAPTER 9
mg <- read.csv(file="magnets.csv")
summary(mg)

# 1. What is the sample average of the change in score between the patient’s
# rating before the application of the device and the rating after the application?
mean(mg$change)
# 3.5

# 2. Is the variable “active” a factor or a numeric variable?
# it's a factor because there are 2 levels to it 


# 3. Compute the average value of the variable “change” for the patients that
# received and active magnet and average value for those that received an
# inactive placebo. (Hint: Notice that the first 29 patients received an active
#                    magnet and the last 21 patients received an inactive placebo. The subsequence of the first 29 values of the given variables can be obtained via
#                    the expression “change[1:29]” and the last 21 vales are obtained via the
#                    expression “change[30:50]”.)
mean(mg$change[1:29]) # change for patients who received active magnet
# 5.241379
mean(mg$change[30:50]) # change for patients who received inactive placebo
# 1.095238

# 4. Compute the sample standard deviation of the variable “change” for the
# patients that received and active magnet and the sample standard deviation for those that received an inactive placebo.
sd(mg$change[1:29]) # change for patients who received active magnet
# 3.236568
sd(mg$change[30:50]) # change for patients who received inactive placebo
# 1.578124

# 5. Produce a boxplot of the variable “change” for the patients that received
# and active magnet and for patients that received an inactive placebo.
# What is the number of outliers in each subsequence?
ggplot(mg) + geom_boxplot(mapping = aes(x = change)) + facet_wrap(~active)

#CHAPTER 10

#Q1
# 1. Simulate the sampling distribution of average and the median of a sample
# of size n = 100 from the Normal(3, 2) distribution. Compute the expectation and the variance of the sample average and of the sample median.
# Which of the two estimators has a smaller mean square error?
# Normal(µ, σ2)

# note: expectation of measurement = 3

# average sample distribution
samp_distr_avg <- replicate(1e5, mean(rnorm(100, 3, sqrt(2))))
expectation_avg <- mean(samp_distr_avg) # 2.999458
var_avg <- var(samp_distr_avg) # 0.02007265

# median sample distribution
samp_distr_median <- replicate(1e5, median(rnorm(100, 3, sqrt(2))))
expectation_median <- mean(samp_distr_median) # 2.999568
var_median <- var(samp_distr_median) # 0.03076406

# sample average distribution's estimator has a smaller sqr error than the median one 


# 2. Simulate the sampling distribution of average and the median of a sample
# of size n = 100 from the Uniform(0.5, 5.5) distribution. Compute the
# expectation and the variance of the sample average and of the sample
# median. Which of the two estimators has a smaller mean square error?
# average sample distribution
samp_distr_avg <- replicate(1e5, mean(runif(100, 0.5, 5.5)))
expectation_avg <- mean(samp_distr_avg) # 3.000562
var_avg <- var(samp_distr_avg) # 0.02078524

# median sample distribution
samp_distr_median <- replicate(1e5, median(runif(100, 0.5, 5.5)))
expectation_median <- mean(samp_distr_median) # 2.999431
var_median <- var(samp_distr_median) # 0.06045023

#  samp avg's mean square error < samp median's mean square error 



#Q2
# 1. Compute the proportion in the sample of those with a high level of blood
# pressure

nrow(filter(ex.2, group == "HIGH"))/nrow(ex.2) # 37/150 = 0.2466667

# 2. Compute the proportion in the population of those with a high level of
# blood pressure.
nrow(filter(pop.2, group == "HIGH"))/nrow(pop.2) # 0.28126

# 3. Simulate the sampling distribution of the sample proportion and compute
# its expectation.

sampl_distr <- replicate(1e5, mean(sample(pop.2$group == "HIGH", 150)))
exp <- mean(sampl_distr) # 0.2810219

# 4. Compute the variance of the sample proportion.
var <- var(sampl_distr) # 0.001348934

# 5. It is proposed in Section 10.5 that the variance of the sample proportion
# is Var(Pˆ) = p(1 − p)/n, where p is the probability of the event (having a
#     high blood pressure in our case) and n is the sample size (n = 150 in our
# case). Examine this proposal in the current setting.
# Var(P) = p(1 − p)
# Var(P^) = Var(P) / n
# in random sampling -->  E(Pˆ) = p
var_2 <- exp * (1 - exp) #0.2020486
var_mean <- var_2/150 #0.001346991 --> very similar to previously computed var in qst 4
