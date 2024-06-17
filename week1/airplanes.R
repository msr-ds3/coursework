library(nycflights13)
library(tidyverse)

flights |> 
    filter(dep_delay >= 120)

flights |>
    filter(dest == "IAH" | dest == "HOU")

flights |>
    filter(carrier == "AA" | carrier == "UA" | carrier == "DL")

flights |>
    filter(month >= 7, month <= 9)

flights |>
    filter(dep_delay <= 0, arr_delay >= 120)

flights |>
    filter(dep_delay >= 60, arr_delay <= dep_delay - 30)

flights |> 
    filter(dep_time == 2400 | dep_time <= 600)

flights |>
    filter(dep_time |> is.na()) |> View()

flights |>
    mutate(arr_time_real=arr_time%/%100*60 + arr_time %% 60, 
           dep_time_real=dep_time%/%100*60 + dep_time %% 60,
           calc_duration=arr_time_real-dep_time_real) |> 
    filter(calc_duration < air_time) |> View()

flights |>
    mutate(calc_sched_duration=sched_arr_time-sched_dep_time) |>
    select(calc_sched_duration, air_time)

flights |>
    group_by(hour) |>
    filter(!is.na(arr_delay)) |>
    summarize(avg_arr_delay=mean(arr_delay), avg_dep_delay=mean(dep_delay)) |>
    arrange(avg_arr_delay)
