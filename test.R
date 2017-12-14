# ----- Clean and Define  -----
rm(list=ls())
options(max.print=10e8, digits=5)
options(tibble.print_max = 15, tibble.print_min = 15)

# ----- Load Data -----
library(tidyverse)
df <- mtcars
glimpse(df)
