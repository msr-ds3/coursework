
# count the number of trips (= rows in the data frame)
summarize (trips, n())
Source: local data frame [1 x 1]

      n()
    (int)
1 5370361

# find the earliest and latest birth years (see help for max and min to deal with NAs)
 summarise(trips, max_year=max(birth_year, na.rm = TRUE))
 summarise(trips, min_year=min(birth_year, na.rm = TRUE))


# use filter and grepl to find all trips that either start or end on broadway
filter(trips, (grepl('Broadway', start_station_name)) | grepl('Broadway', end_station_name))


# do the same, but find all trips that both start and end on broadway
filter(trips, (grepl('Broadway', start_station_name)) & grepl('Broadway', end_station_name))

# use filter, select, and distinct to find all unique station names
trips_start <- select (trips, start_station_name)
trips_end <- select (trips, end_station_name)
trips_end <- rename(trips_end, stations = end_station_name)
trips_start <- rename(trips_start, stations = start_station_name)
rbind(trips_start, trips_start) %>% distinct()


# count trips by gender
trips %>% count(gender)
trips %>% group_by(gender) %>% summarise(n())

# find the 10 most frequent station-to-station trips
trips %>% group_by(start_station_id, end_station_id) %>% summarize(count = n()) %>% ungroup() %>% arrange(desc(count)) %>% head(n=10) %>% View()


#count all trips that start and end on broadway
trips %>% filter(grepl("Broadway", start_station_name) & grepl("Broadway", end_station_name)) %>% summarize(count = n())










