library(tidyverse)

table1
table2
table3
table4a
table4b

# Section 12.2.1, exercise 2 - Compute the rate for table2, and table4a + table4b. 
# You will need to perform four operations:
# 1. Extract the number of TB cases per country per year.
# 2. Extract the matching population per country per year.
# 3. Divide cases by population, and multiply by 10000.
# 4. Store back in the appropriate place.

View(table2)

table2_cases <- table2 %>%
  filter(type == "cases") %>%
  rename(cases = count) %>%
  arrange(country, year)

table2_population <- table2 %>%
  filter(type == "population") %>%
  rename(population = count)
  arrange(country, year)

table2_cases_per_capita <- tibble(
  year = table2_cases$year,
  country = table2_cases$country,
  cases = table2_cases$cases,
  population = table2_population$population
) %>%
  mutate(cases_per_capita = cases / population * 10000) %>%
  select(country, year, cases_per_capita)

bind_rows(table2, table2_cases_per_capita) %>%
  arrange(country, year, type, count)

View(table4a)
View(table4b)

table4c <- tibble(
  country = table4a$country,
  `1999` = table4a[["1999"]] / table4b[["1999"]] * 10000,
  `2000` = table4a[["2000"]] / table4b[["2000"]] * 10000
)

table4c

# Section 12.3.3 exercise 1 - Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
# Carefully consider the following example:

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# pivot_longer treats all values as characters so datatype information is lost when using pivot_longer.

# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). What does it do?

# raises an error because the type of each variable is not saved when using pivot_wider

# Section 12.3.3 exercise 3 - What would happen if you widen this table? Why? 

# Produces columns that are lists of numeric vectors because the values in the name and key columns are not unique

# How could you add a new column to uniquely identify each value?

# Add a row with a count for each combination of name and key

people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)








