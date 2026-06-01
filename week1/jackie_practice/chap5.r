library(nycflights13)
library(tidyverse)


# 5.2.4 accidentally did all the exercises (i need to be a better reader :-))
# Part One
# Had an arrival delay of two or more hours
flights %>% 
    filter(arr_delay >= 120)

# Flew to Houston
flights %>% 
    filter(dest == 'IAH' | dest == 'HOU') %>%
    select(origin, dest)

# Were operated by united american or delta
flights %>%
    filter(carrier == 'UA' | carrier == 'DL' | carrier == 'AA') %>%
    select(carrier)

# departed in summer (july, august, september)
flights %>%
    filter(month == '7' | month == '8' | month == '9') %>%
    arrange(month) %>%
    select(month)

# arrived more than two hours late, but didn't leave late
flights %>%
    filter(arr_delay > 120 & dep_delay <= 0) %>%
    select(arr_delay, dep_delay)

# were delayed by at least an hour, but made up over 30 minutes in flight
flights %>%
    filter(dep_delay >= 60 & arr_delay <= 30) %>%
    select(dep_delay, arr_delay)

# departed between midnight and 6am
flights %>%
    filter(dep_time <= 600 & dep_time >= 000) %>%
    arrange(dep_time) 

# Part Two
# 4
flights %>%
    filter(between(month, 7, 9)) %>%
    arrange(month) %>%
    select(month)

# 7
flights %>%
    filter(between(dep_time, 000, 600)) %>%
    arrange(dep_time)

# Part Three
# How many flights have a missing dep_time? What other variables are missing? What mights these rows represent?
# Pre guess: cancelled flights
flights %>%
    filter(is.na(dep_time))
# guess: still cancelled flights

# Part Four
# why is NA ^ 0 not missing? why is NA | TRUE not missing? why is FALSE & NA not missing? 
# What is the general rule
# not entirely sure
# For the NA | TRUE and NA & FALSE, my guess is that by definition if there is a TRUE in OR it is immediately TRUE
# and the same for FALSE in & 
# For the NA ^ 0, it may be the same thing where any number to the power of 0 is 1

# 5.5.2 ONLY exercise 2
# I see issues (like arr time and dep time can be in different time zones so they cannot accurately represent time in air)
# confusing
flights %>%
    select(air_time, arr_time, dep_time) %>%
    mutate(arr_minutes = ((arr_time %/% 100) * 60) + arr_time %% 100, dep_minutes = ((dep_time %/% 100) * 60) + dep_time %% 100) %>%
    mutate(dif = arr_minutes - dep_minutes) %>%
    arrange(desc(air_time)) 


# 5.7.1 exercise 3
flights %>%
    mutate(hour = dep_time %/% 100) %>%
    group_by(hour) %>%
    summarize(average_delay = mean(dep_delay)) %>%
    arrange(average_delay) %>%
    head(3)

# 4-6 AM
