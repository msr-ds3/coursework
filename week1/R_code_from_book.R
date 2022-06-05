#3.3.1 Exercises

#1. What’s gone wrong with this code? Why are the points not blue?
  
  ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# Because the aesthetic was inside mapping. If it was done outside
#   of it separately then the color would have changed to blue. 
#     Sample code:
ggplot(data = mpg)+
  geom_point(mapping = aes(x= displ, y= hwy), color = "blue")

#2. Which variables in mpg are categorical? 
#  Which variables are continuous? 
 # (Hint: type ?mpg to read the documentation for the dataset). 
  #How can you see this information when you run mpg?
   
# Categorical = manufacturer, model, trans, drv, fl, class
# Continious = hwy, cty, cyl, year, displ
mpg %>% View

#3. Map a continuous variable to color, size, and shape. 
#How do these aesthetics behave differently 
#for categorical vs. continuous variables

# Mapping shape to continuous variable was not possible.
# BUT mapping size and color to each variable was similar.

#3.5.1 Exercises 

#1. what happens if you facet on a continous variable?

# Using facet on a continous variable works well like with categorical
# But the graphical representation is messy with continous variable. 

#4. What are the advantages to using faceting instead of the colour aesthetic? What are the disadvantages? 
#How might the balance change if you had a larger dataset?

#Advantages: Facet creates a plot for each individual section. Color does it in one single plot. 
#Disadvantages: It is difficult to compare the data in while using the facet whilst using color can make the comparision easier. 
#For larger dataset using facet is better because the same color might repeat while using the color which makes the data interpretation difficult.

#3.6.1 
#5. Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#They will look same because ggplot in the first code will use the mapping as a global mapping for both geom_point() and geom_(smooth). 
#6.  
ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy)) + 
       geom_point() + 
       geom_smooth()

ggplot(data = mpg,
       mapping = aes(x = displ, y = hwy)) + 
        geom_point() + 
        geom_smooth(aes(group =drv))

ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy)) + 
        geom_point(aes(color = drv)) + 
        geom_smooth(aes(group =drv, color = drv))

ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy)) + 
        geom_point(aes(color = drv)) + 
        geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, linetype =drv)) +
             geom_point(aes(color = drv)) + 
             geom_smooth(aes(group =drv))


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(shape =21,
             mapping = aes(fill = drv), 
             color= 'white', 
             stroke =1) 

#3.8.1 
#1. What is the problem with this plot? How could you improve it?

#The plot has a problem of overplotting. It makes it harder to see the data because the points overlap each other. 
#sample code 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")

#2. What parameters to geom_jitter() control the amount of jittering? 
# Width and Height. 
