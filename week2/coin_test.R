library(tidyverse)
library(pwr)

theme_set(theme_bw())

set.seed(42)

# Simulate flipping a coin n times and estimating its bias
estimate_coin_bias <- function(n, p) {
  mean(rbinom(n, 1, p))
}

# Hypothesis test for a coin by simulation (one-sided, greater than)
# Tests H0: p = p0 vs. H1: p > p0
# Mirrors built-in prop.test(x, n, p0, alternative = "greater")
coin_test <- function(x, n, p0 = 0.5, alpha = 0.05, num_sims = 1e4) {
  p_hat <- x / n

  # simulate the null distribution: flip a fair coin n times, many times
  null_dist <- replicate(num_sims, estimate_coin_bias(n, p0))

  # one-sided p-value: how often does the null produce something this large?
  p_value <- mean(null_dist >= p_hat)

  list(p_hat = p_hat, p_value = p_value, reject = p_value < alpha)
}

# Example: flip a coin 100 times and count heads 
n <- 100
x <- sum(rbinom(n, 1, 0.6))
cat(sprintf("Observed %d heads out of %d flips\n", x, n))

# Compare observed flips to the simulated null distribution for a fair coin
coin_test(x, n, p0 = 0.5, alpha = 0.05)

# Compare observed flips to the analytical null distribution for a fair coin
prop.test(x, n, p = 0.5, alternative = "greater")


######################################################################
# False positive rate (Type I error)
# Flip a FAIR coin (p = 0.5) and test H0: p = 0.5 vs H1: p > 0.5
# We should reject about 5% of the time
######################################################################

n <- 100
p_true <- 0.5
p0 <- 0.5
num_experiments <- 200

false_positives <- replicate(num_experiments, {
  x <- sum(rbinom(n, 1, p_true))
  coin_test(x, n, p0, 0.05)$reject
})

cat(sprintf("False positive rate: %.3f (expect ~0.05)\n", mean(false_positives)))


######################################################################
# Power (1 - Type II error)
# Flip a BIASED coin (p = 0.6) and test H0: p = 0.5 vs H1: p > 0.5
# How often do we correctly reject?
######################################################################

p_true <- 0.60
n <- 100
rejections <- replicate(num_experiments, {
  x <- sum(rbinom(n, 1, p_true))
  coin_test(x, n, p0)$reject
})

cat(sprintf("Power (p=0.6, n=100): %.3f\n", mean(rejections)))

# Compare to built-in power calculation
pwr.p.test(h = ES.h(0.6, 0.5), n = 100, sig.level = 0.05, alternative = "greater")


######################################################################
# Sample size calculation
# How many flips do we need for 80% power to detect p = 0.6 vs H0: p = 0.5?
######################################################################

# By simulation: loop over sample sizes and estimate power for each
compute_power <- function(n, p_true, p0, alpha = 0.05, num_experiments = 200) {
  mean(replicate(num_experiments, {
    x <- sum(rbinom(n, 1, p_true))
    coin_test(x, n, p0, alpha)$reject
  }))
}

sample_sizes <- seq(50, 300, by = 50)
power_results <- map_dfr(sample_sizes, function(n) {
  tibble(n = n, power = compute_power(n, p_true = 0.6, p0 = 0.5))
})

ggplot(power_results, aes(x = n, y = power)) +
  geom_line() +
  geom_point() +
  geom_hline(yintercept = 0.80, linetype = 2, color = "red") +
  xlab("Sample size (number of flips)") +
  ylab("Power")

# Using pwr.p.test to solve for n directly
pwr.p.test(h = ES.h(0.6, 0.5), sig.level = 0.05, power = 0.80, alternative = "greater")
