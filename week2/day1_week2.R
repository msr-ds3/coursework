# R for Data Science Chapter 12


# Section 12.2.1, exercise 2:
# 2. Using prose, describe how the variables and observations organized in the sample tables?

# In table 1: Each row is organized by country and year. The columns are the five case and population for that given year and country. 
# In table 2: Each row represents a country, year, and variable. The column cuont contains the value of the variable in that row (pop or cases). 
# Table 3: Each row represents a country and year. The column rate is the cases divided by the population.
# Table 4 is spread across two tibbles. 
# in 4a: Each row represents a country. Each column is a year - 1999 and 2000 that contains the cases. 
# in 4b: Each row represents a country. The columns are the years - 1999 and 2000 that contains the population.  


# Section 12.3.3, exercise 1 and 3:
# 1. pivot_longer() and pivot_wider() are not perfectly symmetrical. 
# pivot_wider creates column names from values in columns. The example will have a table with columns: year, 1, 2 and the values will come from the return vector. 
# pivot_wider makes a 2 x 3 table in the example. 
# pivot longer combines 2015 and 2016 to one column called year. It stacks the columns into a single column with one data type. 
# pivot_longer makes a 4 x 3 table. 


# 3. 
# if you widened this table, the columns would be name, age, height, and value. di
# This would make the table more tidy because each variable has its own column each obersevation its own row. 
# the code would be: 
# people %>%
#    pivot_wider(names_from = names, values_from = values)


# Do part 1 of Datacamp's Cleaning Data in R tutorial. 



# Rmarkdown
# read chapter 27 in R for Data Science on Rmarkdown. 

# section 27.1.1, exercises 1 and 2:
# 1 and 2. ctrl-shift enter to play a chunk, ctrl-shift k to play the entire file. 

# section 27.1.1, exercise 3:
# 1 made cv and 3 downloaded diamonds-sizes.Rmd and added content. 

# Section 27.4.7 exercise 1:
# done. edited diamond-sizes.Rmd




