library(scales)
library(broom)
library(modelr)
library (tidyverse)

data <- read.table("body.dat.txt")


form <- as.formula(V23 ~ V24)
M <- model.matrix(form, data)
head(M)

model <- lm(form, data)
tidy(model)
glance(model)