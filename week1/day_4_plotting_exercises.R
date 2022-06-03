library(tidyverse)

# 1. What’s gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# color = blue is passed inside aes, however blue is not a column name.
# if we pass color = blue outside of aes, then the dots will appear blue.

# 2. Which variables in mpg are categorical? Which variables are continuous? 
# How can you see this information when you run mpg?
?mpg 
head(mpg)
# categorical: manufacturer, year, model, trans, drv, fl, class
# continuous: displ, cyl, cty, hwy

# 3. Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# Mapping continuous variable to color displays single color with varying shades
# Mapping categorical variable to color displays various colors
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = displ))
ggplot(data = mpg) + 
 geom_point(mapping = aes(x = displ, y = hwy, size = class))
# Mapping continuous variable to size displays varying sizes 
# Mapping categorical variable to size is "not advised".
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = cty))
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = fl))
# A continuous variable cannot be mapped to shape
# But a categorical variable can be. 

# 1. What happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(~ hwy)
# Displays a chart for each data in continuous variable, 
# which doesn't seem tidy and might not be a practical thing to do

# 4. Take the first faceted plot in this section:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# What are the advantages to using faceting instead of the colour aesthetic? 
# What are the disadvantages? 
# How might the balance change if you had a larger dataset?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# Advantages to using faceting: looks easier to read. if we have many data entries for each class, this is better.
# Disadvantages: comparison among different classes is better in color aesthetic. 
# If we had a larger dataset, points of different colors might overlap. Then, it is better to use faceted plot.

# 5. Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# The graphs look same because we are passing the same argument in globally in the first code
# and individually in the second code.

# 6. Recreate the R code necessary to generate the following graphs.
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(se = FALSE) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, group = drv)) +
  geom_smooth(se = FALSE) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(se = FALSE) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(se = FALSE) +
  geom_point(mapping = aes(color = drv))

ggplot(mpg, aes(x = displ, y = hwy, group = drv)) +
  geom_smooth(se = FALSE) +
  geom_point(mapping = aes(color = drv))

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "white", size = 3) + 
  geom_point(mapping = aes(color = drv))

# 1. What is the problem with this plot? How could you improve it?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
# The values of cty and hwy are rounded, thus the points appear on the grids and overlap
# I will pass jitter to position inside geom_point argument.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")

# 2. What parameters to geom_jitter() control the amount of jittering?
# 'width' to control the amount of horizontal displacement
# 'height' to control the amount of vertical displacement
