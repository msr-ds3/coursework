library(tidyverse)
view(table4a)
view(table4b)


#Section 12.2.1, exercise 2 

#Question 2 for table2 
view(table2)
table2_pivoted <- pivot_wider(table2, names_from = type, values_from = count)

view(table2_pivoted)

table2_pivoted_with_rate <- mutate(table2_pivoted, rate = (cases / population) * 10000)


view(table2_pivoted_with_rate)


#Question 2 for table4a and table4b 

table4a_pivoted <- pivot_longer(table4a, names_to = "Year", values_to = "Cases" , -country)
table4b_pivoted <- pivot_longer(table4b, names_to = "Year", values_to = "pop" , -country)

view(table4a_pivoted)
view(table4b_pivoted)

tables_4_combined <- inner_join(table4a_pivoted, table4b_pivoted)

view(tables_4_combined)

tables_4_combined_mutated <- mutate(tables_4_combined, rate = (Cases / pop) * 10000)

view(tables_4_combined_mutated)

#--------------------------------------------------------------------------------------------

# Section 12.3.3 exercises 1

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)

head(stocks)

view(stocks)

stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

#pivot_wider makes the observations from year to columns names

#pivot_longer changed the years from being columns names to observations, which make it characters. 


# Section 12.3.3 exercises 3 

people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
people_piovted <- pivot_wider(people, names_from = names, values_from = values)

view(people_piovted)
# Phillip Woods has two observations for two values in the age column because there are two "Phillip Woods" exist twice in the data, which would mean there are two "Phillip Woods"
# The wider used the height for both "Phillip Woods"
# A solution for this, we can use a unique key or ID for each person, so that they would be treated as two different people in the data




