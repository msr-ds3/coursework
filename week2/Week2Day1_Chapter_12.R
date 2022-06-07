#Week 2 Day 1

library(tidyverse)

#12.2.1 Exercise 2
# Compute the rate for table2, and table4a + table4b. 
# You will need to pec(rform four operations:
# Extract the number of TB cases per country per year.
# Extract the matching population per country per year.
# Divide cases by population, and multiply by 10000.
# Store back in the appropriate place.
# Which representation is easiest to work with? Which is hardest? Why?

table2 %>% 
  pivot_wider(names_from = type, values_from = count) %>% 
  mutate(rate = cases / population *10000)

table4anew <- table4a %>%
  pivot_longer(c('1999','2000'), names_to = 'year', values_to = 'cases')
table4bnew <- table4b %>%
  pivot_longer(c('1999','2000'), names_to = 'year', values_to = 'population')

table4new <- inner_join(table4anew, table4bnew, by = c('country', 'year'))
table4new %>%
  mutate(rate = cases / population *10000)

# Table2 was easier to work with since I only needed to adjust one table to 
# create a new column for the rate. Working with two tables requires extra work
# since I needed to adjust both of the tables in order to join them together to 
# perform the calculations to find the rate.

# 12.3.3 Exercise 1

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# When running the pivot_longer(), the "years" data type becomes characters 
# rather than doubles. 

# 12.3.3 Exercise 3

people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

# Since Phillip Woods has two ages listed, we are prompted with a warning 
# message stating that not all values are uniquely identified, and if we
# were to proceed with the pivot_wider() the output would contain list-cols.
# To fix this we can create a column 'key' to create a unique key to track 
# repeated instances, but not have to deal with the list-cols.

