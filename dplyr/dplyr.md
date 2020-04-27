# Dplyr Scripts

---

## Pipes
```r
data.frame(a=1:3,b=3:1) %>% lm(a~b,data=.)
data.frame(a=1:3,b=3:1) %>% .[[1]]
data.frame(a=1:3,b=3:1) %>% .[[length(.)]]
```
## Tibles
```r
library(tibble)
class(iris)
tbl_iris = as_tibble(iris)
class(tbl_iris)
tbl_iris
tbl_iris[1,]
tbl_iris[,"Species"]
```
```r
data_frame(x = 1:3, y=c("A","B","C"))
tbl_iris[,"Name"]                       #Error
tbl_iris$Name                           #Warning -> NULL
tbl_iris[160,]
```
## Dplyr
```r
suppressMessages(library(dplyr))
library(nycflights13)
flights = flights %>% tbl_df()
str(flights)
flights
class(flights)
```
#### Verbs
```r
flights %>% filter(month == 3)
flights %>% filter(month == 3, day <= 7)
flights %>% filter(dest == "LAX" | dest == "RDU", month==3)
flights %>% slice(1:10)
flights %>% slice((n()-5):n())
flights %>% select(year, month, day)
lights %>% select(-year, -month, -day)
flights %>% select(year:day)
flights %>% select(-(year:day))
flights %>% select(contains("dep"), contains("arr")) #Está en el str
flights %>% select(starts_with("dep"), starts_with("arr")) #El str empieza con
names(flights) #Pasa a vector
flights %>% pull("year") %>% head()
flights %>% pull(1) %>% head()
flights %>% pull(-1) %>% head()
flights %>% rename(tail_number = tailnum) #Cambiar nombres de columnas
flights %>% select(tail_number = tailnum, -tailnum)
flights %>% select(-tailnum, tail_number = tailnum)
flights %>% filter(month==3,day==2) %>% arrange(origin, dest) #Sort by origin, then by dest
#Desc() for descendent order
flights %>% filter(month==3,day==2) %>% arrange(desc(origin), dest) %>% select(origin, dest, tailnum)
suppressMessages(library(lubridate))    #Lubridate for dates
flights %>% select(1:3) %>% mutate(date = paste(month,day,year,sep="/") %>% mdy())
#Create new tible
flights %>% select(1:3) %>% transmute(date = paste(month,day,year,sep="/") %>% mdy())
#Different rows
flights %>% select(origin, dest) %>% distinct() %>% arrange(origin,dest)
#Random sample
flights %>% sample_n(10)
flights %>% sample_frac(0.001)

flights %>% mutate(date = paste(month,day,year,sep="/") %>% mdy()) %>%
summarize(n(), min(date), max(date))
#Group
flights %>% group_by(origin)
flights %>% group_by(origin) %>%
mutate(date = paste(month,day,year,sep="/") %>% mdy()) %>%
summarize(n(), min(date), max(date))
```
## Demo 1
```r
flights %>% mutate(air_time = ifelse(is.na(air_time), 0, air_time))   %>% filter(dest=="LAX",carrier == c("AA","UA","DL","US")) %>%  
 group_by(carrier) %>% summarise(n(),mean(air_time))
```
---
## Ejercicios
1. Which plane (check the tail number) flew out of each New York airport the most?
> ```r
flights %>% filter(tailnum != "NA") %>%
  group_by(origin,tailnum) %>%  summarize(sum = n()) %>%
  arrange(origin,desc(sum))
> ```
> El resultado se ve algo así:
> | origin | tailnum | sum |
|--------|---------|-----|
| EWR    | N15980  | 314 |
| EWR    | N19554  | 305 |
| EWR    | N15572  | 304 |
| EWR    | N14573  | 292 |
| EWR    | N18557  | 292 |

2. What was the shortest flight out of each airport in terms of distance? In terms of duration?
   1. Por tiempo:
      >```r
      flights %>% select(origin,flight,air_time) %>%
      group_by(origin) %>% filter(air_time != "NA") %>%
      arrange(air_time) %>% slice(1)
      >```
      > E output es el siguiente:
      > | origin | flight | air_time |
      |--------|--------|----------|
      | EWR    | 4368   | 20       |
      | JFK    | 3650   | 21       |
      >| LGA    | 2132   | 21       |

   2. Por distancia:
   >```r
   flights %>% select(origin,flight,distance) %>%
     group_by(origin) %>% filter(distance != "NA") %>%
     arrange(distance) %>% slice(1)
   >```
   >| origin | flight | distance |
   >|--------|--------|----------|
   >| EWR    | 1632   | 17       |
   >| JFK    | 4088   | 94       |
   >| LGA    | 1467   | 96       |
3. Which date should you fly on if you want to have the lowest possible average departure delay? What about arrival delay?
   1. Departure delay:
   >```r
   flights %>% mutate(date = paste(month,day,year,sep="/") %>% mdy()) %>%
     filter(dep_delay != "NA") %>% group_by(date) %>%
     summarize(mean_delay = mean(dep_delay)) %>% arrange(mean_delay) %>% slice(1)
   >```
   > Obteniendo que el día con menor departure delay fue:
   > | date       | mean_delay |
   >|------------|------------|
   >| 2013-09-24 | -1.329832  |

   2. Arrival delay:
   >```r
   flights %>% mutate(date = paste(month,day,year,sep="/") %>% mdy()) %>%
     filter(arr_delay != "NA") %>% group_by(date) %>%
     summarize(mean_delay = mean(arr_delay)) %>% arrange(mean_delay) %>% slice(1)
   >```
   >| date       | mean_delay |
   >|------------|------------|
   >| 2013-09-07 | -20.34985  |
