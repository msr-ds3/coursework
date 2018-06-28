library(tidyverse)
library(modelr)
library(scales)

theme_set(theme_bw())

# read in the loan data
# cast the outcome to a factor
loan <- read_csv('lending_club_cleaned.csv') %>%
  mutate(good = as.factor(good))

# fit a simple model that predicts loan status from fico score
logit1 <- glm(good ~ fico, data = loan, family = "binomial")
summary(logit1)

# use the modelr functions to get predictions from the model
# note: unfortunately the add_predictions will give back log odds
# because it doesn't accept a type = "response" argument
# so we've named the column accordingly with the var = "log_odds"
# argument and then converted log_odds to a probability
# using the sigmoid function
loan %>%
  data_grid(fico) %>%
  add_predictions(logit1, var = "log_odds") %>%
  mutate(prob = 1 / (1 + exp(-log_odds)))
head(loan)

# here's an alternative way to do the same, but have the predict
# function do the work of applying the sigmoid funciton
# we've used the '.' to represent the incoming data frame
plot_data <- loan %>%
  data_grid(fico) %>%
  mutate(pred = predict(logit1, ., type = "response"))
head(plot_data)

# plot the fitted function, which only spans a small fico range
ggplot(plot_data, aes(x = fico, y = pred)) +
  geom_line() +
  scale_y_continuous(label = percent)

# create our own data to span a larger range
plot_data <- data.frame(fico = 200:900) %>%
  mutate(pred = predict(logit1, ., type = "response"))

# plot the fitted function over the larger fico range
ggplot(plot_data, aes(x = fico, y = pred)) +
  geom_line() +
  scale_y_continuous(label = percent)

# repeat this, but first compute the empirical fraction of
# loans that are good at each fico score
plot_data <- loan %>%
  group_by(fico) %>%
  summarize(count = n(),
            frac_good = mean(good == "good")) %>%
  ungroup() %>%
  mutate(pred = predict(logit1, ., type = "response"))

# add these as points to the plot
ggplot(plot_data, aes(x = fico, y = pred)) +
  geom_line() +
  geom_point(aes(x = fico, y = frac_good, size = count)) +
  scale_y_continuous(label = percent)

# fit a second model where we interact fico and the loan purpose
# to allow different effects of fico score by loan purpose
logit2 <- glm(good ~ fico * purpose, data = loan, family = "binomial")
summary(logit2)

# compute the empirical fraction of loans that are good
# at each fico score, for each purpose
plot_data <- loan %>%
  group_by(fico, purpose) %>%
  summarize(count = n(),
            frac_good = mean(good == "good"),
            se = sqrt(frac_good * (1 - frac_good) / count)) %>%
  ungroup() %>%
  mutate(pred = predict(logit2, ., type = "response"))

# plot the model, with facets and colors for each purpose
ggplot(plot_data, aes(x = fico, y = pred, color = purpose)) +
  geom_line() +
  geom_pointrange(aes(x = fico, y = frac_good, ymin = frac_good - se, ymax = frac_good + se)) +
  scale_y_continuous(label = percent) +
  coord_cartesian(ylim = c(.5, 1)) +
  facet_wrap(~ purpose) +
  theme(legend.position = "none")

# aside: it could be nice to add income to the model,
# but we have lots of missing income fields (~ half the data)
# we can handle this in a number of ways

# one is to assume everyone with missing income has median income
loan <- loan %>%
  mutate(income_median_patch = ifelse(is.na(income), median(income, na.rm = T), income))

# another is to bin income into quantiles so it's a factor
# and to add a level called 'missing' for people who are missing income
quantiles <- quantile(loan$income, seq(0, 1, 0.1), na.rm = T)
loan <- loan %>%
  mutate(income_binned = cut(income, quantiles),
         income_binned = ifelse(is.na(income_binned), 'missing', income_binned))

# try models with these, and try visualizing them