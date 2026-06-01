library(tidyverse)

####################################################################################
# 12.2.1. Exercise 2
# Compute the rate for table2, and table 4a + table4b. You will need
# to perform four operations:
#   1. Extract the number of TB cases per country per year.
#   2. Extract the matching population per country per year.
#   3. Divide cases by population, and multiply by 10000.
#   4. Store back in the appropriate place.

table2 %>%
pivot_wider(
  names_from = type,
  values_from = count
) %>%
mutate(rate = cases/population * 10000)

table4a_cases <- table4a %>%
pivot_longer(
  names_to = "year",
  values_to = "cases",
  2:3
)

table4b_population <- table4b %>%
pivot_longer(
  names_to = "year",
  values_to = "population",
  2:3
)

left_join(table4a_cases, table4b_population) %>%
mutate(rate = cases/population * 10000)

# Which representation is easiest to work with? Which is hardest? Why?
# Add your answer as a comment.

"""
Tidy Data in table 1 was the easiest to work with because no reshaping of the data 
was required to compute the rate.

Data spread across two tables, like in Table4a and Table4b was the hardest to work with
because I needed to reshape the data separately and then join them before being able to 
compute the rate.
"""

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
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return", names_ptypes = list(year = double()))

# (Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). 
# What does it do? Add your answer as a comment.

"""
The names_ptypes argument allows users to define the variable types of the newly created columns
from the names_to argument. Passing in double() coerces the data type into a double-precision.
floating point number. Without the names_ptypes argument, the year column was read as a character data type.
""" 


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

people %>%
pivot_wider(names_from = names, 
values_from = values, 
values_fn = list(values = mean)
)

"""
If we attempted to widen the table, we'd pivot the names column to have the entries age and height
as their own columns. It would take the values from the values column. However, following through
with implementation, we run into an error. Phillip Woods has two observations of differing ages.
This creates a data constraint because one cell cannot contain two data points. We solve this by
passing through the values_fn argument to aggregate duplicate values.
"""
