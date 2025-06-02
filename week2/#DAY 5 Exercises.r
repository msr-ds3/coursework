#DAY 5 Exercises

## Combining and reshaping exercises

#12.2.1 Exercises
# Compute the rate for table2, and table4a + table4b. You will need to perform four operations:

# Extract the number of TB cases per country per year.
# Extract the matching population per country per year.
# Divide cases by population, and multiply by 10000.
# Store back in the appropriate place.
# Which representation is easiest to work with? Which is hardest? Why?






# 12.3.3 Exercises

# Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
# Carefully consider the following example:

# stocks <- tibble(
#   year   = c(2015, 2015, 2016, 2016),
#   half  = c(   1,    2,     1,    2),
#   return = c(1.88, 0.59, 0.92, 0.17)
# )
# stocks %>% 
#   pivot_wider(names_from = year, values_from = return) %>% 
#   pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")
# (Hint: look at the variable types and think about column names.)

# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). What does it do?








#What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?

people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)