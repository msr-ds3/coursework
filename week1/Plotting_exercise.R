library(tidyverse)
#################################################
#12.2.1 Exercises
#Compute the rate for table2, and table4a + table4b. You will need to perform four operations:


#1. Extract the number of TB cases per country per year.

#2. Extract the matching population per country per year.

#3. Divide cases by population, and multiply by 10000.

#4. Store back in the appropriate place.

# For table2
table2 %>%
  pivot_wider(names_from = type, values_from = count)%>%
  mutate(rate = cases / population * 10000)

table4a_new <- table4a %>%
  pivot_longer(names_to = "year", values_to = "cases", 2:3)

# For table4a + 4b
table4b_new <- table4b %>%
  pivot_longer(names_to = "year", values_to = "population", 2:3)

table4a_4b <- left_join(table4a_new, table4b_new) %>%
  mutate(rate = cases / population * 10000)
#################################################

# 12.3.3 Exercises


# 1. Why are pivot_longer() and pivot_wider() not perfectly symmetrical? Carefully consider the following example:

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# (Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). What does it do?


# Answer:
# pivot_wider converts the values to column names. pivot_longer() then reads them as characters, not their original type. Original types are not preserved when values become column na
# names_ptypes specifies the data type for the new column created from names. 


#3. What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
# Warning message:
  # Values from `values` are not uniquely identified; output will contain list-cols.
# I can give an id for it
people %>%
  mutate(unique_id = row_number()) %>%
  pivot_wider(names_from = names, values_from = values)


