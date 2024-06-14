library(scales)
library(broom)
library(modelr)
library (tidyverse)

data <- read.table("babyweights.txt")


form <- as.formula(bwt ~ gestation + parity + age + height + weight + smoke)
M <- model.matrix(form, data)
head(M)

model <- lm(form, data)
tidy(model)
glance(model)
