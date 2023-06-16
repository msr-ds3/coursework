library(tidyverse)
library(lubridate)

magnets <- read.csv(file="magnets.csv")

## What is the sample average of the change in score between the patient’s
## rating before the application of the device and the rating after the application?
  summary(magnets) ## 3.5

## Is the variable “active” a factor or a numeric variable? 
  ## a factor

## Compute the average value of the variable “change” for the patients that
## received and active magnet and average value for those that received an
## inactive placebo.
  mean(magnets$change[1:29])
  mean(magnets$change[30:50])

## Compute the sample standard deviation of the variable “change” for the
## patients that received and active magnet and the sample standard deviation for those that received an inactive placebo.
  sd(magnets$change[1:29])
  sd(magnets$change[30:50])
  
## Produce a boxplot of the variable “change” for the patients that received
## and active magnet and for patients that received an inactive placebo.
  boxplot(magnets$change[1:29])
  boxplot(magnets$change[30:50])
  
## What is the number of outliers in each subsequence?
  ## active = 0
  ## inactive = 3