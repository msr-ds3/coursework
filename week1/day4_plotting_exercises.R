# 3.3.1 1-2-3
library(tidyverse)
library(ggplot2)
mpg <- ggplot2::mpg
?mpg
#1)
ggplot(data = mpg) +
 geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# in this example the points do not turn blue because the color aesthetic needs to
# be set as an argument of the geom function (outside the aes) manually, otherwise the color
# needs to be a variable from the data frame

#2)
# Continuous variables are properties you can measure (e.g. time based, "per gallon")
# categorical: manufacturer, model, trans, drv, fl, class
# continuous: displ, year, cyl, cty, hwy
# in running ?mpg I saw that most of the continuous vars ended in per gallon, liter or 
# started in year of, number of. The data types of each column are showed and I found out that
# numbers are usually continuous variables and characters are categorical 

#3)
#ggplot(data = mpg) +
#  geom_point(mapping = aes(x = displ, y = hwy, color = year, size = cyl, shape = cty))

#  Error --> A continuous variable can not be mapped to shape
# size and color can be represented by a continuous variable because they are able to 
# represent the increase/decrease in the value of the variable, whereas the shape cannot
# convey the change in the variable, is it assigned randomly

#3.5.1
#1)
# What happens if you facet on a continuous variable? 
# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy)) +
#   facet_wrap(~ cty, nrow = 2)
# it depends on which type of continuous variable, for example it makes sense to use the year
# but not so much the cty because it builds a ggplot for each variable
#4) 
# ggplot(data = mpg) + 
#   geom_point(mapping = aes(x = displ, y = hwy)) + 
#   facet_wrap(~ class, nrow = 2)
# What are the advantages to using faceting instead of the colour aesthetic?
# it is easier to look at in terms of focusing on one component at the time (e.g. you get to see each class clearly)
# What are the disadvantages?
# it takes more graphs to make (more space and time) and it is harder to compare them 
# How might the balance change if you had a larger dataset?
# with a larger dataset it may be better to use colours because it takes less space but if it is too much data
# it might be too messy to use only one graph, so it depends on the case

# 3.6.1
# 4) se is the standard error of the estimated result
# (se = TRUE highlights the standard error area in the graph)
# 5)
# ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
#   geom_point() + 
#   geom_smooth()

# ggplot() +
#   geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
#   geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#
# They will look the same because in the first example the variables set inside ggplot are "global"
# and applied to each geom, and in the second graph the same variables are set inside each geom
# which makes not difference

#3.8.1
#1 many points are overlapping so we could use geom_jitter() to show them or add position = "jitter" within geom_point()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() +
  #geom_jitter()
#2 -- width and height
# width	
# Amount of vertical and horizontal jitter. The jitter is added in both positive
# and negative directions, so the total spread is twice the value specified here.
# 
# If omitted, defaults to 40% of the resolution of the data: this means the jitter 
# values will occupy 80% of the implied bins. Categorical data is aligned on the 
# integers, so a width or height of 0.5 will spread the data so it's not possible 
# to see the distinction between the categories.
# 
# height	
# Amount of vertical and horizontal jitter. The jitter is added in both positive 
# and negative directions, so the total spread is twice the value specified here.
# 
# If omitted, defaults to 40% of the resolution of the data: this means the jitter 
# values will occupy 80% of the implied bins. Categorical data is aligned on the 
# integers, so a width or height of 0.5 will spread the data so it's not possible 
# to see the distinction between the categories.