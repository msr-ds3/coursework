library(tidyverse)

# veiw mpg data
mpg %>% View

# 3.3.1 Exercise 1 - What's gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# in order to make the points blue, the color assignment should be outside aes()
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 3.3.1 Exercise 2 - Which variables in mpg are categorical? 
# Which variables are continuous? 
# (Hint: type ?mpg to read the documentation for the dataset). 
# How can you see this information when you run mpg?
?mpg
mpg

# categorical - manufacturer, model, trans, drv, fl, class
# continuous - displ, year, cyl, cty, hwy
# You can see this information when you run mpg because categorical variables are
# characters, and continuous variables are integers and doubles. 

# 3.3.1 Exercise 2 - Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?

# When a continuous variable is mapped to color, the satuartion of the color represents
# the values of the variable, where lighter colors represent lower values and 
# darker colors represent higher values.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ))

# When a continuous variable is mapped to size, the size of the points represents
# the values of the variable, where smaller points represent lower values and 
# larger points represent higher values.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = displ))

# ggplot throws and error when attempting to map a continuous variable to shape
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = displ))

# Section 3.5.1, exercise 1 - What happens if you facet on a continuous variable?

# The continuous variable is converted into a categorical variable, and the plot
# contains a facet for each distinct value.
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(. ~ cty)

# Section 3.5.1, exercise 4 - Take the first faceted plot in this section:
# What are the advantages to using faceting instead of the colour aesthetic? 
# What are the disadvantages? 
# How might the balance change if you had a larger dataset?

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

# Advantages - It is easier to see observations within categories.
# Disadvantages - It is difficult to compare observations across categories.
# With a larger dataset, it would be even more difficult to distinguish many colors,
# so faceting would be even more helpful

# Section 3.6.1, exercise 5 - Will these two graphs look different? Why/why not?

# No - they both use the same data and the same mapping

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# Section 3.6.1, exercise 6 - Recreate the R code necessary to generate the following graphs.

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(aes(group = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(group = drv, color = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(group = drv, linetype = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, color = "white") +
  geom_point(aes(color = drv))

# Section 3.8.1, exercise 1 - What is the problem with this plot? 
# How could you improve it?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point()

# Problem - Some of the points overlap each other
# Improvement - add random noise

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point(position = "jitter")

# Section 3.8.1, exercises 2 - What parameters to geom_jitter() control the amount of jittering?
# width and height




  








