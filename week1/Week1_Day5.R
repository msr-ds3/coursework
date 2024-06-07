library(tidyverse)
#Exercise 12.2.1
# Compute the rate for table2, and table4a + table4b. You will need to perform four operations:
table2
table4a
table4b

# Extract the number of TB cases per country per year.
table2 %>% 
  pivot_wider(names_from=type, values_from=count) %>%
  select(country, cases, year)

table4a_Pivot <- pivot_longer(table4a, names_to="year", values_to="cases", 2:3)


# Extract the matching population per country per year.
table2 %>% 
  pivot_wider(names_from=type, values_from=count)

table4b %>% 
  pivot_longer(names_to="year", values_to="population", 2:3) %>%
  inner_join(table4a_Pivot)
  

# Divide cases by population, and multiply by 10000.
# Store back in the appropriate place.
table2 %>% 
  pivot_wider(names_from=type, values_from=count) %>%
  mutate(rate=cases/population*10000)


table4b %>% 
  pivot_longer(names_to="year", values_to="population", 2:3) %>%
  inner_join(table4a_Pivot) %>%
  mutate(rate=cases/population*10000)


#Exercises 12.3.3
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)


stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>%
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

stocks %>% 
  pivot_wider(names_from = year, values_from = return) 


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
  pivot_wider(names_from=names, values_from=values)

#Can't have duplicates of values for the same name values when pivoting wider

