library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('201402-citibike-tripdata.csv')

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# convert dates strings to dates
# trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))


########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
# Input: 
summarize(trips, count = n())
"""
Output: 
count
   <int>
1 224736
"""
# find the earliest and latest birth years (see help for max and min to deal with NAs)
# Input:
mutate(trips, n_birth_year = as.numeric(birth_year))
min(trips[, "n_birth_year"], na.rm = TRUE)
max(trips[, "n_birth_year"], na.rm = TRUE)

"""
Output: 
[1] 1899
[1] 1997
"""
# use filter and grepl to find all trips that either start or end on broadway
# Input: 
filter(trips, grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))
"""
Output: 
# A tibble: 41,469 × 16
   tripduration starttime           stoptime            start_station_id
          <dbl> <dttm>              <dttm>                         <dbl>
 1          372 2014-02-01 00:00:03 2014-02-01 00:06:15              285
 2          583 2014-02-01 00:00:32 2014-02-01 00:10:15              357
 3          439 2014-02-01 00:02:14 2014-02-01 00:09:33              285
 4          707 2014-02-01 00:02:50 2014-02-01 00:14:37              257
 5          695 2014-02-01 00:06:53 2014-02-01 00:18:28              490
 6          892 2014-02-01 00:07:22 2014-02-01 00:22:14              499
 7          636 2014-02-01 00:08:25 2014-02-01 00:19:01              285
 8          878 2014-02-01 00:09:03 2014-02-01 00:23:41              497
 9         1064 2014-02-01 00:12:27 2014-02-01 00:30:11              444
10          469 2014-02-01 00:12:40 2014-02-01 00:20:29              497
# ℹ 41,459 more rows
# ℹ 12 more variables: start_station_name <chr>, start_station_latitude <dbl>,
#   start_station_longitude <dbl>, end_station_id <dbl>,
#   end_station_name <chr>, end_station_latitude <dbl>,
#   end_station_longitude <dbl>, bikeid <dbl>, usertype <chr>,
#   birth_year <chr>, gender <fct>, n_birth_year <dbl>
# ℹ Use `print(n = ...)` to see more rows
"""
# do the same, but find all trips that both start and end on broadway
# Input:
# Input:
filter(trips, grepl('Broadway', start_station_name) & grepl('Broadway', end_station_name))
"""
Output: 
tripduration starttime           stoptime            start_station_id
          <dbl> <dttm>              <dttm>                         <dbl>
 1          884 2014-02-01 00:41:29 2014-02-01 00:56:13              500
 2          282 2014-02-01 01:15:57 2014-02-01 01:20:39              499
 3          601 2014-02-01 02:08:31 2014-02-01 02:18:32              486
 4         1467 2014-02-01 03:17:49 2014-02-01 03:42:16              304
 5          175 2014-02-01 03:18:36 2014-02-01 03:21:31              497
 6          108 2014-02-01 04:36:45 2014-02-01 04:38:33              500
 7          171 2014-02-01 06:39:54 2014-02-01 06:42:45              468
 8          849 2014-02-01 06:44:46 2014-02-01 06:58:55              335
 9          159 2014-02-01 09:01:23 2014-02-01 09:04:02              285
10          292 2014-02-01 09:04:52 2014-02-01 09:09:44              499
# ℹ 2,766 more rows
# ℹ 12 more variables: start_station_name <chr>, start_station_latitude <dbl>,
#   start_station_longitude <dbl>, end_station_id <dbl>,
#   end_station_name <chr>, end_station_latitude <dbl>,
#   end_station_longitude <dbl>, bikeid <dbl>, usertype <chr>,
#   birth_year <chr>, gender <fct>, n_birth_year <dbl>
# ℹ Use `print(n = ...)` to see more rows
"""
# find all unique station names
# Input: 
distinct(trips, start_station_name)   

"""
Output: 
# A tibble: 329 × 1
   start_station_name     
   <chr>                  
 1 Washington Square E    
 2 Broadway & E 14 St     
 3 Perry St & Bleecker St 
 4 E 11 St & Broadway     
 5 Allen St & Rivington St
 6 Warren St & Church St  
 7 E 19 St & 3 Ave        
 8 Emerson Pl & Myrtle Ave
 9 Mercer St & Bleecker St
10 E 39 St & 2 Ave        
# ℹ 319 more rows
# ℹ Use `print(n = ...)` to see more rows
"""
# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
# Input: 
summarize(group_by(trips, gender), count = n(), 
avg_trip_time =  mean(tripduration), sd_trip_time = sd(tripduration))
"""
Output:
# A tibble: 3 × 4
  gender   count avg_trip_time sd_trip_time
  <fct>    <int>         <dbl>        <dbl>
1 Unknown   6731         1741.        5566.
2 Male    176526          814.        5021.
3 Female   41479          991.        7115.
"""
# find the 10 most frequent station-to-station trips
# Input: 
trips %>% 
group_by(start_station_name, end_station_name) %>% 
summarize(count = n()) %>% 
arrange(desc(count)) %>% 
head(n=10)
"""
Output:
 A tibble: 10 × 3
# Groups:   start_station_name [10]
   start_station_name       end_station_name       count
   <chr>                    <chr>                  <int>
 1 E 43 St & Vanderbilt Ave W 41 St & 8 Ave          156
 2 Pershing Square N        W 33 St & 7 Ave          124
 3 Norfolk St & Broome St   Henry St & Grand St      122
 4 E 7 St & Avenue A        Lafayette St & E 8 St    121
 5 Henry St & Grand St      Norfolk St & Broome St   118
 6 W 17 St & 8 Ave          8 Ave & W 31 St          118
 7 Central Park S & 6 Ave   Central Park S & 6 Ave   115
 8 Lafayette St & E 8 St    E 6 St & Avenue B        115
 9 E 10 St & Avenue A       Lafayette St & E 8 St    108
10 Canal St & Rutgers St    Henry St & Grand St      103
"""
# find the top 3 end stations for trips starting from each start station
trips %>% 
group_by(start_station_name, end_station_name) %>%
summarize(count = n()) %>% 
arrange(start_station_name, count) %>%
mutate(rank = row_number()) %>% 
filter(rank <= 3)
"""
Output: 
# A tibble: 987 × 4
# Groups:   start_station_name [329]
   start_station_name end_station_name        count  rank
   <chr>              <chr>                   <int> <int>
 1 1 Ave & E 15 St    8 Ave & W 52 St             1     1
 2 1 Ave & E 15 St    9 Ave & W 22 St             1     2
 3 1 Ave & E 15 St    Ashland Pl & Hanson Pl      1     3
 4 1 Ave & E 18 St    11 Ave & W 27 St            1     1
 5 1 Ave & E 18 St    8 Ave & W 52 St             1     2
 6 1 Ave & E 18 St    Allen St & Hester St        1     3
 7 1 Ave & E 30 St    8 Ave & W 52 St             1     1
 8 1 Ave & E 30 St    9 Ave & W 45 St             1     2
 9 1 Ave & E 30 St    Allen St & Rivington St     1     3
10 1 Ave & E 44 St    1 Ave & E 30 St             1     1
# ℹ 977 more rows
# ℹ Use `print(n = ...)` to see more rows
"""
# find the top 3 most common station-to-station trips by gender
# Input: 
trips %>% 
group_by(start_station_name, end_station_name, gender) %>%
summarize(count = n()) %>%
arrange(gender, desc(count)) %>% 
group_by(gender) %>% 
mutate(rank = row_number()) %>% 
filter(rank <= 3)

"""
Ouput:
# A tibble: 9 × 5
# Groups:   gender [3]
  start_station_name                end_station_name          gender count  rank
  <chr>                             <chr>                     <fct>  <int> <int>
1 Central Park S & 6 Ave            Central Park S & 6 Ave    Unkno…    61     1
2 Grand Army Plaza & Central Park S Grand Army Plaza & Centr… Unkno…    53     2
3 Broadway & W 58 St                Broadway & W 58 St        Unkno…    31     3
4 E 43 St & Vanderbilt Ave          W 41 St & 8 Ave           Male     153     1
5 Pershing Square N                 W 33 St & 7 Ave           Male     121     2
6 W 17 St & 8 Ave                   8 Ave & W 31 St           Male     108     3
7 E 7 St & Avenue A                 Lafayette St & E 8 St     Female    40     1
8 Lafayette St & E 8 St             E 7 St & Avenue A         Female    36     2
9 Norfolk St & Broome St            Henry St & Grand St       Female    36     3
"""

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
# Input: 
trips %>% 
mutate(date = floor_date(starttime, unit = "day")) %>%
group_by(date) %>%
summarize(count = n()) %>% 
arrange(count) %>%
tail(n=1)  

"""
Output:
# A tibble: 1 × 2
  date                count
  <dttm>              <int>
1 2014-02-02 00:00:00 13816
"""

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
# Input:
trips %>% mutate(hours = floor_date(starttime, unit = "hour")) %>%
 group_by(hours) %>% 
 summarize(avg_no_trips_per_hour = (n()/28))

"""
Output:
# A tibble: 671 × 2
   hours               avg_no_trips_per_hour
   <dttm>                              <dbl>
 1 2014-02-01 00:00:00                  7.67
 2 2014-02-01 01:00:00                  4.75
 3 2014-02-01 02:00:00                  3.88
 4 2014-02-01 03:00:00                  2.29
 5 2014-02-01 04:00:00                  1.62
 6 2014-02-01 05:00:00                  1.38
 7 2014-02-01 06:00:00                  2.67
 8 2014-02-01 07:00:00                  5.46
 9 2014-02-01 08:00:00                 13.0 
10 2014-02-01 09:00:00                 23.1 
# ℹ 661 more rows
# ℹ Use `print(n = ...)` to see more rows
"""