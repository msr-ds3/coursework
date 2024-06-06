library(tidyverse)

# get the flights dataset
flights <- nycflights13::flights

# viewing
flights %>%
  View

# using filter to get all instances of 2+ hr delays
flights %>%
  filter( dep_delay > 120 ) %>%
  View

# using arrange to sort delay in descending order
flights %>%
  arrange( desc(dep_delay) ) %>%
  View

# using distinct to get all the unique pairs of airports
flights %>%
  distinct( origin, dest, .keep_all = TRUE) %>%
  View

# get the flights that have arrival delay of 2+ hrs
flights %>%
  filter( arr_delay >= 120 ) %>%
  View

# get flights that landed in Houston
flights %>%
  filter( dest == "IAH" | dest == "HOU") %>%
  View

# get flights operated by United Airlines, American, or Delta
flights %>%
  filter( carrier %in% c("UA", "AA", "DL") ) %>%
  View

# get flights departed in summer
flights %>%
  filter( month %in% c(7, 8, 9) ) %>%
  View

# get flights 
flights %>%
  filter( arr_delay >= 120 & dep_delay <= 0 ) %>%
  arrange( month, day ) %>%
  View

# get flights delayed by 1+hrs but made up more than 30 mins in flight
flights %>%
  filter( dep_delay >= 60 & arr_delay < dep_delay - 30) %>%
  arrange( month, day ) %>%
  View

# get flights leaving between midnight and 6am
flights %>%
  filter( dep_time %in% 0:600 ) %>%
  View

# find the longest departure delays
flights %>%
  arrange( desc(dep_delay) ) %>%
  head( 10 ) %>%
  View

# find the flights the left earliest in the morning
flights %>%
  arrange( dep_time, month, day ) %>%
  head( 10 ) %>%
  View

flights %>%
  filter( is.na(dep_time) ) %>%
  View

