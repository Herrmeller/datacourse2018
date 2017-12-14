# Data Course (2018)

## Background
Collection of all R functions to calculate the indices from the paper: 

**Frich et al. (2002):** Observed Coherent Changes in Climatic Extremes During the Second Half of the Twentieth Century, Climate Research, 19(3): 193–212. 
 * Journal: <http://www.int-res.com/abstracts/cr/v19/n3/p193-212/#> 
 * PDF: <http://www.int-res.com/articles/cr2002/19/c019p193.pdf>

The paper presents a set of indices to cover manifold aspects of changing climate. To calculate the indices, rainfall and temperature date are needed on a daily basis. Temperature data should cover daily minimum, mean and maximum temperature (`Tmin`, `Tmean`and `Tmax`).

![frich](frich_index.png "Frich et al. 2002")

## Exercise 

Develope a robust and comprehensive function in R to calculate the particular index. There is more nformation about the indices in the paper (Frich et al., 2002). First, think about a good stragety to nest the desired functionality into a R function. Insert a comment block in the code with a few lines to describe the functionality and how the index is calculated.
Name your R-File according to the index, e.g. _Fd.R_, _ETR.R_, _Tn90.R_ etc.
At the end, submit your code snippet via e-mail.

## Example function

The function should work for any length of input data. With `group_by` in the `dplyr`-Package it will be possible to calculate the index values on a yearly ('year') or monthly ('month') basis. `NA`-values should be considered as well as other quality-check, e.g. miniumum length of a data year that is required to calculate an index value for that specific year etc.

Here’s some code, ```id``` represents the station id in Baden-Württemberg.
```{r}
> library("tidyverse")
> df <- read_tsv('/User/data/id_2305.txt')
> head(df)
# A tibble: 6 x 3
        date  rain  temp
      <date> <dbl> <dbl>
1 1987-01-01  21.3  10.8
2 1987-01-02   6.4   5.5
3 1987-01-03   0.2  -0.6
4 1987-01-04   3.0   2.2
5 1987-01-05   6.1   4.2
6 1987-01-06  12.0   2.8

> tail(df)
# A tibble: 6 x 3
        date  rain  temp
      <date> <dbl> <dbl>
1 2016-12-26   2.7   7.0
2 2016-12-27   0.0   0.9
3 2016-12-28   0.0  -0.6
4 2016-12-29   0.0  -2.2
5 2016-12-30   0.0  -5.6
6 2016-12-31   0.0  -6.9

> summary(df)
      date                 rain              temp       
 Min.   :1987-01-01   Min.   :  0.000   Min.   :-16.20  
 1st Qu.:1994-07-02   1st Qu.:  0.000   1st Qu.:  4.90  
 Median :2001-12-31   Median :  0.100   Median : 10.60  
 Mean   :2001-12-31   Mean   :  3.502   Mean   : 10.29  
 3rd Qu.:2009-07-01   3rd Qu.:  4.200   3rd Qu.: 15.90  
 Max.   :2016-12-31   Max.   :131.300   Max.   : 28.50  
                      NA's   :1   
```


## Hints
...
