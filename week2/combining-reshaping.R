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

# table2 %>% pivot_wider( name_from = type, values_from = count )%>%mutate(rate = cases / population * 10000)

# reshape first for table4 
# table4a %>% pivot_longer( name_from = "year",values_from  = "population",2:3)
# table4b %>% pivot_longer( name_from = "year",values_from  = "population",2:3)
# table4<-inner_join((table4a,table4b), by = c('country'='country'))%>% mutate(rate = cases / population * 10000)

# the easiest represenataionto work with was table2 since i didnt have to be too specific figuring out the code. 
# The years are stored as columns and the cases and popultaion also need to be chnaged in 4a and 4b by using pivot longer and join making 4a nd 4b harder 


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
# pivot_longer and pivot_wider are not perfectly symmetrical becauseafter it  is called the column names are stored as charcter strings 
# names_ptypes helps to convert the datat type of the column 
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


# people%>%group_by(name,names) %>% mutate(rank = row_number())%>% pivot_wider(names_from = names, values_from = values)
# Widening the table would cause a warning message because because there are 2 values that represent Phillip Woods
# To uniqluely identify, i can add a row number as an identifier to uniquley identify the difference between phillip woods 1 and phillip woods 2 
