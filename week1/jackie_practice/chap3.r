## Author: Jacqueline
## Exercises for Day Four
library(tidyverse)

# Section 3.3.1, exercises 1,2,3
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), colour="blue")

?mpg
view(mpg)
str(mpg)
# Continuous: displ, year, cty, hwy,
# Categorical: manufacturer, model, trans, drv, fl, class, | cyl

# Continuous
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, colour = displ))

ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, size = displ))

ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, shape = displ))

# Categorical
ggplot(data = mpg) +
    geom_bar(mapping = aes(x = hwy, fill = class))

ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, colour = class))

ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# Section 3.5.1, exercises 1,4
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_wrap(~ cty)

#Read ?facet_wrap. What does nrow do? What does ncol do? What other options control the layout of the individual panels? Why doesn’t facet_grid() have nrow and ncol arguments?
?facet_wrap

#nrow and ncol let us control the ammount of rows and columns
# scales, space, shrink, switch, drop, dir, strip.position, axes, axis.labels
# the rows and columns are defined by the faceting variables

# Section 3.6.1, exercises 5 and 6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# Yes they will look the same, same data and mappings for both geom functions
# ggplot defines the data for the following geom functions

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv)) + 
  geom_point() + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv, group = drv)) + 
  geom_point() + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = drv)) + 
  geom_smooth()

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = drv)) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, fill = drv), shape = 21, colour = "white", stroke = 2)

# Section 3.8.1, exercises 1 and 2
# cty = city miles per gallon
# hwy = highway miles per gallon
# 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() +
  geom_jitter(width = 0.25, height = 2)

# width and height

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() +
  geom_jitter()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() +
  geom_count()
