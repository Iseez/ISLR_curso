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
