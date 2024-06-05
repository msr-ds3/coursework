library(nycflights13)
library(tidyverse)

flights <- nycflights13::flights

# Section 5.7.1, exercise 3

# 3. What time of day should you fly if you want to avoid delays as much as possible?

flights |> 
  group_by(hour) |> 
  summarise(arr_delay = mean(arr_delay, na.rm = TRUE)) |> 
  arrange(arr_delay)

flights |> 
  group_by(hour) |> 
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) |> 
  arrange(dep_delay)