library(tidyverse)

####################################################################################
# 12.2.1. Exercise 2
# Compute the rate for table2, and table 4a + table4b. You will need
# to perform four operations:
#   1. Extract the number of TB cases per country per year.
#   2. Extract the matching population per country per year.
#   3. Divide cases by population, and multiply by 10000.
#   4. Store back in the appropriate place.

# table2

table2 %>%
  pivot_wider(
    names_from=type,
    values_from=count
  ) %>%
  mutate(
    rate=cases/population * 10000
  )

# table 4a+4b
table4a_longer <- table4a %>%
  pivot_longer(
    2:3,
    names_to="year",
    values_to="cases"
  )

table4b_longer <- table4b %>%
  pivot_longer(
    2:3,
    names_to="year",
    values_to="population"
  )

left_join(table4a_longer, table4b_longer) %>%
  mutate(
    rate=cases/population * 10000
  )

# Which representation is easiest to work with? Which is hardest? Why?
# Add your answer as a comment.
# The first representation (with table 2) was definitely easier than working with table 4a+4b. 
# This is because table 2 was already joined and the only thing left was to reshape the data. 

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


# If pivot_longer() and pivot_wider() were symmetrical, they would result in the 
# original dataframe when used sequentially. However, the dataframe after using both
# pivot_longer() and pivot_wider() are slightly different. The columns are reordered,
# and the data type of the 'year' column changed from a chr type to a dbl type. 

# (Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()).
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return", names_ptypes=list(year=character())) 
# What does it do? Add your answer as a comment.
# It helps specify the type of the column with the name. It can be used to fix the data type. 

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
  pivot_wider(
    names_from=names,
    values_from=values
  )

# There is an error message that prints "Values from `values` are not uniquely identified; output will
# contain list-cols." This could be because certain people have multiple entries for 'age' and 'height'.

# You can add a new column that differentiates between each row as a unique identifier. 
# In this case, row_number() could work. 

people %>%
  mutate(rank=row_number()) %>%
  pivot_wider(
    names_from=names,
    values_from=values
  )

# This runs and outputs a new dataframe. There are NA values for the rows this time.

