# Session 3.3.1, exercise 1, 2, and 3
library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = 
               aes(x = displ, y = hwy, color = "blue"))

# 1. The points aren't blue because the argument color is a string blue that is treated as an aes. 
# This should be a mapping between a variable and a value. "blue" is not a value that represents the color blue. 
# If you place, color = "blue" outside the aes, they the graph would be blue. 

# 2. categorical variables: manufacturer, model, trans, drv, fl, class
# continuous variables are: displ, year, cyl, cty, hey

# 3. 
ggplot(data = mpg) + 
  geom_point(mapping = 
               aes(x = displ, y = hwy, color = year))
# a continuous variable for color uses a scale of colors from light to dark.
ggplot(data = mpg) + 
  geom_point(mapping = 
               aes(x = displ, y = hwy, size = year))
# a continuous variable for size, changes how big or small the points on the graph are. 
ggplot(data = mpg) + 
  geom_point(mapping = 
               aes(x = displ, y = hwy, shape = year))
# A continuous variable can not be mapped to shape.
# I think the color and size are not the best to use for continuous variables. 
# The reader of the graph needs to keep on going back to the legend to understand the graph. 

# Session 3.5.1, exercise 1 and 4
# 1. 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ displ, nrow = 2)
# R lets you wrap a continuous variable, however, the results are not clearly readble. 
# I would not do this. 

# 4. 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# Below class is wrapped to a color:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) 
# The color is good when there are not so many categories 
# (or else you might run out of colors - or have very similar looking colors)
# facetting the class increases the number of points and categories readable. 
# We don't have much overlap of different or the same color points. 

# Session 3.6.1, exercise 5 and 6
# 5.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# These graphs are the same. The top code us better because it is less redundant.

# 6. 
# 1 line blue, with all black points
mpg %>%
ggplot(mapping = (aes(x = displ, y = hwy))) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# 3 blue lines with black points
ggplot(data = mpg, mapping = (aes(x = displ, y = hwy, group = drv))) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# all colored, 3 lines
ggplot(data = mpg, mapping = (aes(x = displ, y = hwy, group = drv, color = drv))) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# one blue line, points 3 colors
ggplot(data = mpg) + 
  geom_point(mapping = (aes(x = displ, y = hwy, group = drv, color = drv))) + 
  geom_smooth(mapping = (aes(x = displ, y = hwy)), se = FALSE)

ggplot(data = mpg, mapping = (aes(x = displ, y = hwy, group = drv))) + 
  geom_point(aes(color = drv)) + 
  geom_smooth(aes(linetype = drv), se = FALSE)

mpg %>%
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(size = 4, color = "white") + 
  geom_point(aes(color = drv))


# Session 3.8.1, exercise 1 and 2
# 1
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
# The problem with this plot is that some points are plotted twice.
# This is because there are multiple observations for each combination of cty and hwy values. 

# I would increase it by adding the jitter position 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cty, y = hwy), position = "jitter")

# 2
# The parameters in jitter that control the randomness are width and height. 
# width does the horizontal randomness and height does the vertical randomness. 


