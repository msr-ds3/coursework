#Excercie 3.3.1

library(tidyverse)


dta_mpg <- mpg

#----------------------------------------------------------------------------------------
# Excercies from chapter 3 first edition 

# 3.3.1 Excercies 

# Question 1: 
# A fix for the code: 
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(color = "blue")

# Another sol 

ggplot(mpg) + 
geom_point(aes(x = displ, y= hwy), color = "blue")

# The issue was that the color was included in aes(). So, it was treated as aesthetic. 
#The color = "blue" was interpreted as a categorical variable which only takes a single value "blue"

# Question 2:
# I used ?mpg to check this: 

# categorial variables in mpg are: manufacturer, model, year, trans, drv, fl, class
# Continuous variable in mpg are: displ, year, cyl, cty, hwy

#Question 3:

#Makes teh color as a scale not distinct colors (same for size)
ggplot(mpg, aes(x = displ, y = hwy, color = cty)) +
geom_point()

ggplot(mpg, aes(x = displ, y = hwy, size = cty)) +
geom_point()

# Gives error for shapes because we cannot make a scale of shapes
ggplot(mpg, aes(x = displ, y = hwy, shape = cty)) +
geom_point()

#-----------------------------------------------------------------------------------------

# 3.5.1 Excercies 

# question 1 
#Answer: The continuous variable is convereted to a categorical variable, then the grahp contains a facet for each distinct value
ggplot(
  mpg, aes(x = displ, y = hwy)) +  
  geom_point() +  facet_grid(.~cty)

# Question 4

# class is faceted
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# class mapped to color
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color =  class))


#Advantages: 
# 1- It's easier to distinguish and see the different classes
# 2- There is no overlapping between the point, so it is easier to see the trends. On the other hand, the with color, there is huge overlapping. 

#Disadvantages: 
# 1- It is diffcult to compare as the points are on different and separate graphs

#-----------------------------------------------------------------------------------------

# 3.6.1 Excercies: 

# Question 5: 
#graph 1 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

#graph 2
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))


#Ans: No, because both geom_point() and geom_smooth will take the same data as input in graph 2. 
# In graph 1, they will take from data from mapping. So, the two graphs will look the same. 


# Question 6: 

?mpg
?geom_smooth
#graph 1 
ggplot(
  mpg, aes(x = displ, y = hwy)
) + geom_point() + geom_smooth(se = FALSE)

#graph 2 
ggplot(
  mpg, aes(x = displ, y = hwy)
)  +  geom_point() + geom_smooth(aes(group  = drv), se = FALSE) 

#graph 3 
ggplot(
  mpg, aes(x = displ, y = hwy, color = drv)
) + geom_point() + geom_smooth(se = FALSE) 


#graph 4 
ggplot(
  mpg, aes(x = displ, y = hwy)
) + geom_point(aes(color = drv)) + geom_smooth(se = FALSE) 


#graph 5
ggplot(
  mpg, aes(x = displ, y = hwy)
) + geom_point(aes(color = drv)) + geom_smooth(aes(linetype = drv), se = FALSE) 

#graph 6
ggplot(
  mpg, aes(x = displ, y = hwy, color = drv)
) + geom_point(size = 4, color = "white") +  geom_point() 


#-----------------------------------------------------------------------------------------

#3.8.1 Excercies 

#Question 1: 

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()

# Problem is that there is overlapping because there are multiple observations for each combination cty and hwy 

# Quick fix would be: 

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")

#jitter shows the positions where there are more observations
