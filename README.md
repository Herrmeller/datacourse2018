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

## Load data and summary

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


## Example function

The function should work for any length of input data. With `group_by` in the `dplyr`-Package it will be possible to calculate the index values on a yearly ('year') or monthly ('month') basis. `NA`-values should be considered as well as other quality-check, e.g. miniumum length of a data year that is required to calculate an index value for that specific year etc.

Try to use the `dplyr`-verbs:
 * `filter` (to filter specific obervations in the rows)
 * `select` (to select specific variables in the columns, if needed)
 * `mutate` (to calculate new variables in a new column)
 * `summarise`(to summarise many observations into one value, e.g. `mean(...)`)
 * `arrange` (to bring the observations of the `data_frame` in a specific order)
 * and others like: `top_n()`,`count()`,`tally()`, `slice()`,...
 
 <https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf>
 
Often `rollapply` from the package `zoo`is very helpful:

´´´{r}
> df %>% mutate(tm5 = rollapply(tm, width = 5, FUN = "mean", align="center", fill=NA))
# A tibble: 10,958 x 7
         date    id  rain    tn    tm    tx   tm5
       <date> <int> <dbl> <dbl> <dbl> <dbl> <dbl>
 1 1987-01-01  1443   8.6   8.3  11.4  13.1    NA
 2 1987-01-02  1443   7.0   5.0   5.5  13.1    NA
 3 1987-01-03  1443   6.2  -2.7  -0.8   5.1  4.38
 4 1987-01-04  1443   1.3  -2.6   1.5   4.5  2.50
 5 1987-01-05  1443   8.8   0.3   4.3   5.7  0.88
 6 1987-01-06  1443   6.9   1.2   2.0   5.6 -0.08
 7 1987-01-07  1443   2.1  -4.6  -2.6   1.7 -1.28
 8 1987-01-08  1443   0.0  -7.2  -5.6  -1.6 -2.70
 9 1987-01-09  1443   0.0  -8.2  -4.5  -1.7 -5.30
10 1987-01-10  1443   1.4  -4.1  -2.8  -0.8 -7.78
# ... with 10,948 more rows
´´´



## Hints
...
