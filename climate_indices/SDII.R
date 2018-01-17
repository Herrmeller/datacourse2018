#-------------------------------------------------------------------------------
#Topic 4: Big data - DWD Stations with 40 years "Climate Data Baden-Württemberg"
#
# Simple daily intensity index: 
# total amount of rainfall per year devided by the number of rain days per year
#
#M. Lorff, J. Opdenhoff, N. Veigel, Januar 2018
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#Packages
#-------------------------------------------------------------------------------

library("lubridate")
library("tidyverse")

#-------------------------------------------------------------------------------
#Data
#-------------------------------------------------------------------------------
# The function requires the data from file "BW_Climate_1977_2016.txt" as downloaded from
# the moodle course. Use e.g. read_tsv on the original, unedited file.


# You need to specify your station id to run the function.

ID <-  2638

#-------------------------------------------------------------------------------
#Function
#-------------------------------------------------------------------------------

SDII <-  function(data, ID) {
  

data <- 
    data %>%
  #extract years
    mutate(year = year(date)) %>%
    group_by(id, year) %>%
  #count annual NA-values, days with more than 1 mm rainfall and sum up the total rainfall per year
    summarise(count_na = sum(is.na(RSK)), count_precip = sum(RSK>=1, na.rm = T), total = sum(RSK, na.rm = T)) %>%
  #extract only your station ID
    filter(id == ID) %>%
  #Exclude years that have more than 60 NA-values
    mutate(rain_days = ifelse(count_na >= 60, NA, count_precip)) %>%
    mutate(value_SDII = total/rain_days * 10) %>%
    ungroup()
  
    mw <- mean(data$value_SDII, na.rm = T) #Index 1 average rain days over the whole period
    
    #calculate mean of 20-year-serieses, BUT ONLY if NAs are less then 10
    avg1 <-  ifelse(length(na.omit(data$value_SDII)[which(data$year == 1977):which(data$year == 1996)]) < 10, NA, mean(data$value_SDII[which(data$year == 1977):which(data$year == 1996)], na.rm = T))
    avg2 <-  ifelse(length(na.omit(data$value_SDII)[which(data$year == 1997):which(data$year == 2016)]) < 10, NA, mean(data$value_SDII[which(data$year == 1997):which(data$year == 2016)], na.rm = T))   
    
    #calculate Index 2
    diff <- (avg2/avg1) * 100

return(list(rate_change =diff, total_mean = mw, data = data))

}

#-------------------------------------------------------------------------------
#Result
#-------------------------------------------------------------------------------

#As a result you will get a list with Index 1 (total_mean) [d], 
#Index 2 (rate_change) [%] and a data frame with the number of rain days for every
#year at your station

result <- SDII(raw_data,ID)
