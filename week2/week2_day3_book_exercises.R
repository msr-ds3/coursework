# Chapter 7 exercises
# 7.1
# 1. Population average of the variable bmi = 24.98446
pop2 <- read_csv("pop2.csv")
mean(pop2$bmi)
# 2. Population standard deviation of the variable bmi = 4.188511
sd(pop2$bmi)
# 3. Expectation of the sampling distribution for the sample average of bmi = 24.98543
samp_dis <- rep(0, 10^5)
for(i in 1:10^5)
{
    samp_dis_Sample <- sample(pop2$bmi, 150)
    samp_dis[i] <- mean(samp_dis_Sample)
}
mean(samp_dis)
# 4. Standard deviation of the sampling distribution for the sample average of bmi = 0.3420798
sd(samp_dis)
# 5. The central region that contains 80% of the sampling distribution of the sample average = [24.55021, 25.42505]
quantile(samp_dis, c(0.1, 0.9))
# 6. Approximation of the central region that contains 80% of the sampling distribution of the sample average using the Central Limit Theorem = [24.54704, 25.42382]
qnorm(c(0.1, 0.9), mean(samp_dis), sd(samp_dis))

# Chapter 9 exercises
# 9.1
# 1. The sample average of the change in score between the patient's rating before the application and after the application of the device = 3.5 (The mean of the change column)
magnets <- read_csv()
summary(magnets)
# 2. The variable active is a factor.
# 3. Average value of the variable change for the patients that received an active magnet =  5.241379
#    Average value of the variable change for the patinets that received an inactive placebo = 1.095238
mean(magnets$change[1:29])
mean(magnets$change[30:50])
# 4. Standard deviation of the variable change for the patients that received an active magnet = 3.236568
#    Standard deviation of the variable change for the patients that received an inactive placebo = 1.578124
sd(magnets$change[1:29])
sd(magnets$change[30:50])
# 5. Number of outliers of the variable change for the patients that received an active magnet = 0
#    Number of outliers of the variable change for the patients that received an inactive placebo = 4
boxplot(magnets$change[1:29])
boxplot(magnets$change[30:50])
table(magnets$change[30:50])

# Chapter 10 exercises
# 10.1
# 1. The estimator that has a smaller mean square error = sample average
mu <- 3
sig <- sqrt(2)
X.bar <- rep(0, 10^5)
X.med <- rep(0, 10^5)
for(i in 1:10^5)
{
    X <- rnorm(100, mu, sig)
    X.bar[i] <- mean(X)
    X.med[i] <- media(X)
}
mean(X.bar)
mean(X.med)
var(X.bar)
var(X.med)
# 2. The estimator that has a smaller mean square error = sample average
a <- 0.5
b <- 5.5
X.bar <- rep(0, 10^5)
X.med <- rep(0, 10^5)
for(i in 1:10^5)
{
    X <- runif(100, a, b)
    X.bar[i] <- mean(X)
    X.med[i] <- median(X)
}
mean(X.bar)
mean(X.med)
var(X.bar)
var(X.med)
#10.2
# 1. Proportion in the sample of those with a high level blood pressure =  0.2466667
ex2 <- read.csv("ex2.csv")
summary(ex2)
37/150
mean(ex2$group == "HIGH")
# 2. Proportion in the population of those with a high level blood pressure = 0.28126
pop2 <- read.csv("pop2.csv")
mean(pop2$group == "HIGH")
# 3. Expectation of the sampling distribution =  0.2812307
P.hat <- rep(0,10^5)
for(i in 1:10^5)
{
    X <- sample(pop2$group,150)
    P.hat[i] <- mean(X == "HIGH")
}
mean(P.hat)
# 4. Variance of the sample proportion = 0.001350041
var(P.hat)
# 5.
p <- mean(pop2$group == "HIGH")
p*(1-p)/150