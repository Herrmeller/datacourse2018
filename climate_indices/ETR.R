
ETR <- function(x, ID) {
#The function uses the full DWD data sert and the id of the own station 
#The result of the function is a table with Tmax, Tmin and range per each year
#Load required packages
library(lubridate)
library(tidyverse)
library(ggplot2)
library(zoo)
library(dplyr)

BW_Climate_1977_2016 <- x 

#1.Select your station-id
BW_station <- BW_Climate_1977_2016 %>% 
filter(id==ID) 

#2.Group the data by the year
dfyear <- BW_station %>% 
  mutate(yr = year(date)) %>% 
  group_by(yr) 

#3.Filter years where na<60
dfNA <- BW_station %>% 
  mutate(yr = year(date)) %>% 
  group_by(yr) %>% 
  tally(is.na(TXK)) %>% 
  filter(n<60) 
  
#4.Join the data frames and filter the years where 'n' is equal or larger than 0 (where NA values are less than 60)
dfilter <- full_join(dfyear, dfNA) %>% 
  filter(n>=0)

#5.In the selected years, selects the minimun (TNK) and the maximum (TXK) temperatures per year
dfmax <- dfilter %>% 
  group_by(yr) %>% 
  summarise(Tmin = min(TNK, na.rm=T), Tmax = max(TXK, na.rm = T))

#6.Calculate the range
res <- dfmax %>% mutate(Trange = abs(Tmax-Tmin))
  
avg <- mean(res$Trange)  
  
if(length(res$Trange[1:20]) < 10 | length(res$Trange[21:40]) < 10){
  ABC <- NA
} else {
  ABC <- (mean(res$Trange[21:40])/mean(res$Trange[1:20]))*100
}

return(list(average_ETR = avg, ABC=ABC))

} #end of function 

result  <- ETR(x, ID)
