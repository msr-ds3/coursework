# ---5.2.4---

# 1)
# 1
flights |> 
  filter(arr_delay >= 120)
  
# 2
flights |> 
  filter(dest == 'IAH' | dest == 'HOU')

# 3
flights |> 
  filter(carrier %in% c("AA", "UA", "DL"))

# 4
flights |> 
  filter(month >= 7 & month <= 9)

# 5
flights |> 
  filter(arr_delay > 120 & dep_delay <= 0)

# 6
flights |> 
  filter(dep_delay >= 60 & dep_delay - arr_delay > 30)

# 7
flights |> 
  filter(dep_time == 2400 | dep_time <= 600)


# 3)
flights |> 
  filter(is.na(dep_time))

# ---5.7.1---
flights |> 
  