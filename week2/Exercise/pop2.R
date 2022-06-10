library(tidyverse)
library(lubridate)

pop2 <- read_csv("pop2.csv")

#1 - Average BMI
mean(pop2$bmi)

#2 - SD BMI
sd(pop2$bmi)

#3 Mean
exp <- rep(0,10^5)
for(i in 1:10^5)
{
  test <- sample(pop2$bmi,150)
  exp[i] <- mean(test)
}    
mean(exp)

#4 SD
sd(exp)

# 5 Central region
quantile(exp, c(0.1, 0.9))

#6  Estimated Central region
qnorm(c(0.1, 0.9), mean(exp), sd(exp))


magnets <- read.csv("magnets.csv")
#9.1
summary(magnets)

#9.2
# Variable active is a factor

#9.3
mean(magnets$change[1:29])
mean(magnets$change[30:50])

#9.4
sd(magnets$change[1:29])
sd(magnets$change[30:50])

#9.5
boxplot(magnets$change[1:29])
