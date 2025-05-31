library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('./week1/201402-citibike-tripdata.csv')

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
> summarize(trips, count=n())
# A tibble: 1 × 1
   count
   <int>
1 224736
# find the earliest and latest birth years (see help for max and min to deal with NAs)
> trips <- mutate(trips, birth_year = as.integer(birth_year))
Warning message:
There was 1 warning in `mutate()`.
ℹ In argument: `birth_year = as.integer(birth_year)`.
Caused by warning:
! NAs introduced by coercion
> min(trips$birth_year,na.rm=TRUE)
[1] 1899
> max(trips$birth_year,na.rm=TRUE)
[1] 1997
# use filter and grepl to find all trips that either start or end on broadway
> filter(trips,grepl("Broadway", start_station_name) | grepl("Broadway", end_s$
+ )
# A tibble: 41,469 × 15
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
# ℹ 11 more variables: start_station_name <chr>, start_station_latitude <dbl>,
#   start_station_longitude <dbl>, end_station_id <dbl>,
#   end_station_name <chr>, end_station_latitude <dbl>,
#   end_station_longitude <dbl>, bikeid <dbl>, usertype <chr>,
#   birth_year <int>, gender <fct>
# ℹ Use `print(n = ...)` to see more rows
> nrow(filter(trips,grepl("Broadway", start_station_name) | grepl("Broadway", $
[1] 41469
# do the same, but find all trips that both start and end on broadway
> filter(trips,grepl("Broadway", start_station_name) & grepl("Broadway", end_s$
# A tibble: 2,776 × 15
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
# ℹ 11 more variables: start_station_name <chr>, start_station_latitude <dbl>,
#   start_station_longitude <dbl>, end_station_id <dbl>,
#   end_station_name <chr>, end_station_latitude <dbl>,
#   end_station_longitude <dbl>, bikeid <dbl>, usertype <chr>,
#   birth_year <int>, gender <fct>
# ℹ Use `print(n = ...)` to see more rows

# find all unique station names
> trips_by_station <- group_by(trips, start_station_name)
> summarize(trips_by_station, count=n())
# A tibble: 329 × 2
   start_station_name count
   <chr>              <int>
 1 1 Ave & E 15 St     1319
 2 1 Ave & E 18 St     1093
 3 1 Ave & E 30 St      961
 4 1 Ave & E 44 St      444
 5 10 Ave & W 28 St     675
 6 11 Ave & W 27 St     574
 7 11 Ave & W 41 St     868
 8 12 Ave & W 40 St     602
 9 2 Ave & E 31 St     1371
10 2 Ave & E 58 St      542
# ℹ 319 more rows
# ℹ Use `print(n = ...)` to see more rows

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
> trips_by_gender <- group_by(trips, gender) 
> summarize(trips_by_gender, count = n(), mean_trip_time = mean(tripduration),sd_trip_time = sd(tripduration))
# A tibble: 3 × 4
  gender   count mean_trip_time sd_trip_time
  <fct>    <int>          <dbl>        <dbl>
1 Unknown   6731          1741.        5566.
2 Male    176526           814.        5021.
3 Female   41479           991.        7115.

# find the 10 most frequent station-to-station trips
> trips_by_trip <- group_by(trips, start_station_name, end_station_name)
> v<-summarize(trips_by_trip, count = n())                     
`summarise()` has grouped output by 'start_station_name'. You can override using the `.groups` argument.
> arrange(v)
# A tibble: 43,000 × 3
# Groups:   start_station_name [329]
   start_station_name end_station_name count
   <chr>              <chr>            <int>
 1 1 Ave & E 15 St    1 Ave & E 15 St     23
 2 1 Ave & E 15 St    1 Ave & E 18 St     15
 3 1 Ave & E 15 St    1 Ave & E 30 St     49
 4 1 Ave & E 15 St    1 Ave & E 44 St      7
 5 1 Ave & E 15 St    11 Ave & W 27 St     2
 6 1 Ave & E 15 St    2 Ave & E 31 St     18
 7 1 Ave & E 15 St    2 Ave & E 58 St      2
 8 1 Ave & E 15 St    5 Ave & E 29 St      5
 9 1 Ave & E 15 St    6 Ave & W 33 St      3
10 1 Ave & E 15 St    8 Ave & W 31 St      7
# ℹ 42,990 more rows
# ℹ Use `print(n = ...)` to see more rows
> arrange(v,desc(count))
# A tibble: 43,000 × 3
# Groups:   start_station_name [329]
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
# ℹ 42,990 more rows
# ℹ Use `print(n = ...)` to see more rows

# find the top 3 end stations for trips starting from each start station
> x<- group_by(trips, start_station_name, end_station_name)
> v<- summarize(x, count=n())
# ℹ Use `print(n = ...)` to see more rows
> st<-v %>% group_by(start_station_name) %>% arrange(start_station_name,desc(count)) %>% mutate(rank=row_number())
> filter(st, rank<=3)
# A tibble: 987 × 4
# Groups:   start_station_name [329]
   start_station_name end_station_name    count  rank
   <chr>              <chr>               <int> <int>
 1 1 Ave & E 15 St    E 20 St & FDR Drive    57     1
 2 1 Ave & E 15 St    E 17 St & Broadway     52     2
 3 1 Ave & E 15 St    1 Ave & E 30 St        49     3
 4 1 Ave & E 18 St    E 15 St & 3 Ave        48     1
 5 1 Ave & E 18 St    E 17 St & Broadway     44     2
 6 1 Ave & E 18 St    W 21 St & 6 Ave        43     3
 7 1 Ave & E 30 St    W 33 St & 7 Ave        71     1
 8 1 Ave & E 30 St    Pershing Square N      55     2
 9 1 Ave & E 30 St    W 31 St & 7 Ave        46     3
10 1 Ave & E 44 St    W 33 St & 7 Ave        39     1
# ℹ 977 more rows
# ℹ Use `print(n = ...)` to see more rows

# find the top 3 most common station-to-station trips by gender
> x<- group_by(trips, start_station_name, end_station_name, gender)
> v<- summarize (x, count = n())
`summarise()` has grouped output by 'start_station_name', 'end_station_name'. You can override using the
`.groups` argument.
> v
# A tibble: 61,740 × 4
# Groups:   start_station_name, end_station_name [43,000]
   start_station_name end_station_name gender  count
   <chr>              <chr>            <fct>   <int>
 1 1 Ave & E 15 St    1 Ave & E 15 St  Unknown     4
 2 1 Ave & E 15 St    1 Ave & E 15 St  Male       14
 3 1 Ave & E 15 St    1 Ave & E 15 St  Female      5
 4 1 Ave & E 15 St    1 Ave & E 18 St  Male       12
 5 1 Ave & E 15 St    1 Ave & E 18 St  Female      3
 6 1 Ave & E 15 St    1 Ave & E 30 St  Male       40
 7 1 Ave & E 15 St    1 Ave & E 30 St  Female      9
 8 1 Ave & E 15 St    1 Ave & E 44 St  Unknown     1
 9 1 Ave & E 15 St    1 Ave & E 44 St  Male        6
10 1 Ave & E 15 St    11 Ave & W 27 St Male        2
# ℹ 61,730 more rows
# ℹ Use `print(n = ...)` to see more rows
> v<- group_by(v, gender)
> v
# A tibble: 61,740 × 4
# Groups:   gender [3]
   start_station_name end_station_name gender  count
   <chr>              <chr>            <fct>   <int>
 1 1 Ave & E 15 St    1 Ave & E 15 St  Unknown     4
 2 1 Ave & E 15 St    1 Ave & E 15 St  Male       14
 3 1 Ave & E 15 St    1 Ave & E 15 St  Female      5
 4 1 Ave & E 15 St    1 Ave & E 18 St  Male       12
 5 1 Ave & E 15 St    1 Ave & E 18 St  Female      3
 6 1 Ave & E 15 St    1 Ave & E 30 St  Male       40
 7 1 Ave & E 15 St    1 Ave & E 30 St  Female      9
 8 1 Ave & E 15 St    1 Ave & E 44 St  Unknown     1
 9 1 Ave & E 15 St    1 Ave & E 44 St  Male        6
10 1 Ave & E 15 St    11 Ave & W 27 St Male        2
# ℹ 61,730 more rows
# ℹ Use `print(n = ...)` to see more rows
> st <- v %>% arrange(desc(count)) %>% slice(1:3)
> st
# A tibble: 9 × 4
# Groups:   gender [3]
  start_station_name                end_station_name                gender count
  <chr>                             <chr>                           <fct>  <int>
1 Central Park S & 6 Ave            Central Park S & 6 Ave          Unkno…    61
2 Grand Army Plaza & Central Park S Grand Army Plaza & Central Par… Unkno…    53
3 Broadway & W 58 St                Broadway & W 58 St              Unkno…    31
4 E 43 St & Vanderbilt Ave          W 41 St & 8 Ave                 Male     153
5 Pershing Square N                 W 33 St & 7 Ave                 Male     121
6 W 17 St & 8 Ave                   8 Ave & W 31 St                 Male     108
7 E 7 St & Avenue A                 Lafayette St & E 8 St           Female    40
8 Lafayette St & E 8 St             E 7 St & Avenue A               Female    36
9 Norfolk St & Broome St            Henry St & Grand St             Female    36

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
> trips1 <- mutate(trips, date = as.Date(starttime))
> view(trips1)
> x <- group_by(trips1, date)
> v <- summarize(x, count = n())
> v %>% arrange(desc(count)) %>% mutate(rank = row_number()) %>% filter(rank==$
# A tibble: 1 × 3
  date       count  rank
  <date>     <int> <int>
1 2014-02-02 13816     1

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
> trips11 <- mutate(trips, time = hour(starttime))
> view(trips11)
> x <- group_by(trips11, time)
> v <- summarize(x, count=n())
> v
# A tibble: 24 × 2
    time count
   <int> <int>
 1     0  2121
 2     1  1181
 3     2   793
 4     3   450
 5     4   462
 6     5  1202
 7     6  4204
 8     7  8705
 9     8 16545
10     9 14282
# ℹ 14 more rows
# ℹ Use `print(n = ...)` to see more rows
> d <- mutate(v,mean =count / 28)
> d
# A tibble: 24 × 3
    time count  mean
   <int> <int> <dbl>
 1     0  2121  75.8
 2     1  1181  42.2
 3     2   793  28.3
 4     3   450  16.1
 5     4   462  16.5
 6     5  1202  42.9
 7     6  4204 150.
 8     7  8705 311.
 9     8 16545 591.
10     9 14282 510.
# ℹ 14 more rows
# ℹ Use `print(n = ...)` to see more rows
> d %>% arrange(desc(mean)) %>% mutate(rank = row_number()) %>% filter(rank ==$
# A tibble: 1 × 4
   time count  mean  rank
  <int> <int> <dbl> <int>
1    17 22409  800.     1