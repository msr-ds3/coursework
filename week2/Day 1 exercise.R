pop2<-read.csv('C:/Users/jane/Downloads/pop2.csv')

#Q1:Compute the population average of the variable “bmi”.
mean(pop2$bmi)

#Q2: Compute the population standard deviation of the variable “bmi”.
sd(pop2$bmi)

#3. Compute the expectation of the sampling distribution for the sample average of the variable.
X.bar = replicate(10^5, mean(sample(pop2$bmi, 150)))
mean(sample_means)
#4. Compute the standard deviation of the sampling distribution for the sample average of the variable.
sd(sample_means)
#5. Identify, using simulations, the central region that contains 80% of the
#sampling distribution of the sample average.
quantile(X.bar,c(0.1,0.9))

#6. Identify, using the Central Limit Theorem, an approximation of the central region that contains 80% of the sampling distribution of the sample
average.
qnorm(c(0.1,0.9),mean(X.bar),sd(X.bar))