#Day 4 Exercises
library(tidyverse)

########################################################################
#Exercise 3.3.1 #1 - What's gone wrong with this code? Why are the points
#not blue?
########################################################################
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#Answer - The parameter color is inside the asesthetic makes this code wrong
#, it should be outside of the aesthetic function. The points are not blue, 
#since the code is not changing information about the appearance of the variable.
#When it is outside the aesthetic function, we can set the appearance to change.

########################################################################
#Exercise 3.3.1 #2 - Which variables in mpg are categorical? Which variables
#are continuous? How can you see this information when you run mpg?
########################################################################
?mpg
mpg
#Answer - Continuous variables are cty, hwy, cyl, and displ. The categorical
#variables are manufacturer, model, year, trans, drv, fl, and class. When we
#run mpg we can see the information about data type of each of the variables
#continuous variables are always numerical so if the data type is int or double
#in most cases we can assume that this is a continuous variable. Variables that
#are strings or characters would be categorical.

########################################################################
#Exercise 3.3.1 #3 - Map a continuous variable to color, size, and shape.
#How do these aesthetics behave differently for categorical vs. continuous
#variables?
########################################################################
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cty))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = cty))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cty))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

#Answer - Color
#For a continuous variable color is represented through different shades of a 
#color since there are many values assigned to a continuous varible. For a 
#categorical variable on the other hand, each possible value has it's own unique
#value that is different from the rest. Both of the graphs show the difference
#in color assignments for continuous and categorical variables. 
#Shape
#Continuous variables cannot be mapped to shape since there are way too many variables
#and not enough shapes to represent them. Categorical variables can normally be 
#represented by different shapes as long as there are only a limited amount of discrete
#values that can each be represented by unique shapes.
#Size
#Differences in continuous variables can easily be seen by different sized plots, but 
#for categorical variables this method is usually not recommended since the size
#does not have a significant meaning to what it represents. 

########################################################################
#Exercise 3.5.1 #1 - What happens if you facet on a continuous variable?
########################################################################
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue") +
  facet_wrap(~ cty)

#Answer - When you facet on a continuous variable it makes it harder to see 
#the data. Since continuous variables can be an infinite amount of values
#there would be a possibility of there being a very large number of plots
#which would not be an efficient way to view the data. The other thing is that
#the datapoints each have different frequency, so faceting may not be useful if 
#for some plots there are many points and for others there are very few. 

########################################################################
#Exercise 3.5.1 #4 - What are the advantages to using faceting instead of
#the color aesthetic? What are the disadvantages? How might the balance
#change if you had a larger dataset?
########################################################################
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

#Answer - The advantages to using faceting instead of the color aesthetic
#are that if there are values that are overlapping then with color we would
#not easily be able to see them since the points would cover each other. A 
#disadvantage is that by separating each plot may need it's own scale to properly
#view information about the dataset but that would be hard to do for each plot.
#If we had a larger dataset in cases in which there is a lot of overlap it would
#be harder to see each of the points. Another disadvantage is that if there is a
#larger dataset then faceting can also be at a disadvantaged since there may be
#too many separate plots to be able to make a comparison. In a larger dataset, both
#color aesthetic and faceting can have disadvantages and advantages depending
#on what we want to see from the data.

########################################################################
#Exercise 3.6.1 #5 - Will these 2 graphs look different? Why/why not?
########################################################################
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#Answer - The 2 graphs will be exactly the same since they are defining
#each of the variables to be graphed in the same exact way. The first 
#code does it globally while the second one does it locally, however
#both commands are telling it to graph the same thing, which is have
#displ on the x-axis, hwy on the y-axis, and find a smooth line that 
#fits the data. 

########################################################################
#Exercise 3.6.1 #6 - Recreate the R code necessary to generate the following graphs.
########################################################################
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

ggplot(dat = mpg, mapping = aes(x = displ, y = hwy, group = drv, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy), se = FALSE)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv), se = FALSE)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "white", size = 4) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))

########################################################################
#Exercise 3.8.1 #1 - What is the problem with this plot? How could you
#improve it?
########################################################################
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
#Answer - The problem with this plot is that there is overplotting, so 
#we are not able to see all of the points in the graph. To improve it we 
#can add the jitter function that will add some random noise and make it
#easier to see each point.

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter") 

########################################################################
#Exercise 3.8.1 #2 - What parameters to geom_jitter() control the 
#amount of jittering?
########################################################################
?position_jitter
#Answer - The width and height parameters control the amount of vertical 
#and horizontal jitter respectively. 