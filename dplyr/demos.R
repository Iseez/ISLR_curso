suppressMessages(library(dplyr))
library(nycflights13)
flights = flights %>% tbl_df()
flights %>% names()

#Demo1
flights %>% mutate(air_time = ifelse(is.na(air_time), 0, air_time)) %>%
 filter(dest=="LAX",carrier == c("AA","UA","DL","US")) %>%
 group_by(carrier) %>% summarise(n(),mean(air_time))

#Demo2
library(lubridate)
flights %>% mutate(air_time = ifelse(is.na(air_time), 0, air_time)) %>%
  mutate(date = paste(month,day,year,sep="/") %>% mdy()) %>%
  filter(carrier == c("AA","UA","DL","US")) %>% arrange(date,origin) %>%
  group_by(carrier) %>% summarise(n(),mean(dep_delay))
#Ex1
  flights %>% filter(tailnum != "NA") %>%
    group_by(origin,tailnum) %>%  summarize(sum = n()) %>%
    arrange(origin,desc(sum))
#Ex2
flights %>% mutate(air_time = ifelse(is.na(air_time), 0, air_time)) %>%
  group_by(origin) %>% select(origin,flight,air_time)%>% summarise(n(),min())

flights %>% select(origin,flight,air_time) %>%
  group_by(origin) %>% filter(air_time != "NA") %>%
  arrange(air_time) %>% slice(1)

flights %>% select(origin,flight,distance) %>%
  group_by(origin) %>% filter(distance != "NA") %>%
  arrange(distance) %>% slice(1)

flights %>% mutate(date = paste(month,day,year,sep="/") %>% mdy()) %>%
  filter(dep_delay != "NA") %>% group_by(date) %>%
  summarize(mean_delay = mean(dep_delay)) %>% arrange(mean_delay) %>% slice(1)

flights %>% mutate(date = paste(month,day,year,sep="/") %>% mdy()) %>%
  filter(arr_delay != "NA") %>% group_by(date) %>%
  summarize(mean_delay = mean(arr_delay)) %>% arrange(mean_delay) %>% slice(1)
