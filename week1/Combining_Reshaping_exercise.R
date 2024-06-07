library(tidyverse)
# Practice 12.2.1
#Compute the rate for table2, and table4a + table4b. You will need to perform four operations:

#Extract the number of TB cases per country per year.
TB_case_percountryyear <- pivot_wider(table2, names_from = type, values_from = count)%>%View()

table4a%>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")%>%
  left_join(pivot_longer(table4b, c(`1999`, `2000`), names_to = "year", values_to = "population"))%>%View()

#Extract the matching population per country per year.
#Divide cases by population, and multiply by 10000.
table2%>%
  pivot_wider(names_from = type, values_from = count)%>%
  mutate(rate = cases/population * 10000)

table4a%>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")%>%
  left_join(pivot_longer(table4b, c(`1999`, `2000`), names_to = "year", values_to = "population"))%>%
  mutate(rate = cases/population * 10000)%>%View()

#Store back in the appropriate place.

#Which representation is easiest to work with? Which is hardest? Why?


#Practice 12.3.3: Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
#Carefully consider the following example:
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")%>%View()

#Answer:The pivot_wider spread the years across the columns with variable "return" as values, so it is grouped by variable "half" across the rows. The original has more combinations between different variables. 
#The pivot_longer arranges by variable "half", then followed by "year" and "return". Compared to the orginizal, it's the order of the column that makes its value arranged differently. 


#What would happen if you widen this table? Why? 
#How could you add a new column to uniquely identify each value?
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
people%>%
  pivot_wider(names_from = names, values_from =  values)
#the pivot_wider function does not work 
#because there are 2 rows with the same name "Phillip Woods" and 2 different values for "age"
#since the values are not unique, pivot_wider does not work 

#we would add an id column to uniquely identify each value




