library(tidyverse)
library(ggplot2)

#3.3.1
#1
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
#2
# Which variables in mpg are categorical? Which variables are continuous? 
#   (Hint: type ?mpg to read the documentation for the dataset). 
# categorical: manufacturer, model, trans,drv, fl, and class
# continuous: displ, year, cyl,cty, and hwy

# How can you see this information when you run mpg?
str(mpg)
# output:
#   tibble [234 × 11] (S3: tbl_df/tbl/data.frame)
# $ manufacturer: chr [1:234] "audi" "audi" "audi" "audi" ...
# $ model       : chr [1:234] "a4" "a4" "a4" "a4" ...
# $ displ       : num [1:234] 1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
# $ year        : int [1:234] 1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
# $ cyl         : int [1:234] 4 4 4 4 6 6 6 4 4 4 ...
# $ trans       : chr [1:234] "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
# $ drv         : chr [1:234] "f" "f" "f" "f" ...
# $ cty         : int [1:234] 18 21 20 21 16 18 18 18 16 20 ...
# $ hwy         : int [1:234] 29 29 31 30 26 26 27 26 25 28 ...
# $ fl          : chr [1:234] "p" "p" "p" "p" ...
# $ class       : chr [1:234] "compact" "compact" "compact" "compact" ...


# 3
# Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = circle), color = class,  size = 2)

#3.5
#1
# What happens if you facet on a continuous variable?
# It converts to categorical data and creates a the plot contains a facet for each distinct value.

#4
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# Some advantages of using aesthestic instead of facet such as have a overview of the data relatively and from a bigger picture. 
# and a disadvantage is not seeing the details. 





