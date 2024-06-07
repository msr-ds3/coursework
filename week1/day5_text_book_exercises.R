library(tidyverse)

table1
#> # A tibble: 6 × 4
#>   country      year  cases population
#>   <chr>       <dbl>  <dbl>      <dbl>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3 Brazil       1999  37737  172006362
#> 4 Brazil       2000  80488  174504898
#> 5 China        1999 212258 1272915272
#> 6 China        2000 213766 1280428583
table2
#> # A tibble: 12 × 4
#>   country      year type           count
#>   <chr>       <dbl> <chr>          <dbl>
#> 1 Afghanistan  1999 cases            745
#> 2 Afghanistan  1999 population  19987071
#> 3 Afghanistan  2000 cases           2666
#> 4 Afghanistan  2000 population  20595360
#> 5 Brazil       1999 cases          37737
#> 6 Brazil       1999 population 172006362
#> # ℹ 6 more rows
table3
#> # A tibble: 6 × 3
#>   country      year rate             
#>   <chr>       <dbl> <chr>            
#> 1 Afghanistan  1999 745/19987071     
#> 2 Afghanistan  2000 2666/20595360    
#> 3 Brazil       1999 37737/172006362  
#> 4 Brazil       2000 80488/174504898  
#> 5 China        1999 212258/1272915272
#> 6 China        2000 213766/1280428583

# Spread across two tibbles
table4a  # cases
#> # A tibble: 3 × 3
#>   country     `1999` `2000`
#>   <chr>        <dbl>  <dbl>
#> 1 Afghanistan    745   2666
#> 2 Brazil       37737  80488
#> 3 China       212258 213766
table4b  # population
#> # A tibble: 3 × 3
#>   country         `1999`     `2000`
#>   <chr>            <dbl>      <dbl>
#> 1 Afghanistan   19987071   20595360
#> 2 Brazil       172006362  174504898
#> 3 China       1272915272 1280428583


## Combining and reshaping exercises

# Section 12.2.1, exercise 2

# 2. Compute the rate for table2, and table4a + table4b. You will need to perform four operations:
  
# Extract the number of TB cases per country per year.
# Extract the matching population per country per year.
# Divide cases by population, and multiply by 10000.
# Store back in the appropriate place.
# Which representation is easiest to work with? Which is hardest? Why?

table2 |> 
  pivot_wider(names_from = type, values_from = count) |> 
  mutate(rate = cases/population * 10000)

table4a |> 
  pivot_longer(names_to = "year", 
               values_to = "cases", 
               cols = c("1999", "2000")) |> 
  full_join(table4b |> 
              pivot_longer(names_to = "year", 
                           values_to = "population", 
                           cols = c("1999", "2000"))) |> 
  mutate(rate = cases/population * 10000)

# Depending on the situation, either "wider" or "longer" representation is easier to work with.
# Table 2 was easier since everything was already together, and we could reshape the data frame directly.
# Table 4 required us to reshape and join to achieve the same results.


# Section 12.3.3 exercises 1 and 3

# 1. Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
# Carefully consider the following example:
  
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)

stocks

stocks %>% 
  pivot_wider(names_from = year, values_from = return) |> 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# (Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). What does it do?
# It is not perfectly symmetrical because the when we use pivot_wider, we organize by the half col
# When we go back using pivot_longer, the organization is still with half, instead of year.

# 3. What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?
  
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
  pivot_wider(names_from = names, values_from = values)
    
# We will get a warning if we try to widen this table because not all rows are unique. 
# For instance, for Phillip Woods Age 45 and Phillip Woods Age 50, the name/names combo is not unique
# It is possible that two people are named Phillip Woods. R won't know which age value to use when it groups Phillip Woods

# A new column with a unique ID can solve this issue. It will allow us to distinguish between similar names.


## Rmarkdown

# Section 27.2.1, exercises 1 and 2 (try keyboard shortcuts: ctrl-shift-enter to run chunks, and ctrl-shift-k to knit the document)

# 1. Create a new notebook using File > New File > R Notebook. Read the instructions. 
#    Practice running the chunks. 
#    Verify that you can modify the code, re-run it, and see modified output.

# 2. Create a new R Markdown document with File > New File > R Markdown… 
#    Knit it by clicking the appropriate button. 
#    Knit it by using the appropriate keyboard short cut. 
#    Verify that you can modify the input and see the output update.

# Section 27.3.1 exercise 3, using this file

# Copy and paste the contents of diamond-sizes.Rmd from https://github.com/hadley/r4ds/tree/master/rmarkdown in to a local R markdown document. 
# Check that you can run it, then add text after the frequency polygon that describes its most striking features.

# Section 27.4.7, exercise 1

# Add a section that explores how diamond sizes vary by cut, colour, and clarity. 
# Assume you’re writing a report for someone who doesn’t know R, and instead of setting echo = FALSE on each chunk, set a global option.
