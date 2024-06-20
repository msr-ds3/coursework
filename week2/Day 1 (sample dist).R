library(tidyverse)

# ---6.1---

# 8ppl -- mean: 560kg, sd: 57kg
# 9ppl -- mean: 630kg, sd: 61kg

# 1
1 - pnorm(650, 560, 57)

# 2
1 - pnorm(650, 630, 61)

# 3 
qnorm(.9, 560, 57)
qnorm(.1, 560, 57)


# 4
qnorm(.9, 630, 61)
qnorm(.1, 630, 61)

# ---7.1---
pop <- read.csv("pop2.csv")

# 1
pop |> summarize(mean(bmi))

# 2
pop |> summarize(sd(bmi))


# smaple 
bmi.bar <- rep(0, 10^5)
for (i in 1:10^5)
{
  bmi.samp <- sample(pop$bmi, 150)
  bmi.bar[i] <- mean(bmi.samp)
}


# 3
mean(bmi.bar)

# 4
sd(bmi.bar)

# 5
quantile(bmi.bar, .9)
quantile(bmi.bar, .1)

# 6
qnorm(.9, mean(bmi.bar), sd(bmi.bar))
qnorm(.1, mean(bmi.bar), sd(bmi.bar))
