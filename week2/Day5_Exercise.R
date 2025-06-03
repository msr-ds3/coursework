library(tidyverse)
# 12.2.1 Q2
view(table1)
view(table2)
view(table4a)
view(table4b)
inner_join(table4a, table4b, mutate())
table2m <- pivot_wider(table2, names_from =  type, values_from = c(count))
view(table2m)
table2m <- mutate(table2m, ratio = (cases/population) *10000)
view(table2m)

table4aa <- pivot_longer(table4a, names_to = "year", values_to = "cases", -country)
table4bb <- pivot_longer(table4b, names_to = "year", values_to = "population", -country)

table4 <- view(inner_join(table4a, table4b, by = c("country", "year")))
mutate(table4, ratio = (cases/population) *10000)

#12.3.3 Q1
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# pivot_wider : makes the observation from year column into new columns 
# pivot_longer : makes the year columns into observations which makes it chr from column type

# Q3 What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?

people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
view(pivot_wider(people, names_from = names, values_from = values))
# age column for Phillip Woods has two values because there are two different ages given for the same name
# The unique column should be added which has numbers from 1 to 10 for example where age and height for the same name has the same ID number so that when pivot_wider is applied the age and height is paired because of the same ID number
# The same name with different age will be treated as a sep row

# 27.2.1 Q1
#Ctrl shift K

# 
