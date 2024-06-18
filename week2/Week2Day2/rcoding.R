library (tidyverse)
data <- read.csv("magnets.csv")

magnets.csv %>% view()
sample_average <- mean(data$change)

average_active <- mean(data$change[1:29]) 
average_inactive <- mean(data$change[30:50])

sd_active <- sd(data$change[1:29])
sd_inactive <- sd(data$change[30:50])

data %>% 
  ggplot(aes(change)) + geom_boxplot(aes(group =active)) 

data2_mean <- replicate(10^5, mean(rnorm(100,3,sqrt(2))))
data2_medians <- replicate(10^5, median(rnorm(100,3,sqrt(2))))
                          
data2_expected_mean <- mean(data2_mean)
data2_median <- median(data2_medians)

data2_mean_variance <- var(data2_mean)
data2_median_variance <- var(data2_medians)


data3_mean <- replicate(10^5, mean(runif(100,0.5,5.5)))
data3_median <- replicate(10^5, median(runif(100,0.5,5.5)))

data3_expected_mean <- mean(data3_mean)
data3_medians <- median(data3_median)

data3_mean_variance <- var(data3_mean)
data3_median <- var(data3_median)

pop2 <- read.csv("pop2.csv")
ex2 <- read.csv("ex2.csv")

ex2 %>%
  mutate(total_rows = n()) %>% group_by(group) %>% 
  filter(group == "HIGH") %>% summarize(n()/total_rows) %>% head(1)

pop2 %>% 
  mutate(total_rows = n()) %>% group_by(group) %>% 
  filter(group == "HIGH") %>% summarize(n()/total_rows) %>% head(1)

P.hat <- rep(0,10^5)
for (i in 1:10^5)
  + {X <- sample(pop2$group,150)
    P.hat[i] <- mean(X == "HIGH")}
mean(P.hat)

var(P.hat)
  
p <- mean(pop2$group == "HIGH")
p*(1-p)/150
