library(tidyverse)

# Question 7.1 - The file "pop2.csv" contains information associated to the
# blood pressure of an imaginary population of size 100,000. The file can be found
# on the internet (http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv).

# Our goal in this question is to investigate the sampling distribution of the sample
# average of the variable "bmi". We assume a sample of size n = 150.

# read in pop2.csv
pop_2 <- read.csv("pop2.csv")
View(pop_2)

# take random samplse from pop_2
x_bar <- rep(0, 10^5)
for(i in 1:10^5)
{
  x_samp <- sample(pop_2$bmi, 150)
  x_bar[i] <- mean(x_samp)
}

View(x_bar)

# 1. Compute the population average of the variable "bmi".

pop_2 %>%
  summarize(mean(bmi))

# Output: 24.98446

# 2. Compute the population standard deviation of the variable "bmi".

pop_2 %>%
  summarize(sd(bmi))

# Output: 4.188511

# 3. Compute the expectation of the sampling distribution for the sample 
# average of the variable.

# older way of finding the expected value using x_bar from above
mean(x_bar)

# newer way of finding the mean of one sample
pop_2 %>%
  sample_n(150) %>%
  pull(bmi) %>%
  mean()

# newer way of finding the expected value
mean(replicate(1e5, mean(sample(pop_2$bmi, size = 150, replace = F))))

# Output: 24.98451

# 4. Compute the standard deviation of the sampling distribution for the sample 
# average of the variable.

sd(x_bar)

# Output: 0.3410542

# 5. Identify, using simulations, the central region that contains 80% of the
# sampling distribution of the sample average.

quantile(x_bar, c(0.1, 0.9))

# Output: 
# 10%      90% 
# 24.54759 25.42333

# 6. Identify, using the Central Limit Theorem, an approximation of the central 
# region that contains 80% of the sampling distribution of the sample average.

qnorm(c(0.1, 0.9), mean(x_bar), sd(x_bar))

# Output: 24.54743 25.42159



