
#chapter 7
pop.2 <- read.csv("pop2.csv")

#1 and 2
mean(pop.2$bmi)
sd(pop.2$bmi)


#3 and 4
X.bar <- rep(0,10^5)
for(i in 1:10^5)
{
  X.samp <- sample(pop.2$bmi,100)
  X.bar[i] <- mean(X.samp)
}

#hist(X.bar)

mean(X.bar)
sd(X.bar)


#5 and 6
quantile(X.bar,c(0.1,0.9))
qnorm(c(0.1,0.9),mean(X.bar),sd(X.bar))



#chapter 9

magnets <- read.csv("magnets.csv")
summary(magnets)

#sample avg
mean(magnets$change)

# 2 factor, since the numeric vars aren't numbers in a meaningful sense
#they could be subbed in with a Y and N. Every item's also stored in quotes

# 3 and 4
active <- magnets$change[1:29]
mean(active)
sd(active)
plac <- magnets$change[30:50]
mean(plac)
sd(plac)

#5
boxplot(active)
#the one's given real meds have no outliers
boxplot(plac)
#the placebo group has 3 values that are considered, so we'll
#use table to see if there's any overlap
table(plac)
#so there's 4 total outliers



#chapter 10

#1 this is basically the same as the example in the book
#only difference is that we're also making a sample distribution of the median
mu <- 3
sig <- sqrt(2)
X.bar <- rep(0,10^5)
X.med <- rep(0,10^5)
for(i in 1:10^5)
  {
    X <- rnorm(100,mu,sig)
    X.bar[i] <- mean(X)
    X.med[i] <- median(X)
    }

#hist(X.bar)
#hist(X.med)

mean(X.bar)
var(X.bar)

mean(X.med)
var(X.med)



#2 uniform. Again the same as in the text, just with the median as well

a <- 0.5
b <- 5.5
X.bar <- rep(0,10^5)
X.med <- rep(0,10^5)
for(i in 1:10^5)
  {
    X <- runif(100,a,b)
    X.bar[i] <- mean(X)
    X.med[i] <- median(X)
  }


#hist(X.bar)
#hist(X.med)

mean(X.bar)
var(X.bar)

mean(X.med)
var(X.med)



#10.2 
#1
library(tidyverse)

ex.2 <- read.csv("ex2.csv")
table(ex.2$group)
# so mean is 37/150 = .2467

#2
table(pop.2$group)
# so mean here is 28126/100000 = .2813


#3 so its how many have high bp

X.bar <- rep(0,10^5)
for(i in 1:10^5)
{
  X.samp <- sample(pop.2$group,150)
  X.bar[i] <- mean(X.samp == "HIGH")
}
#hist(X.bar)
mean(X.bar)

#4
var(X.bar)


#5 
#so the mean is .2814 and n is 150
# .2814(1 - .2814) / 150 = .0013