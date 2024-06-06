# Section 3.3.1, exercises 1, 2, and 3

# 1. What’s gone wrong with this code? Why are the points not blue?
#    ggplot(data = mpg) + 
#    geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# Put color = "blue" outside of the aes() function

# 2. Which variables in mpg are categorical? Which variables are continuous? 
#    (Hint: type ?mpg to read the documentation for the dataset). How can you see this information when you run mpg?

# manufacturer -Categorical
# model - categorical
# displ - continuous
# year - continuous
# cyl - continous
# trans - categorical
# drv - categorical
# cty - continuous
# hwy - continous
# fl - categorical
# class - categorical

# 3. Map a continuous variable to color, size, and shape. 
#    How do these aesthetics behave differently for categorical vs. continuous variables?

# Color: instead of color names, use RGB values
# Size: instead of "large" / "medium" / "small" , use a size in numbers
# Shape: instead of name of shape, use the dimensions in numbers

# Section 3.5.1, exercises 1 and 4
# 1. What happens if you facet on a continuous variable?

# The facet function will convert the continuous variable to a categorical variable
  
# 4. Take the first faceted plot in this section:
#    What are the advantages to using faceting instead of the colour aesthetic? 
#    What are the disadvantages? How might the balance change if you had a larger dataset?

# ggplot(data = mpg) + 
# geom_point(mapping = aes(x = displ, y = hwy)) + 
# facet_wrap(~ class, nrow = 2)

# Using faceting may make it easier to see the different types 
# (colors might overlap, faceting gives indivudal graphs for each section)
# Finding a balance between fitting data in the graph and seperating them across multiple graphs

# Section 3.6.1, exercises 5 and 6
# 5. Will these two graphs look different? Why/why not?
  
# ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
# geom_point() + 
# geom_smooth()

# ggplot() + 
# geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
# geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# They will not be different because geom_point and geom_smooth will take in
# the same parameters, thus making the same graph

# 6. Recreate the R code necessary to generate the following graphs.

# Unable to access the dataset because it is not support for this version of R

# Section 3.8.1, exercises 1 and 2

# 1. What is the problem with this plot? How could you improve it

# ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
# geom_point()

# The problem is that some x-y pairs appear more than once, so we are overplotting. We can use jitter function
# to make it clearer.

# 2. What parameters to geom_jitter() control the amount of jittering?
# width and height