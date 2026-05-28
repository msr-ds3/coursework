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
#trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))


########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
nrow(trips) 
# ANSWER: 224,736

# find the earliest and latest birth years (see help for max and min to deal with NAs)
trips %>% 
    select(birth_year) %>%
	filter(birth_year != "\\N") %>%
	mutate(birth_year = as.integer(birth_year)) %>%
	min()
# ANSWER: 1899 

trips %>% 
    select(birth_year) %>%
	filter(birth_year != "\\N") %>%
	mutate(birth_year = as.integer(birth_year)) %>%
	max() 
# ANSWER: 1997

# use filter and grepl to find all trips that either start or end on broadway
trips %>%
    select(start_station_name, end_station_name) %>%
    filter(grepl('.*Broadway.*', start_station_name) | grepl('.*Broadway.*', end_station_name))
# ANSWER: output (41,469 results)

# do the same, but find all trips that both start and end on broadway
trips %>%
    select(start_station_name, end_station_name) %>%
    filter(grepl('.*Broadway.*', start_station_name) & grepl('.*Broadway.*', end_station_name))
# ANSWER: output (2,776 results)

# find all unique station names
trips %>% distinct(start_station_name)
# ANSWER: output (329 results)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender
# do this all at once, by using summarize() with multiple arguments
trips %>%
    group_by(gender) %>%
    summarize(count = n(), mean=mean(tripduration), sd=sd(tripduration))
# ANSWER: 
# 1 Unknown   6731 1741. 5566.
# 2 Male    176526  814. 5021.
# 3 Female   41479  991. 7115.

# find the 10 most frequent station-to-station trips
# my alt solution
# trips %>%
#     select(start_station_name, end_station_name) %>%
#     mutate(station_to_station = str_c(start_station_name, end_station_name, sep = "   ")) %>%
#     group_by(station_to_station) %>%
#     summarize(count = n()) %>%
#     arrange(desc(count))

trips %>%
    group_by(start_station_name, end_station_name) %>%
    summarize(count = n()) %>%
    arrange(desc(count)) %>%
    head(10)

# ANSWER: 
#    start_station_name       end_station_name       count
#    <chr>                    <chr>                  <int>
#  1 E 43 St & Vanderbilt Ave W 41 St & 8 Ave          156
#  2 Pershing Square N        W 33 St & 7 Ave          124
#  3 Norfolk St & Broome St   Henry St & Grand St      122
#  4 E 7 St & Avenue A        Lafayette St & E 8 St    121
#  5 Henry St & Grand St      Norfolk St & Broome St   118
#  6 W 17 St & 8 Ave          8 Ave & W 31 St          118
#  7 Central Park S & 6 Ave   Central Park S & 6 Ave   115
#  8 Lafayette St & E 8 St    E 6 St & Avenue B        115
#  9 E 10 St & Avenue A       Lafayette St & E 8 St    108
# 10 Canal St & Rutgers St    Henry St & Grand St      103

# find the top 3 end stations for trips starting from each start station
trips %>%
    group_by(start_station_name, end_station_name) %>%
    summarize(num = n()) %>%
    arrange(start_station_name, desc(num)) %>%
    mutate(rank = row_number()) %>%
    filter(rank <= 3)
# ANSWER: output (987 results)


# find the top 3 most common station-to-station trips by gender
trips %>%
    group_by(start_station_name, end_station_name, gender) %>%
    summarize(num = n()) %>%
    arrange(gender, desc(num)) %>%
    group_by(gender) %>%
    mutate(rank = row_number()) %>%
    filter(rank <= 3)

# ANSWER: 
#   start_station_name                end_station_name          gender   num  rank
#   <chr>                             <chr>                     <fct>  <int> <int>
# 1 Central Park S & 6 Ave            Central Park S & 6 Ave    Unkno…    61     1
# 2 Grand Army Plaza & Central Park S Grand Army Plaza & Centr… Unkno…    53     2
# 3 Broadway & W 58 St                Broadway & W 58 St        Unkno…    31     3
# 4 E 43 St & Vanderbilt Ave          W 41 St & 8 Ave           Male     153     1
# 5 Pershing Square N                 W 33 St & 7 Ave           Male     121     2
# 6 W 17 St & 8 Ave                   8 Ave & W 31 St           Male     108     3
# 7 E 7 St & Avenue A                 Lafayette St & E 8 St     Female    40     1
# 8 Lafayette St & E 8 St             E 7 St & Avenue A         Female    36     2
# 9 Norfolk St & Broome St            Henry St & Grand St       Female    36     3

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips %>%
    select(starttime) %>%
    mutate(date = floor_date(starttime, unit = "day")) %>%
    group_by(date) %>%
    summarize(count = n()) %>%
    arrange(desc(count))

# ANSWER: Feb 02

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
trips %>%
    select(starttime) %>%
    mutate(hour = hour(starttime)) %>%
    group_by(hour) %>%
    summarize(count = n(), days_of_month = n_distinct(floor_date(starttime, unit="day")), average = count/days_of_month) %>%
    arrange(desc(average))

# ANSWER: 4 to 6 (16 to 18)