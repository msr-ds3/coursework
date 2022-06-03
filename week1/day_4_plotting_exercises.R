library(tidyverse)


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

########################3.3.1
#####Question 1
#color doesn't convey information about a variable so we want to
#have the color outside the aes() to only change teh appearance of the plot 

#####Question 2
#Categorical variables (characters) = manufacturer, model, trans, drv, fl, class
#Continuous variable (integers & doubles) = displ, year, cyl, city, hwy

####Question 3
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cty)) #works

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cty)) #works

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = cty)) 
#error continuous variable can't be mapped to shape
##akes sense because there's nothing continuous about shapes 
#(use categorical variables instead see below)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

#########################3.5.1
####Question 1 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(~ cyl)
#since cyl is categorical variable, now every type of cyl will have a corresponding 
##with hwy variable

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

####Question 4
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
#if the dataset is very large and we used 'color = class', 
#we might run into an issue where its difficult to distinguish between different classes.
#if dataset it small, then its useful because there aren't many data sets to distinguish from 


########################3.6.1
####Question 5 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#both graphs look the same because they are passed the same mappings to geom_point & geom_smooth


####Question 6
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  geom_smooth(se=FALSE)

ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  geom_smooth(se=FALSE, mapping = aes(x=displ, y=hwy, group = drv))

ggplot(data = mpg, mapping = aes(x=displ, y = hwy, color = drv)) + 
  geom_point(mapping = aes(x=displ, y=hwy)) + 
  geom_smooth(se=FALSE, mapping = aes(x=displ, y=hwy, group = drv, color = drv))

ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(aes(x=displ, y=hwy, color = drv)) + 
  geom_smooth(se=FALSE)

ggplot(data = mpg) + 
  geom_point(aes(x=displ, y = hwy, color = drv))  


#################3.8.1
####Question 1
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() 
#many points overlap in this graph 
#use geom_jitter to fix this issue

####Question 2
#geom_jitter parameters are controlled by the width argument








