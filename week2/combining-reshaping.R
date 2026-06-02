library(tidyverse)

####################################################################################
# 12.2.1. Exercise 2
# Compute the rate for table2, and table 4a + table4b. You will need
# to perform four operations:
#   1. Extract the number of TB cases per country per year.
#   2. Extract the matching population per country per year.
#   3. Divide cases by population, and multiply by 10000.
#   4. Store back in the appropriate place.

#Using table 2
table2_with_rate <- 
  pivot_wider(table2, names_from = type, values_from = count) %>%
  mutate(rate = (cases / population) * 10000) 

#Using tables 4a + 4b
table4a_by_year <- pivot_longer(table4a, names_to = "year", values_to = "cases", -country)
table4b_by_year <- pivot_longer(table4b, names_to = "year", values_to = "population", -country)
table4_with_rate <- inner_join(table4a_by_year, table4b_by_year) %>%
    mutate(rate = (cases / population) * 10000) 

# Which representation is easiest to work with? Which is hardest? Why?
# Add your answer as a comment.
# Of the two, I found it easier to work with table 2 because the data only needed 
# to be reorganized once before it could be worked with, as opposed to needing to 
# needing to reorganize 2 separate tables and then join them. Of the 5, table1 is 
# the easiest to work with because it is already organized set up to calculate the rate.

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
  # pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return", names_transform = list(year = as.double))

# pivot_wider() and pivot_longer() put columns with values that do not pivot before those that do.
# Therefore, the order of the columns get reorganized as the table changes.

# (Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). 
# What does it do? Add your answer as a comment.
# pivot_longer() automatically casts the names column to a characters unless it is specifically instructed 
# not to with the names_transform argument.

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

widened_ppl <- pivot_wider(people, names_from = names, values_from = values)
people %>% 
  group_by(name) %>% 
  mutate(row_num = row_number()) %>% 
  pivot_wider(names_from = names, values_from = values)
# This causes an error and returns a table with 2 values in one of the cells, which violates the tidyverse 
# philosophy. In order to avoid this issue, add a column with a row number, causing all the values to stay on 
# separate rows. This is necessary because the extra age data point proves that the ages and heights may not match up.