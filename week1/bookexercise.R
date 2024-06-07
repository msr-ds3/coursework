library(nycflights13)
library(tidyverse)
view(flights)

flights %>%
  mutate(arr_hour_time = arr_delay/60)  %>% 
  filter(arr_hour_time>= 2 )  %>% view()

flights %>%
  filter(dest == 'IAH' | dest =='HOU')  %>% view()

flights %>%
  filter(carrier== 'AA' | carrier== 'UA' | carrier== 'DL')  %>% view()

flights %>%
  filter(month >=7 && month <=9)  %>% view()

flights %>%
  mutate(arr_hour_time = arr_delay/60)  %>% 
  filter(arr_hour_time>= 2 )  %>%
  filter(dep_delay<=0)  %>% view()
  
flights %>%
  filter(dep_delay>= 60)  %>% 
  mutate(made_up_time = dep_delay - arr_delay) %>%
  filter(made_up_time >30) %>%
  view()

flights %>%
  filter(dep_time <= 600) %>%
  view()

sum( is.na(flights$dep_time))
r
