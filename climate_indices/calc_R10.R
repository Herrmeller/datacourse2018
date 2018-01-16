calc_R10<-function(bw, id_station) {
###This functions uses as input the full DWD data set and the id of the station of interest
###The function returns a list containnig the R10 per year, the average R10 for all the years and the rate of change for this variable.

###---load required package---###
library(lubridate)
library(readr)
library(dplyr)
library(tidyr)
#it selects the station you are working with
bw<-bw%>%filter(id==id_station)
bw<-bw%>%mutate (year= lubridate::year(date))# jmakes a variable for year
bw<-bw%>% filter (id==id_station)
#Discard years with more than 60 NA
NA_vals<-(is.na(bw$RSK))# adds a variable with TRUE if it's NA
bw<-bw%>% mutate(NA_vals) #adds the column
bad_years<-bw%>%filter(NA_vals==TRUE, id==id_station)%>%group_by(year)%>%count()%>% filter(n>60)%>%ungroup(bw)# gets bad years
#prints years that are not beeing used if there are any
nbad_years<-dim(bad_years)
if (nbad_years[1]>0){
  print(paste( bad_years$year,"has more than 60 NAs values and will not be used for calculations"))
}
#gets only good years
bw<-bw%>%filter(!(year%in%(bad_years$year)))
#calculate R10 and mean R10
R10_per_year<-bw %>% filter (id==id_station) %>%  filter(RSK>=10) %>% group_by(year) %>% count()%>%ungroup(R10_per_year)
R10_mean<-mean(R10_per_year$n)
#rate of change
dd=dim(R10_per_year)
dd=dd[1]
dd_half=round(dd/2)
#only calculates if there are more than 10 years in each half
if(dd_half>10){
  first_half<-R10_per_year%>%slice(1:dd_half)%>%summarise(mean(n))
  seccond_half<-R10_per_year%>%slice(dd_half+1:dd)%>%summarise(mean(n))
  ABC=seccond_half/first_half
  }else
  {ABC=NA
  print("ABC can not be calculated. No enough years")
  }
return(list(R10_per_year, R10_mean, ABC))
}