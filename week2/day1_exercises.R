library(tidyverse)
#12.3.3 - 2


#Why does this code fail?

#table4a %>% pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")

#> Error: Can't subset columns that don't exist.
#> ✖ Locations 1999 and 2000 don't exist.
#> ℹ There are only 3 columns.
#> 1999 and 2000 should have quotes around them because they are strings (chr) not ints
#> 


# Section 12.3.3 exercises 1 and 3
# 1) Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# pivot_wider becomes a 2x3 table from a 4X3 table, in which the years become each one a col and 
# since they are variables they are made into strings from dbls

# pivot_longer stays a 4x3 table but the years are made into characters from dbls 

