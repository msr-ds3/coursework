# Data Visualizations Textbook Chapter 3 questions
# Friday June 2, 2023

'''
Section 3.3.1, exercises 1, 2, and 3
Section 3.5.1, exercises 1 and 4
Section 3.6.1, exercises 5 and 6
Section 3.8.1, exercises 1 and 2
'''

# 3.3.1 E1
'''
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue""))
'''
# color declaration should be outside of aesthetic but inside geom_point

# 3.3.1 E2
?mpg
mpg
# Categorical: manufacturer, model, trans, drv, fl, class
# Continuous: displ, year, cyl, cty, hwy

# 3.3.1 E3
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = year, size = hwy, shape = manufacturer))
# Color can take continuous or categorical data
# Size only takes continuous
# Shape only takes categorical

# 3.5.1 E1
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cyl)
# Shows a subplot for each unique continuous value

# 3.5.1 E4
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# Facet good for seeing the different "colors" in separate graphs
# Color good for seeing everything (all "facets") on top of each other
# The larger the dataset, the better facet seems to be

# 3.6.1 E5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# These two plots are the same because the first applies mappings globally
# and the second applies the same mapping locally to both geoms

# 3.6.1 E6
# Recreate 6 plots, looks annoying

# 3.8.1 E1
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() + 

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")
# The problem with the first plot is too many values are overlapping = overplotting
# Use jitter to add random noise to each point to reveal more datapoints

# 3.8.1 E2
# the 'width' and 'height' parameters control the horizontal and vertical amount of jitter
# ex: <normal stuff> + geom_jitter(width = 0.5, height = 0.3)






