library(tidyverse)

####################################################################################
# IST Chapter 9, Exercise 9.1
magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")

# 1. What is the sample average of the change in score between the
#    patient's rating before the application of the device and the
#    rating after the application?
    p1_q1_avg <- mean(magnets$change)
    p1_q1_avg
    # OUTPUT: 3.5

# 2. Is the variable "active" a factor or a numeric variable?
#       The variable active is a factor. Two possible characters, 1 or 2.

# 3. Compute the average value of the variable "change" for the patients that
#    received an active magnet and average value for those that received an
#    inactive placebo. (Hint: Notice that the first 29 patients received an
#    active magnet and the last 21 patients received an inactive placebo. The
#    subsequence of the first 29 values can be obtained via "change[1:29]" and
#    the last 21 values via "change[30:50]".)

    p1_q2_active_avg <- mean(magnets$change[1:29])
    p1_q2_active_avg
    # OUTPUT: 5.2414
    p1_q2_inactive_avg <- mean(magnets$change[30:50])
    p1_q2_inactive_avg
    # OUTPUT: 1.0953

    # tidy version
    magnets %>%
    group_by(active) %>%
    summarize(avg = mean(change))
    # OUTPUT 5.24
    #        1.10

# 4. Compute the sample standard deviation of the variable "change" for the
#    patients that received an active magnet and the sample standard deviation
#    for those that received an inactive placebo.
    p1_q3_active_sd <- sd(magnets$change[1:29])
    p1_q3_active_sd
    # OUTPUT: 3.2365
    p1_q3_inactive_sd <- sd(magnets$change[30:50])
    p1_q3_inactive_sd
    # OUTPUT: 1.5781
    
    # tidy version
    magnets %>%
    group_by(active) %>%
    summarize(sd = sd(change))
    # OUTPUT: 3.24
    #         1.58

# 5. Produce a boxplot of the variable "change" for the patients that received
#    an active magnet and for patients that received an inactive placebo. What
#    is the number of outliers in each subsequence?

    magnets %>%
        group_by(active) %>%
        ggplot(aes(x = active, y = change)) +
        geom_boxplot() +
        labs(x = "is_active", title = "Change in patients given active/inactive drug")

####################################################################################
# IST Chapter 10, Exercise 10.1
#
# In Subsection 10.3.2 we compare the average against the midrange as estimators
# of the expectation of the measurement. The goal of this exercise is to repeat
# the analysis, but this time compare the average to the median as estimators of
# the expectation in symmetric distributions.
#
# 1. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Normal(3, 2) distribution. Compute the expectation
#    and the variance of the sample average and of the sample median. Which of
#    the two estimators has a smaller mean square error?
    mu <- 3
    sig <- sqrt(2)
    X_bar <- rep(0, 1e5)
    X_median <- rep(0, 1e5)
    for (i in 1:1e5) {
        X <- rnorm(100, mu, sig)
        X_bar[i] = mean(X)
        X_median[i] = median(X)
    }
    X_bar_avg <- mean(X_bar)
    X_bar_var <- var(X_bar)
    X_bar_avg
    X_bar_var
    # OUTPUT -> avg: 3.000 var -> 0.01997
    X_median_avg <- mean(X_median)
    X_median_var <- var(X_median)
    X_median_avg
    X_median_var
    # OUTPUT -> avg: 3.0000 var -> 0.03096

    X_bar_bias <- mu - X_bar_avg
    X_bar_bias
    X_bar_mse <- X_bar_var + X_bar_bias^2
    X_bar_mse
    # OUTPUT 0.01997

    X_median_bias <- mu - X_median_avg
    X_median_bias
    X_median_mse <- X_median_var + X_median_bias^2
    X_median_mse
    # OUTPUT 0.0309

    # For an unbiased estimator, the variance is essentially the same as the MSE
    # The sample average has the smaller mean squared error, by around 0.01

#
# 2. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Uniform(0.5, 5.5) distribution. Compute the
#    expectation and the variance of the sample average and of the sample
#    median. Which of the two estimators has a smaller mean square error?
    mu <- (0.5 + 5.5) / 2
    sig <- (5.5 - 0.5)^2 / 12
    X_bar <- rep(0, 1e5)
    X_median <- rep(0, 1e5)
    for (i in 1:1e5) {
        x <- runif(100, 0.5, 5.5)
        X_bar[i] = mean(x)
        X_median[i] = median(x)
    }
    X_bar_avg <- mean(X_bar)
    X_bar_var <- var(X_bar)
    X_median_avg <- mean(X_median)
    X_median_var <- var(X_median)
    X_bar_avg
    X_bar_var
    # OUTPUT -> avg: 3.000365 var -> 0.0209
    X_median_avg
    X_median_var
    # OUTPUT -> avg: 2.99998 var -> 0.0607

    X_bar_bias <- mu - X_bar_avg
    X_bar_bias
    X_bar_mse <- X_bar_var + X_bar_bias^2
    X_bar_mse
    # OUTPUT 0.0208

    X_median_bias <- mu - X_median_avg
    X_median_bias
    X_median_mse <- X_median_var + X_median_bias^2
    X_median_mse
    # OUTPUT 0.0607

    # Similar to question one, for an unbiased estimator, the mse is essentially the 
    # same as the variance. In this case, the sample average also has the smaller mse.

####################################################################################
# IST Chapter 10, Exercise 10.2
#
# The goal in this exercise is to assess estimation of a proportion in a
# population on the basis of the proportion in the sample.
#
# The file "pop2.csv" was introduced in Exercise 7.1 of Chapter 7. This file
# contains information associated to the blood pressure of an imaginary
# population of size 100,000. One of the variables in the file is a factor by
# the name "group" that identifies levels of blood pressure. The levels of this
# variable are "HIGH", "LOW", and "NORMAL".
#
# The file "ex2.csv" contains a sample of size n = 150 taken from the given
# population. The file "ex2.csv" corresponds to the observed sample and the file
# "pop2.csv" corresponds to the unobserved population.

pop2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv")
ex2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/ex2.csv")

# 1. Compute the proportion in the sample of those with a high level of blood
#    pressure.
    ex2 %>%
    group_by(group) %>%
    summarize(count = n())

    mean(ex2$group == "HIGH")

    # Proportion in the sample with HIGH blood pressure is 37/150 = 0.24667bar

# 2. Compute the proportion in the population of those with a high level of
#    blood pressure.
    pop2 %>%
    group_by(group) %>%
    summarize(count = n())

    mean(pop2$group == "HIGH")

    # Proportion in the population with HIGH blood pressue is 28126/100000 = 0.2812

# 3. Simulate the sampling distribution of the sample proportion and compute
#    its expectation.
    pop2_prop_bar = replicate(1e5, mean(sample(pop2$group, 150) == "HIGH"))
    pop2_prop_expected = mean(pop2_prop_bar)
    pop2_prop_expected
    # OUTPUT: 0.28099

# 4. Compute the variance of the sample proportion.
    pop2_prop_variance = var(pop2_prop_bar)
    pop2_prop_variance
    # OUTPUT: 0.001338

# 5. It is proposed in Section 10.5 that the variance of the sample proportion
#    is Var(P_hat) = p(1 - p)/n, where p is the probability of the event (having
#    a high blood pressure in our case) and n is the sample size (n = 150 in our
#    case). Examine this proposal in the current setting.
    ex2_variance = (0.2812 * (1 - 0.2812)) / 150
    ex2_variance
    # OUTPUT: 0.001347
    # It seems accurate, the numbers are only off by a little bit

####################################################################################
# ISRS Exercise 2.2 - Heart transplants, Part II
#
# Exercise 1.50 introduces the Stanford Heart Transplant Study. Of the 34
# patients in the control group, 4 were alive at the end of the study. Of the 69
# patients in the treatment group, 24 were alive.
#
# Contingency table:
#                                    Group
#                       --------------------------
#                        Control  Treatment  Total
#          ---------------------------------------
#                Alive      4        24       28
#          ---------------------------------------
#  Outcome       Dead       30       45       75
#          ---------------------------------------
#                Total      34       69      103
#          ---------------------------------------
#
# (a) What proportion of patients in the treatment group and what proportion
#     of patients in the control group died?
#       In the treatment group, 45/69 or .6522 of patients died       
#       In the control group, 30/34 or .8824 of patients died
#       .6522 - .8824 = -0.2302
#
# (b) One approach for investigating whether or not the treatment is effective
#     is to use a randomization technique.
#     i. What are the claims being tested? Use the same null and alternative
#          hypothesis notation used in the section.

#       H0(Doing the transplant program makes a difference)
#       HA(Doing the transplant program does not make a difference)

#     ii. The paragraph below describes the set up for such approach, if we were
#     to do it without using statistical software. Fill in the blanks with a
#     number or phrase, whichever is appropriate. 
#          We write alive on __28__ cards representing patients who were
#          alive at the end of the study, and dead on __75__ cards representing
#          patients who were not. Then, we shuffle these cards and split them
#          into two groups: one group of size __69__ representing treatment, and
#          another group of size __34__ representing control. We calculate the
#          difference between the proportion of dead cards in the treatment and
#          control groups (treatment - control) and record this value. We repeat
#          this many times to build a distribution centered at __the true mean/
#          effectiveness of the transplant program__. Lastly, we
#          calculate the fraction of simulations where the simulated differences
#          in proportions are __equal to or less than 0.__. If this fraction is low, we conclude that it is
#          unlikely to have observed such an outcome by chance and that the null
#          hypothesis should be rejected in favor of the alternative.

#     iii. What do the simulation results suggest about the effectiveness of
#          the transplant program? (See textbook for figure.)
#           They suggest that the transplant program is not effective, because 0.2302
#           is at the far end of the left side of the distribution.


####################################################################################
# ISRS Exercise 2.6 
# An experiment conducted by the MythBusters, a science entertainment TV program
# on the Discovery Channel, tested if a person can be subconsciously influenced
# into yawning if another person near them yawns. 50 people were randomly
# assigned to two groups: 34 to a group where a person near them yawned
# (treatment) and 16 to a group where there wasn't a person yawning near them
# (control). The following table shows the results of this experiment.
#
# Contingency table:
#                         --------------------------
#                         Control  Treatment  Total
#          ---------------------------------------
#               Yawn         10       4        14
#  Result       Not Yawn     24       12       36
#          ---------------------------------------
#                Total       34       16       50
#          ---------------------------------------
#
# A simulation was conducted to understand the distribution of the test
# statistic under the assumption of independence: having someone yawn near
# another person has no influence on if the other person will yawn. In order to
# conduct the simulation, a researcher wrote yawn on 14 index cards and not yawn
# on 36 index cards to indicate whether or not a person yawned. Then he shuffled
# the cards and dealt them into two groups of size 34 and 16 for treatment and
# control, respectively. He counted how many participants in each simulated
# group yawned in an apparent response to a nearby yawning person, and
# calculated the difference between the simulated proportions of yawning as
# ˆptrtmt,sim − pˆctrl,sim. This simulation was repeated 10,000 times using
# software to obtain 10,000 differences that are due to chance alone. The
# histogram shows the distribution of the simulated differences.
#
# (a) What are the hypotheses?
#       H0(Having someone yawn near another person has no influence on if the other person will yawn)
#       HA(Having someone yawn near another person has influence on if the other person yawns)

# (b) Calculate the observed difference between the yawning rates under the
#     two scenarios.
#      10/34 0.2941
#       4/16 0.25
#       0.25 - 0.2941 = -0.0441
#       
# (c) Estimate the p-value using the figure and determine the conclusion of
#     the hypothesis test.
#       I think p-value is around
#       0.04 + 0.075 + 0.175 + 0.25 = 0.54 
#       I think this means that there's around a 50% chance you encounter -0.0441 
#       if you randomly pick from the null distribution, so I would say you can't 
#       reject the null hypothesis.

####################################################################################
# IST Exercise 9.2 
# In Chapter 13 we will present a statistical test for testing
# if there is a difference between the patients that received the active magnets
# and the patients that received the inactive placebo in terms of the expected
# value of the variable that measures the change. The test statist for this
# problem is taken to be
#  T = (X_bar_1 - X_bar_2) / sqrt(S_1^2/29 + S_2^2/21)
#
# where X_bar_1 and X_bar_2 are the sample averages for the 29 patients that 
# receive active magnets and for the 21 patients that receive inactive placebo, 
# respectively. The quantities S_1^2 and S_^2 are the sample variances for each
# of the two samples. Our goal is to investigate the sampling distribution 
# of this statistic in a case where both expectations are equal to each other 
# and to compare this distribution to the observed value of the statistic.
#
# 1. Assume that the expectation of the measurement is equal to 3.5, regardless
#    of what the type of treatment that the patient received. We take the
#    standard deviation of the measurement for patients the receives an active
#    magnet to be equal to 3 and for those that received the inactive placebo we
#    take it to be equal to 1.5. Assume that the distribution of the
#    measurements is Normal and there are 29 patients in the first group and 21
#    in the second. Find the interval that contains 95% of the sampling
#    distribution of the statistic.

    mu <- 3.5
    sig_active <- 3
    sig_inactive <- 1.5
    test_statist <- rep(0, 1e5)
    for (i in 1:1e5) {
        X1 <- rnorm(29, mu, sig_active)
        X2 <- rnorm(21, mu, sig_inactive)
        X1_mean <- mean(X1)
        X1_var <- var(X1)
        X2_mean <- mean(X2)
        X2_var <- var(X2)
        test_statist[i] <- (X1_mean - X2_mean) / sqrt(X1_var/29 + X2_var/21)
    }
    interval <- quantile(test_statist, c(0.025, 0.975))
    interval
    # OUTPUT: 
    # [-2.0137, 2.0191]

# 2. Does the observed value of T (computed from the "magnets" data) fall
#    inside or outside the interval computed in 1?
    magnets
    mag_mean_active <- mean(magnets$change[1:29])
    mag_var_active <- var(magnets$change[1:29])
    mag_mean_inactive <- mean(magnets$change[30:50])
    mag_var_inactive <- var(magnets$change[30:50])
    T <- (mag_mean_active - mag_mean_inactive) / sqrt(mag_var_active / 29 + mag_var_inactive / 21)
    T
    # OUTPUT: 5.9856
    # The value falls outside of the interval