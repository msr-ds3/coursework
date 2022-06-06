#References
# https://ggplot2.tidyverse.org/reference/geom_jitter.html#arguments
# https://stackoverflow.com/questions/59337996/does-stroke-aesthetic-work-with-shapes-0-14

# 3.3.1
#1
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
#2
categorical = manufacturer, model, trans, drv, fl, class
continuous = displ, year, cyl, cty, hwy
view(mpg)
#3
continues variables work for size and color, not for shape. ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = cyl, color = year))

# 3.5.1
#1
It works fine. ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ year)
#4
The advantage is that it is easier to read. When using the color aesthetic it is easier to compare them. For a larger dataset, using facet may be better than color. There are limited colors and makes it hard to read.

# 3.6.1
#5
Both graphs look the same. It is just the code that is written in a different way. 
#6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv)) + geom_point() + geom_smooth()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv, color = drv)) + geom_point() + geom_smooth()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = drv)) + geom_smooth()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv)) + geom_point(mapping = aes(color = drv)) + geom_smooth(mapping = aes(linetype = drv))
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(shape = 21, mapping = aes(fill = drv), color = 'white', stroke = 1)

# 3.8.1
#1
The problem is overplotting. The points are on top of each other. It can be solved by using position = "jitter"
ggplot(data = mpg) + geom_point(mapping = aes(x = cty, y = hwy), position = "jitter")
#2
width and height
