library(tidyverse)
# Compute rate per 10,000
table1 %>% 
  mutate(rate = cases / population * 10000)
#> # A tibble: 6 × 5
#>   country      year  cases population  rate
#>   <chr>       <dbl>  <dbl>      <dbl> <dbl>
#> 1 Afghanistan  1999    745   19987071 0.373
#> 2 Afghanistan  2000   2666   20595360 1.29 
#> 3 Brazil       1999  37737  172006362 2.19 
#> 4 Brazil       2000  80488  174504898 4.61 
#> 5 China        1999 212258 1272915272 1.67 
#> 6 China        2000 213766 1280428583 1.67

# Compute cases per year
table1 %>% 
  count(year, wt = cases)
#> # A tibble: 2 × 2
#>    year      n
#>   <dbl>  <dbl>
#> 1  1999 250740
#> 2  2000 296920

# Visualise changes over time
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))


# exercise 12.2.1, #2
view(table2)

table2 %>%
  pivot_wider(names_from = type, values_from = count) %>%
  mutate(rate = (cases / population) * 10000) %>% view()

view(table4a)
view(table4b)

table4aOrdered <-pivot_longer(table4a, names_to = "year", values_to = "cases", 2:3)
table4bOrdered <-pivot_longer(table4b, names_to = "year", values_to = "population", 2:3)

table4 <- inner_join(table4aOrdered, table4bOrdered, by=c("country", "year")) %>%
  mutate(rate = (cases / population) * 10000) %>% view()

  
view(table4bOrdered)


stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
longer <- stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return") %>%

