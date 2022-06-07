# 12.2.1
# Table 2 rate
table2_good <- pivot_wider(table2, names_from = type, values_from = count)
table2_good <- mutate(table2_good, rate = (cases / population) * 10000)
# Table4a + Table4b rate
new_table4a <- pivot_longer(table4a, names_to = "year", values_to = "cases", 2:3)
new_table4b <- pivot_longer(table4b, names_to = "year", values_to = "population", 2:3)
table4_good <- new_table4a
table4_good <- mutate(table4_good, population = select(new_table4b, population))
table4_good <- mutate(table4_good, rate = (cases / population) * 10000)

# Table 2 was the easiest to work with because I only had to use pivot_wider. 
# Table 4a + Table 4b was the hardest, because I had to put everything together and was a confusing process. Table4a and Table4b were a mess.

# 12.3.3
# Exercise 1
# When using pivot_wider and pivot_longer, column type information is lost. In the example, year is numeric, but after using pivot_wider and pivot_longer, year becomes a character.
# names_ptype is used to confirm the created columns are of the type we expected.
#Exercise 3
pivot_wider(people, names_from="names", values_from = "values")
# We get columns for the age and height. Since there are two values for the age of Phillip Woods, the age column stores a vector with the two values for the age.
# We can group the data frame by name and names, and then add a new column with the number of rows. Thus we get a Phillip Woods #1 and #2.
