library(tidyverse)

####################################################################################
# IST Chapter 9, Exercise 9.1
magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")

# 1. What is the sample average of the change in score between the
#    patient's rating before the application of the device and the
#    rating after the application?
avg_change_sample <- magnets %>%
    summarize(sample_avg_change=mean(change)) %>%
    pull()
avg_change_sample

# The sample average change is 3.5.

# 2. Is the variable "active" a factor or a numeric variable?
summary(magnets)
# Since the summary does not discuss the mean, median, or quantiles of "active" it is a factor variable

# 3. Compute the average value of the variable "change" for the patients that
#    received an active magnet and average value for those that received an
#    inactive placebo. (Hint: Notice that the first 29 patients received an
#    active magnet and the last 21 patients received an inactive placebo. The
#    subsequence of the first 29 values can be obtained via "change[1:29]" and
#    the last 21 values via "change[30:50]".)

# received an active magnet
avg_change_active <- magnets %>%
    filter(grepl('1', active)) %>%
    summarize(avg_change=mean(change)) %>%
    pull()
avg_change_active
# The average change of those who received the active magnet is 5.241379

# received a placebo
avg_change_placebo <- magnets %>%
    filter(grepl('2', active)) %>%
    summarize(avg_change=mean(change)) %>%
    pull()
avg_change_placebo
# The average change of those who received the placebo is 1.095238

# 4. Compute the sample standard deviation of the variable "change" for the
#    patients that received an active magnet and the sample standard deviation
#    for those that received an inactive placebo.

# standard error of those who received active magnet
se_change_active <- magnets %>%
    filter(grepl('1', active)) %>%
    summarize(se_change=sd(change)) %>%
    pull()
se_change_active
# The standard error is 3.236568

# standard error of those who received placebo 
se_change_placebo <- magnets %>%
    filter(grepl('2', active)) %>%
    summarize(se_change=sd(change)) %>%
    pull()
se_change_placebo
# The standard error is 1.578124

# 5. Produce a boxplot of the variable "change" for the patients that received
#    an active magnet and for patients that received an inactive placebo. What
#    is the number of outliers in each subsequence?
magnets %>%
    ggplot(aes(x=active, y=change)) +
    geom_boxplot() + 
    labs(
        x="Patient Categories",
        y="Change in Response"
    )
# The boxplot for the change in response for patients who received the active magnets has 0 outliers
# The boxplot for the change in response for patients who received the placebo has 3 outliers


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
sd <- 2
n <- 100

run_sample_mean_normal <- function(n, mu, sd) {
    mean(rnorm(n, mu, sd))
}

run_sample_median_normal <- function(n, mu, sd) {
    median(rnorm(n, mu, sd))
}

mean_hat_normal <- replicate(1e5, run_sample_mean_normal(n, mu, sd))
median_hat_normal <- replicate(1e5, run_sample_median_normal(n, mu, sd))

expectation_mean_normal <- mean(mean_hat_normal)
expectation_mean_normal
# The expectation when using mean as an estimator is 2.999838

variance_mean_normal <- var(mean_hat_normal)
variance_mean_normal
# The variance when using mean as an estimator is 0.03971107

# Mean squared error of using mean as an estimator:
mse_mean_normal <- (expectation_mean_normal - mu)^2 + variance_mean_normal
mse_mean_normal
# The MSE is 0.04015111

expectation_median_normal <- mean(median_hat_normal)
expectation_median_normal
# The expectation when using median as an estimator is 2.99993 

variance_median_normal <- var(median_hat_normal)
variance_median_normal
# The variance when using median as an estimator is 0.06261095

# Mean squared error of using median as an estimator:
mse_median_normal <- (expectation_median_normal - mu)^2 + variance_median_normal
mse_median_normal
# The MSE is 0.06261095

# Therefore, using mean as an estimator for the normal distribution has a slightly smaller MSE, making it only slightly more accurate

#
# 2. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Uniform(0.5, 5.5) distribution. Compute the
#    expectation and the variance of the sample average and of the sample
#    median. Which of the two estimators has a smaller mean square error?

min <- 0.5
max <- 5.5
midrange = (min + max) / 2
n <- 100

run_sample_mean_uniform <- function(n, min, max) {
    mean(runif(n, min, max))
}

run_sample_median_uniform <- function(n, min, max) {
    median(runif(n, min, max))
}

mean_hat_uniform <- replicate(1e5, run_sample_mean_uniform(n, min, max))
median_hat_uniform <- replicate(1e5, run_sample_median_uniform(n, min, max))

expectation_mean_uniform <- mean(mean_hat_uniform)
expectation_mean_uniform
# The expectation when using mean as an estimator is 2.999126

variance_mean_uniform <- var(mean_hat_uniform)
variance_mean_uniform
# The variance when using mean as an estimator is 0.02085949

# Mean squared error of using mean as an estimator:
mse_mean_uniform <- (expectation_mean_uniform - midrange)^2 + variance_mean_uniform
mse_mean_uniform
# The MSE is 0.02086025

expectation_median_uniform <- mean(median_hat_uniform)
expectation_median_uniform
# The expectation when using median as an estimator is 3.001189

variance_median_uniform <- var(median_hat_uniform)
variance_median_uniform
# The variance when using median as an estimator is 0.0611722

# Mean squared error of using median as an estimator:
mse_median_uniform <- (expectation_median_uniform - midrange)^2 + variance_median_uniform
mse_median_uniform
# The MSE is 0.06111863

# Therefore, mean as an estimator for the uniform distribution also has a lower MSE. 

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
total <- nrow(ex2)

high_bp_proportion <- ex2 %>%
    filter(group == "HIGH") %>%
    summarize(
        count = n(),
        proportion = count/total
    ) %>%
    select(proportion) %>%
    pull()
high_bp_proportion
# The proportion is 0.2466667, or ~24.6%

# 2. Compute the proportion in the population of those with a high level of
#    blood pressure.
total_pop <- nrow(pop2)

high_bp_proprotion_pop <- pop2 %>%
    filter(group == "HIGH") %>%
    summarize(
        count = n(),
        proportion = count/total_pop
    ) %>%
    select(proportion) %>%
    pull()
high_bp_proprotion_pop
# The proportion is 0.28126, or ~28.1%

# 3. Simulate the sampling distribution of the sample proportion and compute
#    its expectation.

n <- 150 # suppose we sample 100 people
# replicate a pipe 1e4 times
high_bp_proportion_hat <- replicate(1e4, pop2 %>%
    slice_sample(n=n) %>%
    filter(group == "HIGH") %>%
    summarize(
        count = n(),
        proportion = count/150
    ) %>%
    select(proportion) %>%
    pull())

expectation_high_bp_proportion <- mean(high_bp_proportion_hat)
expectation_high_bp_proportion
# The expectation is 0.281784, or 28.1%

# 4. Compute the variance of the sample proportion.
variance_high_bp_proportion <- var(high_bp_proportion_hat)
variance_high_bp_proportion
# The variance is 0.001336755

# 5. It is proposed in Section 10.5 that the variance of the sample proportion
#    is Var(P_hat) = p(1 - p)/n, where p is the probability of the event (having
#    a high blood pressure in our case) and n is the sample size (n = 150 in our
#    case). Examine this proposal in the current setting.

# The probability of having high blood pressure here would be the expectation we computed, 
# which is 0.281784. Therefore that will be our p. 
p <- expectation_high_bp_proportion
var_p_hat <- p*(1-p)/n
var_p_hat
# The var_p_hat here is 0.001349212, which is very close to the variance from the sample distribution.

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
heart_transplant_table <- tribble(
    ~Outcome, ~Control, ~Treatment, ~Total,
    "Alive", 4, 24, 28,
    "Dead", 30, 45, 75,
    "Total", 34, 69, 103
)

treatment_total <- heart_transplant_table %>%
    filter(Outcome == "Total") %>%
    select(Treatment) %>%
    pull()
treatment_total

treatment_died <- heart_transplant_table %>%
    filter(Outcome == "Dead") %>%
    select(Treatment) %>%
    pull()
treatment_died

proportion_treatment_died <- treatment_died / treatment_total
proportion_treatment_died
# The proportion of patients who died with treatment is 0.6521739, or ~65%

control_total <- heart_transplant_table %>%
    filter(Outcome == "Total") %>%
    select(Control) %>%
    pull()
control_total

control_died <- heart_transplant_table %>%
    filter(Outcome == "Dead") %>%
    select(Control) %>%
    pull()
control_died

proportion_control_died <- control_died / control_total
proportion_control_died
# The proportion of patients who died in the control group is 0.8823529, or ~88.3%

difference <- proportion_treatment_died - proportion_control_died
difference
# The difference is -0.230179 (alternate hypothesis)

# (b) One approach for investigating whether or not the treatment is effective
#     is to use a randomization technique.
#     i. What are the claims being tested? Use the same null and alternative
#          hypothesis notation used in the section.

        # The claim being tested is that if the treatment is given and less patients die, 
        # this result is from the treatment itself (alternate hypothesis) and not due to randomness
        # (null hypothesis).  

        # Null hypothesis: delta = 0
        # Alternate hypothesis: delta < 0 

#     ii. The paragraph below describes the set up for such approach, if we were
#     to do it without using statistical software. Fill in the blanks with a
#     number or phrase, whichever is appropriate. 
#          We write alive on [28] cards representing patients who were
#          alive at the end of the study, and dead on [75] cards representing
#          patients who were not. Then, we shuffle these cards and split them
#          into two groups: one group of size [69] representing treatment, and
#          another group of size [34] representing control. We calculate the
#          difference between the proportion of dead cards in the treatment and
#          control groups (treatment - control) and record this value. We repeat
#          this many times to build a distribution centered at [0]. Lastly, we
#          calculate the fraction of simulations where the simulated differences
#          in proportions are [-0.230179]. If this fraction is low, we conclude that it is
#          unlikely to have observed such an outcome by chance and that the null
#          hypothesis should be rejected in favor of the alternative.

#     iii. What do the simulation results suggest about the effectiveness of
#          the transplant program? (See textbook for figure.)
    
            # In the simulation results, the distribution is centered a little below 0, 
            # meaning that the alternate hypothesis is true. 


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
    # Null hypothesis: Having someone yawn near another person will have no influence 
    # if the other person would yawn (i.e. the difference in people yawning between the
    # control and treatment is 0).

    # Alternate hypothesis: Having someone yawn near another person will have an effect
    # on the other person yawning (i.e. the difference in people yawning between the 
    # control and treatment is not than 0).

# (b) Calculate the observed difference between the yawning rates under the
#     two scenarios.
    yawn_table <- tribble(
        ~Result, ~Control, ~Treatment, ~Total,
        "Yawn", 4, 10, 14,
        "Not yawn", 12, 24, 36,
        "Total", 16, 34, 50
    )

    yawn_control_total <- yawn_table %>%
        filter(Result == "Total") %>%
        select(Control) %>%
        pull()
    yawn_control_total

    yawn_control <- yawn_table %>%
        filter(Result == "Yawn") %>%
        select(Control) %>%
        pull()
    yawn_control

    proportion_yawned_control <- yawn_control / yawn_control_total
    proportion_yawned_control
    # 0.25 of the control group yawned 

    yawn_treatment_total <- yawn_table %>%
        filter(Result == "Total") %>%
        select(Treatment) %>%
        pull()
    yawn_treatment_total

    yawn_treatment <- yawn_table %>%
        filter(Result == "Yawn") %>%
        select(Treatment) %>%
        pull()
    yawn_treatment

    proprotion_yawn_treatment <- yawn_treatment / yawn_treatment_total
    proprotion_yawn_treatment
    # 0.2941176 of the treatment group yawned

    delta <- proprotion_yawn_treatment - proportion_yawned_control
    delta
    # The difference is 0.04411765

# (c) Estimate the p-value using the figure and determine the conclusion of
#     the hypothesis test.

    # From the null distribution, the p-value of 0.04411765 would be around ~0.25
    # This is the probability that the difference came from the treatment and not 
    # by chance. 

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
s1 <- 3
s2 <- 1.5

run_average <- function(n, mu, s) {
    mean(rnorm(n, mu, s))
}

run_samples <- function() {
    mean_active_sample <- run_average(29, mu, s1)
    mean_placebo_sample <- run_average(21, mu, s2)
    test_stat <- (mean_active_sample - mean_placebo_sample) / sqrt((s1^2)/29 + (s2^2)/21)
}

test_stat_sample <- replicate(1e4, run_samples())

quantile(test_stat_sample, c(0.025, 0.975))
# 2.5%     97.5% 
# -1.967156  1.937554

# 2. Does the observed value of T (computed from the "magnets" data) fall
#    inside or outside the interval computed in 1?

# Use previous measures 
test_stat_hat <- (avg_change_active - avg_change_placebo) / sqrt((se_change_active^2)/29 + (se_change_placebo^2)/21)
test_stat_hat
# This number is 5.985601
# This falls outside the interval [-1.967156, 1.937554]