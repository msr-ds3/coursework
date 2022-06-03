library(tidyverse)

# 3.3.1 exercises

# 1 what's gone wrong w this code? why are the points not blue?
  ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
  # what's wrong here is that the color = "blue" is inside of the aes() so it is not defining the 
  # color to be blue inside the aes() should only be variables from the data frame
  
# 2 which variables in mpg are categorical? which are continuous? 
  # how can you see this when you run mpg?
  ?mpg
  # categorical - manufacturer, model, trans, drv, fl, class
  # continuous - displ, year, cyl, cty, hwy
  mpg
  # when you run mpg, the display includes <data type> under each column name
    # character - categorical
    # double, integer - continuous
  
# 3 map a continuous variable to color, size, and shape. how do these
  # aesthetics behave diff for categorical vs. continuous variables?
  ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, color = year))
  ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, size = year))
  ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, shape = year))
  # with categorical variables, the mapping will change the color, size, or shape randomly to 
  # show each category (size is not advised with categorical)
  # when you map a continuous variable to color or size, it will create a color gradient or 
  # increase the size of the points based on the increase of the continuous variable. 
  # when you try to map a continuous variable to shape, it errors out. this is probably bc, as with 
  # color and size, the mapping of a continuous variable would show some increase in sizing but the 
  # random assigning of shapes would not convey increase of the variable

  
# 3.5.1 exercises
  
# 1 what happens if you facet on a continuous variable?
  # it will create a plot for each variable (for ex: if your data frame includes 4 years and you 
  # facet on year then you will get 4 plots, one for each year)
  
# 4 take the first faceted plot in this section. what are the advantages of 
  # using faceting instead of color aesthetic? what are the disadvantages?
  # how might the balance change if you had a larger dataset?
  ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_wrap(~ class, nrow = 2)
  # the advantage of using faceting is that it gives you a clear way to compare the data observations 
  # of a single variable (for example, here you can compare fuel usage of different models within
  # each class) as opposed to just seeing everything in on plot with different colors, which would 
  # make it hard to just pick out the single variable you want to look at the disadvantage is that 
  # you cannot see the comparison across the board between all variables
  # if you had a larger dataset, there may an overwhelming amount of faceted plots and in this 
  # case it may be better to use color. the type of plotting would depend on the question you are 
  # trying to answer with visualization. in some cases you may want to combine color and facet to 
  # create an even clearer visualization 
  
# 3.6.1 exercises
  
# 5 will these 2 graphs look diff? why/ why not?
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point() + 
    geom_smooth()
  ggplot() + 
    geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
  # these 2 graphs will looks the same. the same data and mapping are included in both, but the 
  # above graph seem like just a simpler way of generating the plot without having to rewrite the 
  # data frame and mapping
  
# 6 recreate the R code for the following graphs
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth(se = FALSE)
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth(mapping = aes(group = drv), se = FALSE)
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
    geom_point() +
    geom_smooth(mapping = aes(group = drv), se = FALSE)
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping = aes(color = drv)) +
    geom_smooth(se = FALSE)
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping = aes(color = drv)) +
    geom_smooth(mapping = aes(linetype = drv), se = FALSE)

  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(shape = 21, color = "white", mapping = aes(fill = drv), stroke = 2)
    
  ggplot(mtcars, aes(wt, mpg)) +
    geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)
  
# 3.8.1 exercises
  
# 1 what is the problem w this plot? how could you improve it?
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
    geom_point()
  # the problem with this graph is that the mpg for cty and hwy are rounded so 
  # there is overplotting (i.e. values are on top of each other). to solve this problem,
  # I would set the position = "jitter" within the geom_point() or add geom_jitter()
  # to spread out the values
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
    geom_point(position = "jitter")
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
    geom_point() +
    geom_jitter()
  
# 2 what parameters to geom_jitter() control the amount of jittering?
  ?geom_jitter
  # height and width control the amount of jittering

  