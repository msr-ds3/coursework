library(tidyverse)

########################12.2.1

###Question 2
table2 %>%
  filter(type == 'cases') %>%
  group_by(country, year) %>%
  summarize(TB_Cases = sum(count))

table4anew <- table4a %>%
  pivot_longer(c('1999','2000'), names_to = 'year', values_to = 'cases')
table4bnew <- table4b %>%
  pivot_longer(c('1999','2000'), names_to = 'year', values_to = 'population')

table4new <- inner_join(table4anew, table4bnew, by = c('country', 'year'))
table4new %>%
  mutate(rate = cases / population *10000) 

#using the first method with table2 was easier due to less steps

########################12.3.3

###Question 1
#The reason the pivot longer and wider are not symmetrical is due to the column type 
#information not being transferable between the functions and orginial table. 
#For example the year column in the provided table is numeric in the original table, 
#but after using pivot longer and wider, the year column is now a character vector


###Question 3
#Attempting to widen this table will result in an error because there are multiple
#observations of Phillip Woods including age. In order to fix there error, there must be 
#a column added to uniquely identify each observations/row of data. For example: if 
#there are two Phillip Woods in the US and both are citizens, a unique identifier will be 
#their social security number. 



