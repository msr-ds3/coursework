########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)
theme_set(theme_bw())
#Section 12.2.1, exercise 2
#Compute the rate for table2, and table4a + table4b. You will need to perform four operations:
table_2 <- table2 |> pivot_wider(names_from = type, values_from=count) |> mutate(rate=(cases/population)*10000)

#solution for table4a table4b
table4a <- tidyr::table4a #cases
table4b <- tidyr::table4b #population
table4a <- table4a |> pivot_longer(cols=2:3, names_to = "year", values_to = "cases")
table4b <- table4b |> pivot_longer(cols=2:3, names_to = "year", values_to = "population")
joined_tables <- inner_join(table4a, table4b, by=c("country", "year")) |> mutate(rate=(cases/population)*10000)
view(joined_tables)
#Extract the number of TB cases per country per year.
#Extract the matching population per country per year.
#Divide cases by population, and multiply by 10000.
#Store back in the appropriate place.
#Which representation is easiest to work with? Which is hardest? Why?
#the second because its more lines to pivot first then join. i only knew how to pivot because i already did it with the first version and matches my pivot 
#outputs to the first given table 


#Section 12.3.3 exercises 1 and 3
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

view(stocks |> pivot_wider(names_from = year, values_from = return))
view(stocks |> pivot_wider(names_from = year, values_from = return) |> pivot_longer('2015':'2016', names_to = "year", values_to = "return"))
#Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
#Carefully consider the following example:
#(Hint: look at the variable types and think about column names.)
#visually its symmetrical but may not produce the same df after a pivot wider then longer because you recast the type
#to character after a pivot wider then when it goes back into the column its still gonna be type char when it was previously a double
#this makes it not perfectly symmetirc. names_ptypes sets the type of the column to avoid this problem...

#pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). What does it do?


#What would happen if you widen this table? Why? 
#when you pivot_wider(names_from = names, values_from = values) it outputs a df with 2 rows 
#1 row is for philip woods and 1 row for jessica cordero which could be a problem because theres a philip woods w
#whos 45 and a philip woods whose 50.  both ages are listed in row 1 for philip,,,


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
#view(people |> pivot_wider(names_from = names, values_from=values))
#its impossible to do that right now with the given data, when collecting data we must get a UID
#for each observation because in theory there could be 2 different people with the same age, name, and height

