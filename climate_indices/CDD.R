
# Big Data
##CDD: maximum number of consecutive dry days (Rday < 1mm)

CDD <- function(x, ID, startyear = 1977, endyear = 2016, output= "standart"){
  BW_C <- x
  library(readr)
  library(dplyr)
  library(lubridate)
  library(zoo)
#1. filter Dataset by the station-id: 
BW_id <- BW_C %>% 
  filter(id==ID) %>% 
  mutate(year = year(date)) %>% 
#2. count NAs for every year, if more than 60, exclude the years data
  mutate(na.count = is.na(RSK)) %>% ## add column with T/F where values are NAs
  group_by(year) %>% ## group by year to calculate sum of T, means the amount of NAs per year
  mutate(na.count = sum(na.count)) %>% 
  filter(na.count <= 60) %>% 
  ungroup()


# 3. calculate CDD
## All the precipitation-values (RSK) smaller than 1 mm will be encoded with dryDay = T.
## to figure out wich consecutive period of time with dryDays was the longest, all the False values were dropped.
## The tesfun-function than calculates the cumulative sum of all consecutive dryDays. 
## Wheneever there is a break in the timeseries of dry days, the encoding-number rises by one.
testfun <- function(x){
  return(cumsum(c(1, diff(x) != 1)))
}

BW_id1 <- BW_id %>% 
  mutate(dryDay = ifelse(RSK < 1, T, F)) %>% 
  filter(dryDay == T) %>% 
  mutate(codierung = testfun(date)) %>% 
  group_by(codierung)

## whith the grouping of the encoding the longest CDD period for every year is calculated:
BW_count <- BW_id1 %>% 
  group_by(year) %>% 
  count(codierung) %>% 
  filter(n==max(n))

## to get start and end date of each CDD period, the result from above (BW_Count) is joined with the BW_id1, where the date-information is stored.
BW_id2 <- BW_count %>% 
  left_join(BW_id1, by=c("codierung","year")) %>% 
  group_by(year, codierung, n) %>% 
  summarise( start = first(date), end= last(date)) %>% 
  ungroup() %>% 
  select(year, n, start, end) 

## duplicate years with more than one CDD-period of the same length are removed. 
uniqueCCD <- unique(BW_id2[,c("year", "n")])
# the average of CDD in the time-period:
avg <- mean(uniqueCCD$n)

## Calculating rate-of-change-index: values of last twenty years of measurment divided by first twenty years of measurement.
firsttwenty <- uniqueCCD %>% 
  filter(year >= startyear  & year <= (startyear+19) ) 

lasttwenty <- uniqueCCD %>% 
  filter(year >= (endyear-19)  & year <= endyear )

## There have to be values of at least 10 years to get a result of the rate-of-change-index.
if(length(firsttwenty$n) < 10 | length(lasttwenty$n) < 10){
  ABC <- NA
} else {
  ABC <- mean(lasttwenty$n) / mean(firsttwenty$n)
}
  
if(output== "standart" ){
  return(list(yearlyData = uniqueCCD, average = avg, rate.of.change= ABC))
}
if(output == "periodData"){
  return(BW_id2)
}

} # end of function

library(readr)
BW_C <- read_tsv("BigData/BW_Climate_1977_2016.txt")
meta <- read_tsv("BigData/BW_ClimateStations_meta.txt")

result <- CDD(BW_C, 257)

