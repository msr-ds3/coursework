library(tidyverse)

#3.3.1 Exercise 1
# What’s gone wrong with this code? Why are the points not blue?

# The color is being set in the aesthetic which is used to map a dataframe
# onto the plot you are creating. So, instead of changing the colors to blue 
# for the points it is creating a legend and giving a label to all the points
# called blue.

#3.3.1 Exercise 2
# Which variables in mpg are categorical? Which variables are continuous? 
# (Hint: type ?mpg to read the documentation for the dataset). 
# How can you see this information when you run mpg?

# Categorical: manufacturer, model, trans, drv, fl, class
# Continuous: displ, year, cyl, cty, hwy
# Once running mpg, you can see the data type below the column labels

#3.3.1 Exercise 3
# Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. 
# continuous variables?

# When mapping a continuous variable to color it will create a color gradient, 
# when mapping it to size it will increase or decrease the size based on the
# values of the continuous variables. Whereas for shape, continuous variables 
# cannot be mapped because there is no way to "increase" shapes based on 
# increasing or decreasing values.
# For categorical variables using color, size and shape would assign a distinct
# color, size or shape, respectively based on the different categories provided
# by the variable.

#3.5.1 Exercise 1
# What happens if you facet on a continuous variable?

# It will plot a different subplot for each distinct value that appears in the
# dataframe for the specific continuous variable you facet on. Ex: if you chose
# years, it'll create a separate plot for each year (that's present on the
# dataframe) and plot the specific data associated with that specific year.


#3.5.1 Exercise 4
# Take the first faceted plot in this section:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# What are the advantages to using faceting instead of the colour aesthetic? 
  # What are the disadvantages? How might the balance change if you had a 
# larger dataset?

# Using faceting could allow viewers to split the data based on the variable
# faceted on, to compare data more specific to a certain variable. In this 
# instance comparing hwy and displ by specific classes. By using faceting 
# instead of color aesthetic it's easier to make predictions based on each
# class rather than to distinguish by color on a larger graph of all the data.
# A disadvantage of this is that it separates all of your data into multiple 
# facets instead of having all your data in one plot where you can make 
# more general predictions comparing everything.
# With a larger dataset, if there are more faceted plots it may be a little 
# overwhelming for the observer, and having the color distinctions may be more
# efficient depending on the type of question they're trying to answer. In the
# end it really depends on what predictions the observer is trying to make with
# the data set that they have.

#3.6.1 Exercise 5
# Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# These graphs will look the same, in the first graph we map the aesthetics in
# the global variable. While in the second we map them locally for each plot,
# however, both will produce the same graph. The first graph is just less lines
# of code.

#3.6.1 Exercise 6
#1
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

#2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(mapping = aes(group = drv), se = FALSE)

#3
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(mapping = aes(group = drv), se = FALSE)

#4
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = drv)) + 
  geom_smooth(se = FALSE)

#5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = drv)) + 
  geom_smooth(mapping = aes(linetype = drv), se = FALSE)

#6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(shape = 21, color = "white", mapping = aes(fill = drv), stroke = 2)

#3.8.1 Exercise 1
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
# The issue with this graph is that the mpg for cty and hwy are rounded, thus
# there is overplotting (values on top of one another). To resolve this issue 
# we can add position = 'jitter' to add some small random noise around each 
# point or add geom_jitter().

#3.8.1 Exercise 2
# The parameters height and width control the amount of jittering.
