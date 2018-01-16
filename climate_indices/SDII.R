#-------------------------------------------------------------------------------
#Topic 4: Big data - DWD Stations with 40 years "Climate Data Baden-Württemberg"
#Indicator SDII: annual number of rain days
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
# The function requires the file "BW_Climate_1977_2016.txt" as downloaded from
# the moodle course. Fill in the path to the original, unedited file.

path <- '/Users/modchembp/Dropbox/IHF/Lehre/Datenkurs_2018/_shared_Datacourse2018/BW_Climate_1977_2016.txt'

# You need to specify your station id to run the function.

ID <-  1436

#-------------------------------------------------------------------------------
#Function
#-------------------------------------------------------------------------------

SDII <-  function(path, ID) {
  
data <- read.table(path, header = T)
data <- as_tibble(data)

data <- 
    data %>%
  #extract years
    mutate(year = year(date)) %>%
    group_by(id, year) %>%
  #count annual NA-values and days with more than 1 mm rainfall
    summarise(count_na = sum(is.na(RSK)), count_precip = sum(RSK>=1, na.rm = T)) %>% 
  #extract only your station ID
    filter(id == ID) %>%
  #Exclude years that have more than 60 NA-values
    mutate(rain_days = ifelse(count_na >= 60, NA, count_precip)) %>%
    ungroup()
  
    mw <- mean(data$rain_days, na.rm = T) #Index 1 average rain days over the whole period
    
    avg1 <-  mean(data$rain_days[which(data$year == 1977):which(data$year == 1996)], na.rm = T)
    avg2 <-  mean(data$rain_days[which(data$year == 1997):which(data$year == 2016)], na.rm = T)
    
  #Exclude time series that has less than 10 years of data and calculate Index 2
    diff <- ifelse(length(na.omit(data$rain_days)) < 10, NA, avg2/avg1 * 100)

return(list(rate_change =diff, total_mean = mw, data = data))

}

#-------------------------------------------------------------------------------
#Result
#-------------------------------------------------------------------------------

#As a result you will get a list with Index 1 (total_mean) [d], 
#Index 2 (rate_change) [%] and a data frame with the number of rain days for every
#year at your station

result <- SDII(path,ID)

