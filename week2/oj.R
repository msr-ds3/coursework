library(readr)
library(ggplot2)
library(scales)

# read the data
oj <- read_csv('oj.csv')

# fit a model with an offset for brand
model <- lm(logmove ~ log(price) + brand, data=oj)

# add the predicted values to the original data frame
oj$predicted <- fitted(model)

# plot the original data points and overlay the predicted values as a line
ggplot(oj, aes(x=log(price), y=logmove, color=brand)) +
  geom_point(alpha=0.1) +
  geom_line(aes(x=log(price), y=predicted, color=brand))

# use geom smooth, note the different slopes
# this is equivalent to fitting a different model (intercept and slope) for each brand
# similar to logmove ~ log(price)*brand
ggplot(oj, aes(x=log(price), y=logmove, color=brand)) +
  geom_point(alpha=0.1) +
  geom_smooth(method="lm")

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
  scale_y_log10(label=comma, breaks=c(1e3,1e4,1e5))

# use geom smooth to do similar
ggplot(oj, aes(x=price, y=exp(1)^logmove, color=brand, shape=as.factor(feat), linetype=as.factor(feat))) + 
  geom_point(alpha=0.1) + 
  geom_smooth(method="lm") + 
  facet_wrap(~ brand) +
  scale_x_log10(breaks=c(1,2,3)) +
  scale_y_log10(label=comma, breaks=c(1e3,1e4,1e5))
