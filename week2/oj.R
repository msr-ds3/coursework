library(readr)
library(ggplot2)
library(scales)
library(broom)

# read the data
oj <- read_csv('oj.csv')

### VISUALIZING BRAND EFFECTS ###

# fit a model with an offset for brand
model <- lm(logmove ~ log(price) + brand, data=oj)

# add the predicted values to the original data frame
oj$predicted <- fitted(model)

# plot the original data points and overlay the predicted values as a line
ggplot(oj, aes(x=log(price), y=logmove, color=brand)) +
  geom_point(alpha=0.1) +
  geom_line(aes(x=log(price), y=predicted, color=brand)) +
  xlab('log(price)') +
  ylab('log(sales)')

# use geom smooth, note the different slopes
# this is equivalent to fitting a different model (intercept and slope) for each brand
# similar to logmove ~ log(price)*brand
ggplot(oj, aes(x=log(price), y=logmove, color=brand)) +
  geom_point(alpha=0.1) +
  geom_smooth(method="lm") +
  xlab('log(price)') +
  ylab('log(sales)')


### ADDING FEATURED PRODUCT EFFECTS ###

# fit a model with lots of interaction terms
model <- lm(logmove ~ log(price)*brand*feat - 1, data=oj)

# add the predicted values to the original data frame
oj$predicted <- fitted(model)

# plot the original data points and overlay the predicted values as a line
ggplot(oj, aes(x=price, y=exp(1)^logmove, color=brand, shape=as.factor(feat))) +
  geom_point(alpha=0.1) +
  geom_line(aes(x=price, y=exp(1)^predicted, color=brand, linetype=as.factor(feat))) +
  facet_wrap(~ brand) +
  scale_x_log10(breaks=c(1,2,3)) +
  scale_y_log10(label=comma, breaks=c(1e3,1e4,1e5)) +
  xlab('Price') +
  ylab('Sales')

# use geom smooth to do similar
ggplot(oj, aes(x=price, y=exp(1)^logmove, color=brand, shape=as.factor(feat), linetype=as.factor(feat))) + 
  geom_point(alpha=0.1) + 
  geom_smooth(method="lm") + 
  facet_wrap(~ brand) +
  scale_x_log10(breaks=c(1,2,3)) +
  scale_y_log10(label=comma, breaks=c(1e3,1e4,1e5)) +
  xlab('Price') +
  ylab('Sales')

# view the fitted functions in linear space to see how dramatic the effect is
ggplot(oj, aes(x=price, y=exp(1)^logmove, color=brand, shape=as.factor(feat))) +
  geom_line(aes(x=price, y=exp(1)^predicted, color=brand, linetype=as.factor(feat))) +
  facet_wrap(~ brand) +
  scale_y_continuous(label=comma, lim=c(0,1e5)) +
  xlab('Price') +
  ylab('Sales')

### PLOTTING COEFFICIENTS FOR DEMOGRAPHICS ON OVERALL DEMAND ###

# fit a model with lots of interaction terms plus demographic features
model <- lm(logmove ~ log(price)*brand*feat - 1 + AGE60 + EDUC + ETHNIC + INCOME + HHLARGE + WORKWOM + HVAL150, data=oj)

# view the effects of demographics on overall sales
# do this the "old way" by manually extracting coefficients
coefficients <- coef(model)[6:12]
plot_data <- data.frame(variable = as.factor(names(coefficients)), value = as.numeric(coefficients)) %>%
  mutate(variable = reorder(variable, value))
# effect in log sales space
ggplot(plot_data, aes(x = value, y = variable)) +
  geom_point() +
  geom_vline(xintercept=0, linetype=2) +
  xlab('Change in log(sales)') +
  ylab('')
# transformed from log sales to sales
ggplot(plot_data, aes(x = exp(1)^value, y = variable)) +
  geom_point() +
  geom_vline(xintercept=1, linetype=2) +
  scale_x_log10(breaks=c(0.3,1,3)) +
  xlab('Relative change in sales') +
  ylab('')

# repeat this, with the help of broom to get a tidy data frame summarizing the model
plot_data <- tidy(model) %>%
  mutate(term = reorder(term, estimate))
# effect in log sales space
ggplot(plot_data[6:12, ], aes(x = estimate, y = term)) +
  geom_point() +
  geom_errorbarh(aes(xmin = estimate - 2*std.error, xmax = estimate + 2*std.error), height=0) +
  geom_vline(xintercept=0, linetype=2) +
  xlab('Change in log(sales)') +
  ylab('')
# transformed from log sales to sales
ggplot(plot_data[6:12, ], aes(x = exp(1)^estimate, y = term)) +
  geom_point() +
  geom_errorbarh(aes(xmin = exp(1)^(estimate - 2*std.error), xmax = exp(1)^(estimate + 2*std.error)), height=0) +
  geom_vline(xintercept=0, linetype=2) +
  scale_x_log10(breaks=c(0.3,1,3)) +
  xlab('Relative change in sales') +
  ylab('')


### PLOTTING DEMOGRAPHIC EFFECTS FOR   HOUSEHOLD SIZE AND EDUCATION ###

# fit a model focusing on the effects of two demographic features
model <- lm(logmove ~ log(price)*HHLARGE + log(price)*EDUC, data=oj)


# construct a new data frame with just the variables and values we'd like to look at
plot_data <- expand.grid(price = unique(oj$price),
                         HHLARGE = quantile(oj$HHLARGE, c(.25,0.5, 0.75)),
                         EDUC = quantile(oj$EDUC, c(.25,0.5, 0.75)))
plot_data$predicted <- predict(model, plot_data)
plot_data <- mutate(plot_data,
                    EDUC = factor(EDUC, labels=c('Low education','Typical education','High education')),
                    HHLARGE = factor(HHLARGE, labels=c('Low','Median','High')))
# color by large households, facet by education
ggplot(plot_data, aes(x=price, y=exp(1)^predicted, color=as.factor(HHLARGE))) +
  geom_line() +
  scale_x_log10(breaks=c(1,2,3), lim=c(.8, 4)) +
  scale_y_log10(label=comma, breaks=c(1e3,1e4,1e5), lim=c(1e3,1e5)) +
  scale_color_discrete(name='Fraction of large households') +
  xlab('Price') +
  ylab('Sales') +
  facet_wrap(~ EDUC)
