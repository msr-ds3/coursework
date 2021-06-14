library(tidyverse)

BodyData <- read.table("body.dat.txt", header=FALSE)
head(BodyData)

Weight <- BodyData[, 23]
head(Weight)

Height <- BodyData[, 24]
head(Height)

BodyData_df <- as.data.frame(BodyData)
View(BodyData_df)

BodyData_df %>%
  ggplot(aes(Height, Weight)) +
  geom_point() +
  scale_x_continuous(name = "Height (in cm)", breaks = seq(100, 200, 10)) +
  scale_y_continuous(name = "Weight (in kg)", breaks = seq(40, 120, 20))

BodyData_lm = lm(Weight ~ Height)
summary(BodyData_lm)




