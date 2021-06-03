library(nycflights13)
library(tidyverse)
library(lubridate)

View(flights)

# 5.2.4 Exercise 1 - Find all flights that had an arrival delay of two or more hours

flights %>%
  filter(arr_delay >= 2) %>%
  View

# 5.2.4 Exercise 3 - Find all flights that were operated by United, American, or Delta

flights %>%
  filter(carrier %in% c("UA", "AA", "DL")) %>%
  View

# 5.5.2 Exercise 2 - Currently dep_time and sched_dep_time are convenient to look at, but hard to compute
# with because they're not really continuous number. Convert them to a more convenient representation of
# number of minutes since midnight.

flights %>%
  transmute(sched_dep_time_in_mins_since_mid = (sched_dep_time %% 100) * 60 + sched_dep_time %% 100,
            dep_time_in_mins_since_mid = (dep_time %% 100) * 60 + dep_time %%100) %>%
  View

# 5.7.1 Exercise 3 - What time of day should you fly if you want to avoid delays as much as possible?

flights %>%
  group_by(hour(time_hour)) %>%
  summarize(avg_delay = mean(dep_delay, na.rm=TRUE)) %>%
  arrange(avg_delay) %>%
  View

