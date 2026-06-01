library(tidyverse)

####################################################################################
# 12.2.1. Exercise 2
# Compute the rate for table2, and table 4a + table4b. You will need
# to perform four operations:
#   1. Extract the number of TB cases per country per year.
#   2. Extract the matching population per country per year.
#   3. Divide cases by population, and multiply by 10000.
#   4. Store back in the appropriate place.

# Which representation is easiest to work with? Which is hardest? Why?
# Add your answer as a comment.
# ANSWER: The easier representation to work with for this task was table 2, I just
# needed to pivot the type/count and then add a new value for rate
# The harder representation was the two tables because I had to pivot their values 
# to see case/population values for each country and year and then join them

# For table2
# Step One and Two
pivot_wider(table2, names_from = type, values_from = count) %>%
  mutate(rate = (cases / population) * 10000) # Step Three/Four

# For table 4a + 4b
# Step One
table_2a_long <- pivot_longer(table4a, names_to = "years", values_to = "cases", 2:3) 
table_2b_long <- pivot_longer(table4b, names_to = "years", values_to = "population", 2:3) 
table_2a_long
table_2b_long 
inner_join(table_2a_long, table_2b_long) %>%
  mutate(rate = (cases / population * 10000))

####################################################################################
# 12.3.3 Exercise 1
# 1. Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
# Carefully consider the following example:
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

stocks
pivot_wider(stocks, names_from = year, values_from = return) %>%
pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# (Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). 
# What does it do? Add your answer as a comment.

# pivot_wider takes in primarily the dataframe, names_from, and values_from
# you can also specify what columns you want to pivot and other actions with 
# other arguments
# names_from and values_from both should refer to the field or column name 
# that already exists in the dataframe
# it takes distinct values from the names_from column, makes those the new columns
#, and the values for those columns are taken from the values from the values_from column

# pivot_longer primarily takes in the dataframe, names_to, and values_to
# Like pivot_wider, there are also many other arguments that you can fill
# in to specify what columns you want to pivot/other actions
# names_ptypes allows you to confirm that the types of the new columns are the type you want
# names_ptypes = list(year = double()) will check that the year column you are "creating"
# is of the type double.

####################################################################################
# 12.3.3 Exercise 3
# What would happen if you widen this table? Why? 
# How could you add a new column to uniquely identify each value?
#  Add your answers as a comment.
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

# Pivot_wider issue: The values from the values column will stack

people %>%
  group_by(names, name) %>%
  mutate(id = row_number()) %>%  
  pivot_wider(id_cols = c(name, id), names_from = names, values_from = values)