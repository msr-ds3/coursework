library(nycflights13)
library(tidyverse)

flights <- nycflights13::flights

# Section 5.2.4, exercises 1 and 3

# 1. Find all flights that

# Had an arrival delay of two or more hours
flights |> 
  filter(arr_delay >= 120)

# Flew to Houston (IAH or HOU)
flights |> 
  filter(dest == "IAH" | dest == "HOU")

# Were operated by United, American, or Delta
flights |> 
  filter(carrier == "UA" | carrier == "AA" | carrier == "DL")

# Departed in summer (July, August, and September)
flights |> 
  filter(month == 7 | month == 8 | month == 9)

# Arrived more than two hours late, but didn’t leave late
flights |> 
  filter(arr_delay > 120 & dep_delay <= 0)

# Were delayed by at least an hour, but made up over 30 minutes in flight
flights |> 
  filter(dep_delay >= 60 & dep_delay - arr_delay > 30)

# Departed between midnight and 6am (inclusive)
flights |> 
  filter(dep_time == 2400 | dep_time <= 600 )

# 3. How many flights have a missing dep_time? What other variables are missing? 
#    What might these rows represent?

flights |> 
  filter(is.na(dep_time)) |> 
  summarise(count = n())

# These rows might represent canceled flights