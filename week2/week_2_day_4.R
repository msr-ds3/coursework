# 2.2 a) 45/69, 30/34
# 2.2 b) null hypothesis: the group and outcome variables are independent of each other
#        alt hypothesis: group and outcome variables aren't independent
#      ii) 28, 75, 69, 34, 0, less than the alpha
#     iii) 45/69 - 30/34 = -.23. It is very unlikely that the group and outcome
          # aren't independent

#2.5 a) null hypothesis: scenario and intervene are independent of each other
#     b) alt hypothesis: scenario and intervene aren't independent of each other
#    ii) 5/20 - 15/25 = -.35
#    iii) it looks like it's about 2% since it's captured in the second to leftmost
#        bar, which goes up to about .02

#chapter 9
# 1) i looked at the answer for this, but it makes sense how it works, we're basically
#doing the same thing, which is creating a bar chart of the different results we get
#but in this case, we're doing it for a specific equation

mu1 <- 3.5
sig1 <- 3
mu2 <- 3.5
sig2 <- 1.5
test.stat <- rep(0,10^5)
for(i in 1:10^5)
  {
    X1 <- rnorm(29,mu1,sig1)
    X2 <- rnorm(21,mu2,sig2)
    X1.bar <- mean(X1)
    X2.bar <- mean(X2)
    X1.var <- var(X1)
    X2.var <- var(X2)
    test.stat[i] <- (X1.bar-X2.bar)/sqrt(X1.var/29 + X2.var/21)
  }
quantile(test.stat,c(0.025,0.975))

#2) for this question, we're basically using the magnets table and
#running it through the same equation to see if it falls within 95%
#of the distribution

magnets <- read.csv("magnets.csv")

x1.bar <- mean(magnets$change[1:29])
x2.bar <- mean(magnets$change[30:50])
x1.var <- var(magnets$change[1:29])
x2.var <- var(magnets$change[30:50])
(x1.bar-x2.bar)/sqrt(x1.var/29 + x2.var/21)

#so we can see it doesn't fall within 95%, and we can assume that the 
#magnets treatment and the change in scores aren't independent


