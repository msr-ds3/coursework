library('tidyverse')

# 9.1
magnets <- read.csv('magnets.csv')

# 1
magnets |> summarize(mean(change))

# 2
# "active" is a factor

# 3
magnets |> slice(1:29) |> summarize(mean(change))
magnets |> slice(30:50) |> summarize(mean(change))

# 3
magnets |> slice(1:29) |> summarize(sd(change))
magnets |> slice(30:50) |> summarize(sd(change))


# 4
magnets |>
  ggplot(aes(active, change)) + 
  geom_boxplot()


# 10.1
cars <- read.csv('cars.csv')


# 1
mu <- 3
sig <- sqrt(2)
norm.bar <- rep(0,10^5)
norm.med <- rep(0,10^5)
for(i in 1:10^5)
{
  norm <- rnorm(100, mu, sig)
  norm.bar[i] <- mean(norm)
  norm.med[i] <- median(norm)
}

#mean
mean(norm.bar)
mean(norm.med)

#variance
var(norm.bar)
var(norm.med)

# 2
mi <- 0.5
mx <- 5.5
uni.bar <- rep(0,10^5)
uni.med <- rep(0,10^5)
for(i in 1:10^5)
{
  uni <- runif(100, mi, mx)
  uni.bar[i] <- mean(uni)
  uni.med[i] <- median(uni)
}

#mean
mean(uni.bar)
mean(uni.med)

#variance
var(uni.bar)
var(uni.med)



# 10.2
pop <- read.csv("pop2.csv")
ex <- read.csv("ex2.csv")

#1
table(ex$group)
high_prop_smpl <- 37/150

#2
table(pop$group)
high_prop_pop <- 28126/100000

#3
P.hat <- rep(0, 10^5)
for (i in 1:10^5) 
{
  X <- sample(pop$group, 150)
  P.hat[i] <- mean(X == "HIGH")
}
mean(P.hat)

#4
var(P.hat)

#5
high_prop_pop*(1 - high_prop_pop)/150
