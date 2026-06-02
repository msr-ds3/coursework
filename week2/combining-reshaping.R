library(tidyverse)

####################################################################################
# 12.2.1. Exercise 2
# Compute the rate for table2, and table 4a + table4b. You will need
# to perform four operations:
#   1. Extract the number of TB cases per country per year.
#   2. Extract the matching population per country per year.
#   3. Divide cases by population, and multiply by 10000.
#   4. Store back in the appropriate place.
table2%>%
  group_by(year)%>%
  pivot_wider(names_from = type, values_from = count)%>%
  mutate(rate = cases / population * 10000)

taba <- table4a%>%
  pivot_longer(names_to = "year", values_to = "case", -country)
tabb <- table4b%>%
  pivot_longer(names_to = "year", values_to = "population", -country)
left_join(taba, tabb, by = c("country", "year"))%>%
  mutate(rate = case / population * 10000)

# Which representation is easiest to work with? Which is hardest? Why?
# Add your answer as a comment.

# Working with these two tables, I personnaly think that the table2 was the easiest to work with
# because every country is already separated based on the year, type,and count. Matching the cases, and population,
# is much easier after we group the countries yearly. However, the two table4 are the hardest to work with 
# because the values that we need are separated in two different tables and we need to combine them back to be able to use them.
# Basically, the table4 isn't that hard to work with, it just requires more steps and a deeper analysis.

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

# (Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). 
# What does it do? Add your answer as a comment.

# I think pivot_longer() and pivot_wider() aren't perfectly symmetrical 
# because when you pivot you change the nature of the data like the columns,
# When we pivot_wider() from the original data frame, each colum contains the half
# and return by corresponding year, which is provided column wise. It is kind of a confusing dataset.
# pivot_longer() defines the class, attributes, and types of a vector. It's mostly used 
# to be sure that the columns we've created are what we expected. It's not to change the given table. 

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

# This won't be balanced if we widen the table because we have two "ages" for Phillip with one "height" only
# and only one "age" and "height" for Jessica.

# people%>%
#   group_by(name, names)%>%
#   mutate(nouv=row_number())%>%
#   pivot_wider(names_from = name, values_from = values)
