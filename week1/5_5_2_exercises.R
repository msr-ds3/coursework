library(nycflights13)
library(tidyverse)

flights <- nycflights13::flights

# Section 5.5.2, exercise 2

# 2. Compare air_time with arr_time - dep_time. 
#    What do you expect to see? 
#    What do you see? 
#    What do you need to do to fix it?

flights |> 
  mutate(subtracted_time = arr_time - dep_time) |> 
  select(air_time, subtracted_time)

# We expected them to be the same
# We saw that usually arr-time - dep_time is greater than air_time
# We need to take into account time zone differences. 
# Before we subtract, we need to adjust the arrival time according to hours gained or lost during time zone traversal