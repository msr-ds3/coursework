library(lubridate)
library(tidyverse)

setwd("~/Github/coursework/week1")
# read one month of data
trips <- read_csv('201402-citibike-tripdata.csv')

# replace spaces in column names with underscores



names(trips) <- gsub(' ', '_', names(trips))

# convert dates strings to dates
# trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))

arrange(trips, starttime)
arrange(trips, birth_year)
nrow(trips)

min(trips$birth_year, na.rm = TRUE)



trips$birth_year <- gsub("\\\\N",NA,trips$birth_year)

df <- trips$start_station_name

broadway_one <- trips %>%
  filter(grepl('Broadway',start_station_name)|
           grepl('Broadway',end_station_name)) 
start_station <- trips

summarize(group_by(trips, start_station_name)) 


summarize(group_by(trips, gender),
         count = n(),
         mean_trip_time = mean(tripduration),
         sd_trip_time = sd(tripduration))


summarize(group_by( trips, start_station_name , end_station_name),
  count = n()) %>% arrange(desc(count)) %>% head(10)

summarize(group_by( trips, start_station_name, end_station_name),
          count = n()) %>%  
                arrange(start_station_name,desc(count)) %>% 
                  slice_head(n = 3)

summarize(group_by( trips, gender),
  arrange(gender, start_station_name, end_station_name,desc(count)) %>%
  slice_head(n = 3) 
     
       
  top_3_gender = trips %>% 
    group_by(gender,start_station_name,end_station_name) %>% 
    summarize(count = n()) %>% 
    group_by(gender) %>% 
    arrange(gender,desc(count)) %>% 
    slice_head(n=3)
  
    trips %>% 
    group_by(gender,start_station_name,end_station_name) %>% 
    summarize(count = n()) %>% 
    group_by(gender) %>% 
    arrange(gender,desc(count)) %>% 
    slice_head(n=10)
    
    dates<- trips%>%
      group_by(starttime)
   
    dates1<-as.Date(dates$starttime, "%m/%d/%y")
                  
  

 


