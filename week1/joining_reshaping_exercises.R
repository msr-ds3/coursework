library(tidyverse)

#12.2.1 2
table2 <- table2
table4a
table4b
#Compute the rate for table2, and table4a + table4b. You will need to perform four operations:
  
#Extract the number of TB cases per country per year.
cases_by_country_year <- table2 |> 
  pivot_wider(names_from = type, values_from = count) |> 
  select(country, year, cases)
#Extract the matching population per country per year.
pop_by_country_year <- table2 |> 
  pivot_wider(names_from = type, values_from = count) |> 
  select(country, year, population)
#Divide cases by population, and multiply by 10000.
cases_per_pop <- cases_by_country_year |> 
  left_join(pop_by_country_year, by = c('country','year')) |> 
  arrange(year) |> 
  mutate(cases_per_pop = cases/population * 10000)
#Store back in the appropriate place.
table4anew <- table4a |> 
  pivot_longer(names_to = "year", values_to = "cases", -country) |> 
  arrange(year)
table4bnew <- table4b |> 
  pivot_longer(names_to = "year", values_to = "population", -country) |> 
  arrange(year)
table_complete <- table4anew |> 
  left_join(table4bnew) |> 
  mutate(year = as.numeric(year)) |> 
  left_join(cases_per_pop)
#Which representation is easiest to work with? Which is hardest? Why?
#The final representation is the easiest to work with because it includes pop, cases, and country as seperate values

#12.3.3 1
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")
#Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
#Because column information is lost when going from wide to long and cannot be retrived
#In this case, year changed from a numeric variable to a character

#12.3.3 3
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age?",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
people |> 
  pivot_wider(names_from = names, values_from = values) |> View()
#What would happen if you widen this table? Why? 
#The value in Philip's age is a vector because he has 2 different ages recorded
#How could you add a new column to uniquely identify each value?
people |> 
  group_by(name, names) |> 
  mutate(key = row_number()) |> 
  pivot_wider(names_from = names, values_from = values) |> View()

