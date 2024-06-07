library(tidyverse)

# Section 12.2.1, exercise 2
# Compute the rate for table2, and table4a + table4b. You will need to perform four operations:
#   Extract the number of TB cases per country per year.
#   Extract the matching population per country per year.
#   Divide cases by population, and multiply by 10000.
#   Store back in the appropriate place.
# Which representation is easiest to work with? Which is hardest? Why?

table2_modified <- table2 |>
    pivot_wider(names_from=type, values_from=count) |>
    mutate(rate=cases/population * 10000)

table2_modified |> View()

table4_modified <- 
    table4a |> 
    pivot_longer(names_to="year", values_to="cases", c(`1999`, `2000`)) |>
    inner_join(table4b |>
                   pivot_longer(names_to="year", values_to="population", c(`1999`, `2000`))
               , by=c("country", "year")) |>
    mutate(rate=cases/population * 10000)

table4_modified |> View()


# table4 was definitely harder. Since country was the same in both cases, but year was NOT,
# we first had to pivot both tables separately before we could merge them

# Section 12.3.3, exercise 1
# Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
#     Carefully consider the following example:
    
stocks <- tibble(
    year   = c(2015, 2015, 2016, 2016),
    half  = c(   1,    2,     1,    2),
    return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
    pivot_wider(names_from = year, values_from = return) %>% 
    pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")
# (Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). What does it do?

# When year is turned to a column name and back, it is converted to a character type
# Whereas it was originally a double
# But you could use names_ptypes to make sure that year becomes a number as expected

# exercise 3
# What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?
people <- tribble(
    ~name,             ~names,  ~values,
    #-----------------|--------|------
    "Phillip Woods",   "age",       45,
    "Phillip Woods",   "height",   186,
    "Phillip Woods",   "age",       50,
    "Jessica Cordero", "age",       37,
    "Jessica Cordero", "height",   156
)

people |>
    pivot_wider(names_from=names, values_from=values)

# The problem is that there are multiple values for Phillip Woods' age.
# He had the indecency to get older.
# We can solve this by grouping by name and names and adding row_number() for unique IDs
people |>
    group_by(name, names) |>
    mutate(id=row_number()) |>
    pivot_wider(names_from=names, values_from=values)

