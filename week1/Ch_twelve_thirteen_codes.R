#chapter 12 & 13 exercises


#12.2.1
#Extract the number of TB cases per country per year.

#Table2

table2_rate_calculation <- pivot_wider(table2, 
                                       names_from = type, values_from = count )
mutate(table2_rate_calculation, 
       rate= (cases/population)*10000)

#table4a + table4b
table4a %>% View
table_four_a <- pivot_longer(table4a, c('1999', '2000'), 
                             names_to = "year", 
                             values_to = "cases")
table_four_b <- pivot_longer(table4b, c('1999', '2000'), 
                             names_to = "year", 
                             values_to = "population")
merged_table_four <- table_four_a
merged_table_four <- mutate(merged_table_four, 
                            population = select(table_four_b, 
                                                population)) 
mutate(merged_table_four, rate = (cases/population) * 10000) 

#It was easier to work with table2 beacuse 
#for table4a + table4b, we had to bring the whole table together as one. 


#12.3.3
#1. Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
#They are not perfectly symmetrical because we can see in the example that the 
#type of the column for Year changes from numeric to character. This means that
#the information is lost when converting from wide to long. Also, focusing
#in the example, we can observe that the data gets tidy with the use of 
#pivot_longer() with half, year and return column. 
#The use of names_ptype argument gives an error by not being able to 
#convert the column from character to numeric vector. 

#3. What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?

people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

#Sample Code: 
pivot_wider(people, names_from = name, values_from = values)

#widening this table gives us two rows for each name because the columns do not 
#identify each row. To solve this we can add a row giving count for 
# the name and (age/height)
#sample code:
revised_people_table <- people %>%
  group_by (name, key) %>%
  mutate(obs = row_number())

