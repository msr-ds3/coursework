
library(scales)
library(broom)
library(modelr)
library(tidyverse)

theme_set(theme_bw())

bodydata <- read.table(file = "body.dat.txt")
weight = bodydata["V23"]
height = bodydata["V24"]

df_data = data.frame(height, weight)
names(df_data) = c("height", "weight")

head(df_data)

df_data %>%
  ggplot(aes(x = height, y = weight)) +
  geom_point(alpha = 0.5, color = "blue")
