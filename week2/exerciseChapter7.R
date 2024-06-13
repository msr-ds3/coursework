library(tidyverse)

pop.2 <- read.csv("C:/Users/fabio/Documents/coursework/week1/pop2.csv")


head(pop.2) %>% view()

# pop average
mean(pop.2$bmi)

# standard deviation
sd(pop.2$bmi)

# expectation of sampling distribution
sample_means <- replicate(1000, mean(sample(pop.2$bmi, 150)))
expectation_sampling_distribution <- mean(sample_means)
print(expectation_sampling_distribution)

#standard deviation of sample average
sd(sample_means)

# central region containing 80 % of the sampling distribution
quantile(sample_means,c(0.1,0.9))

# Normal approximation 
qnorm(c(0.1,0.9),mean(sample_means),sd(sample_means))

