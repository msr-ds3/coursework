# Chapter 12

library(tidyverse)
library(dplyr)

table1
#> # A tibble: 6 x 4
#>   country      year  cases population
#>   <chr>       <int>  <int>      <int>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3 Brazil       1999  37737  172006362
#> 4 Brazil       2000  80488  174504898
#> 5 China        1999 212258 1272915272
#> 6 China        2000 213766 1280428583

table2
#> # A tibble: 12 x 4
#>   country      year type           count
#>   <chr>       <int> <chr>          <int>
#> 1 Afghanistan  1999 cases            745
#> 2 Afghanistan  1999 population  19987071
#> 3 Afghanistan  2000 cases           2666
#> 4 Afghanistan  2000 population  20595360
#> 5 Brazil       1999 cases          37737
#> 6 Brazil       1999 population 172006362
#> # … with 6 more rows
table3
#> # A tibble: 6 x 3
#>   country      year rate             
#> * <chr>       <int> <chr>            
#> 1 Afghanistan  1999 745/19987071     
#> 2 Afghanistan  2000 2666/20595360    
#> 3 Brazil       1999 37737/172006362  
#> 4 Brazil       2000 80488/174504898  
#> 5 China        1999 212258/1272915272
#> 6 China        2000 213766/1280428583

# Spread across two tibbles
table4a  # cases
#> # A tibble: 3 x 3
#>   country     `1999` `2000`
#> * <chr>        <int>  <int>
#> 1 Afghanistan    745   2666
#> 2 Brazil       37737  80488
#> 3 China       212258 213766
table4b  # population
#> # A tibble: 3 x 3
#>   country         `1999`     `2000`
#> * <chr>            <int>      <int>
#> 1 Afghanistan   19987071   20595360
#> 2 Brazil       172006362  174504898
#> 3 China       1272915272 1280428583


# Question 12.2.1

# 1
#> In table1, there are 4 columns for country, year, cases, and population. 
#> In table2, instead of "cases" and "population," there is a new column "type" which lists either cases
#> or population and another column "count" which lists the value from table1 for each respective "type."
#> In table3, the "cases" and "population" is merged into a "rate" column (cases/population).
#> In table 4a, the years each get their own column with the number of cases in those years listed.
#> In table 4b, the years again get their own columns but now the population sizes are listed. 

# 2 Compute the rate for table2 and table4a+table4b

  # table2

  table2
  t2_cases <- table2 %>% 
    filter(type == "cases") %>%
    mutate(join = c(1:6))
  t2_population <- table2 %>% 
    filter(type == "population") %>%
    mutate(join = c(1:6))
    
  t2_join <-  inner_join(t2_cases, t2_population, by = 'join')
  
  t2_rate <- t2_join %>% transmute(country = t2_cases$country, 
                                     year = t2_cases$year,
                                     rate = (count.x / count.y) * 10000)
  
  t2_rate_for_combine <- t2_rate %>% transmute(country = t2_cases$country, 
                                    year = t2_cases$year,
                                    type = 'rate', count = rate)
  
  table2 <- bind_rows(table2, t2_rate_for_combine) %>%
    arrange(country, year, type, count)
  
  ?rbind()
  ?bind_rows()
  
  # can use pivot_wider() and pivot_longer()
  
    table2 <- table2 %>% 
      pivot_wider(names_from = "type", values_from = "count") %>%
      mutate(rate = (cases / population) * 10000) %>%
      pivot_longer("cases":"rate", names_to = "type", values_to = "count")
  
  # table4a + table4b
  
    table4c <- tibble(country = table4a$country,
                      '1999' = (table4a$`1999` / table4b$`1999`) * 10000,
                      '2000' = (table4a$`2000` / table4b$`2000`) * 10000)
    
# Which representation is easiest to work with? With is hardest?
  #> The easiest representation to work with is table1, as the problem of adding rate can be solved using mutate()
  #> The hardest representation is table 2, as you need to first separate the cases and population into 2
  #> separate tables and then use those to generate a third rate table. You then need to rearrange the columns
  #> So that there is "type" and "count" so as to match table2 so you can bind the rows.
  #> table4a+table4b is simpler than table2, but you still have to create a new table for rates and 
  #> divide the values from the original 2 tables. 

# Recreate the plot showing change in cases over time using table2 instead of table1. What do you need to do first?
    
  table2 %>% 
    filter(type == "cases") %>%
    ggplot(aes(x = year, y = count)) +
    geom_line(aes(group = country)) + 
    geom_point(aes(color = country)) +
    ylab(label = "cases")

  #> you first need to filter for where type is "cases" 

# Question 12.3.3
  
#1 Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
  
  stocks <- tibble(
    year   = c(2015, 2015, 2016, 2016),
    half  = c(   1,    2,     1,    2),
    return = c(1.88, 0.59, 0.92, 0.17)
  )
  
  stocks %>% 
    pivot_wider(names_from = year, values_from = return) %>% 
    pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")
  
  #> When the years becomes column names in pivot_wider(), they are converted to 
  #> strings and they become character types when using pivot_longer().
  #> pivot_wider() and pivot_longer() do not preserve the original data type. 
  
# pivot_longer() has names_ptypes argument. What does it do?
  ?pivot_longer()
  
  
# 3 What would happen if you widen this table? How could you add a new column to uniquely identify each value?
  
  people <- tribble(
    ~name,             ~names,  ~values,
    #-----------------|--------|------
    "Phillip Woods",   "age",       45,
    "Phillip Woods",   "height",   186,
    "Phillip Woods",   "age",       50,
    "Jessica Cordero", "age",       37,
    "Jessica Cordero", "height",   156
  )

  pivot_wider(people, names_from = "names", values_from = "values")
  
  # This errors out, as Phillip Woods has 2 ages listed
  # You could add a new column with mutate()
  
  people %>% mutate(id = c(1:5)) %>%
    pivot_wider(names_from = "names", values_from = "values")
  
  # (this does not really solve the issue though because we are unsure Phillip's actual age)
  

  
  
  