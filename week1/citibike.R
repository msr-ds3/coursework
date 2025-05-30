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
summarize(trips, count=n())
# A tibble: 1 × 1
   count
   <int>
224736

# find the earliest and latest birth years (see help for max and min to deal with NAs)
> min(trips$birth_year, na.rm=TRUE)
[1] 1899
> max(trips$birth_year, na.rm=TRUE)
[1] 1997

# use filter and grepl to find all trips that either start or end on broadway
filter(trips, grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name))
# A tibble: 41,469 × 17
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
# ℹ 13 more variables: start_station_name <chr>, start_station_latitude <dbl>,
#   start_station_longitude <dbl>, end_station_id <dbl>,
#   end_station_name <chr>, end_station_latitude <dbl>,
#   end_station_longitude <dbl>, bikeid <dbl>, usertype <chr>,
#   birth_year <int>, gender <fct>, trip_start_date <date>,
#   trip_end_date <date>
# ℹ Use `print(n = ...)` to see more rows

# do the same, but find all trips that both start and end on broadway
filter(trips, grepl('Broadway', start_station_name) & grepl('Broadway', end_station_name))
# A tibble: 2,776 × 17
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
# ℹ 13 more variables: start_station_name <chr>, start_station_latitude <dbl>,
#   start_station_longitude <dbl>, end_station_id <dbl>,
#   end_station_name <chr>, end_station_latitude <dbl>,
#   end_station_longitude <dbl>, bikeid <dbl>, usertype <chr>,
#   birth_year <int>, gender <fct>, trip_start_date <date>,
#   trip_end_date <date>
# ℹ Use `print(n = ...)` to see more rows


# find all unique station names
trips_name <- group_by(trips, start_station_name)
summarize(trips_name)
# A tibble: 329 × 1
   start_station_name
   <chr>
 1 1 Ave & E 15 St
 2 1 Ave & E 18 St   
 3 1 Ave & E 30 St
 4 1 Ave & E 44 St
 5 10 Ave & W 28 St
 6 11 Ave & W 27 St
 7 11 Ave & W 41 St
 8 12 Ave & W 40 St
 9 2 Ave & E 31 St   
10 2 Ave & E 58 St
ℹ 319 more rows
ℹ Use `print(n = ...)` to see more rows

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments

trips %>% group_by(start_station_name, end_station_name, gender) %>%  summarize (count = n()) %>%  group_by(gender) %>% arrange(desc(count)) %>% slice(1:3)
# A tibble: 3 × 4
  gender   count mean_trips_gender sd_gender_trips
  <fct>    <int>             <dbl>           <dbl>
1 Unknown   6731             1741.           5566.
2 Male    176526              814.           5021.
3 Female   41479              991.           7115.


# find the 10 most frequent station-to-station trips
trips_most_frequent <- group_by (trips, start_station_name, end_station_name)
trips_frequent <- summarize(trips_most_frequent, count=n())
arrange(trips_frequent, desc(count))
A tibble: 43,000 × 3
Groups:   start_station_name [329]
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
> x <- trips_rank %>% arrange(start_station_name, desc(count)) %>% mutate(rank = row_number())
filter(x, rank <= 3)
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
trips %>% group_by(start_station_name, end_station_name, gender) %>%  summar$
`summarise()` has grouped output by 'start_station_name', 'end_station_name'. You can override using the `.groups`
argument.
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
trips %>% mutate (date = as.Date (starttime)) %>% count (date, name = "count") %>% arrange(desc(count)) %>% slice(1)
# A tibble: 1 × 2
  date       count
  <date>     <int>
1 2014-02-02 13816

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?

trips %>% mutate ( date = as_date(starttime), hours = hour(starttime)) %>% count (date, hours) %>% group_by(hours) %>% summarise (avg_trips = mean(n)) %>% arrange(desc(avg_trips)) 
# A tibble: 24 × 2
   hours avg_trips
   <int>     <dbl>
 1    17      800.
 2    18      716.
 3    16      611.
 4     8      591.
 5    15      531.
 6    14      514.
 7     9      510.
 8    19      502.
 9    13      488.
10    12      444.
# ℹ 14 more rows
# ℹ Use `print(n = ...)` to see more rows