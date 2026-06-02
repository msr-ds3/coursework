library(tidyverse)

####################################################################################
# 12.2.1. Exercise 2
# Compute the rate for table2, and table 4a + table4b. You will need
# to perform four operations:
#   1. Extract the number of TB cases per country per year.
#   2. Extract the matching population per country per year.
#   3. Divide cases by population, and multiply by 10000.
#   4. Store back in the appropriate place.
table2%>%
group_by(year)%>%
pivot_wider(names_from = type,values_from = count)%>%
mutate(rate = (cases/population)*10000)

table4a<-table4a%>%
pivot_longer(-country,names_to = "year", values_to = "cases" )
table4b<-table4b%>%
pivot_longer(-country,names_to = "year", values_to = "Population")
inner_join(table4a,table4b)%>%
mutate(rate = (cases/Population)*10000)
# Which representation is easiest to work with? Which is hardest? Why?
# Add your answer as a comment.
# I would say in general First representation is easier to work as long as there is unique pairs of columns,
# while for this example since we have values for all the variables and pairs(i.e row not equal to N/A or missing) in Table4a and Table4b
# inner joins are also easy to work with


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
  pivot_wider(names_from = year, values_from = return)%>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return",names_ptypes =list(year = double()))

#pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return",names_transform = list(year = as.double))

# (Hint: look at the variable types and think about column names.)
# Since half column was not pivoted, the columns are ordered with half, then year and return but
# orginally they were ordered by year, half and then return

# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). 
# What does it do? Add your answer as a comment.
# names_ptypes checks for wheather the output of pivot_longer matches the given type, it is like type checking, it throws error when ever type is mismatched

####################################################################################
# 12.3.3 Exercise 3
# What would happen if you widen this table? Why?
# Pivot wider will assingn a value for all unique combination of c(name,names) but there are two values 
# for (Phillip Wood, age) it will not be tidy dataframe 
# How could you add a new column to uniquely identify each value?
# If added another column to identify them uniquely like a row_number, now all 
# c(name,names,row_number) would have a unique combination

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
mutate(row_num = row_number())%>%
pivot_wider(names_from =names, values_from = values)
