Module 1 Assignment 3: Getting to Know your Home
================
Ellen Bledsoe
2022-08-02

# Assignment Description

### Purpose

The goal of this assignment is to get comfortable using the `tidyverse`
with  
2-dimensional datasets and compare this process to using base R.

### Task

Write R code using the `tidyverse` to successfully answer each question
below.

### Criteria for Success

-   Code is within the provided code chunks
-   Code is commented with brief descriptions of what the code does
-   Code chunks run without errors
-   Code produces the correct result
-   This is the one time I *will* take points off for not using
    `tidyverse`…

### Due Date

# Assignment Questions

For this final assignment for Module 1, you’ll be working with another
real-world data set–a collection of data from climate stations scattered
across Antarctica.

1.  Load in the `tidyverse` package.

``` r
# load packages
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ ggplot2 3.3.6     ✔ purrr   0.3.4
    ## ✔ tibble  3.1.7     ✔ dplyr   1.0.9
    ## ✔ tidyr   1.2.0     ✔ stringr 1.4.0
    ## ✔ readr   2.1.2     ✔ forcats 0.5.1
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

2.  Load in the data file (called aggregated_station_data.csv). It
    should already be in your data folder. Save the data as an object
    called `weather`.

(Hint: remember to use the `tidyverse` function for reading in data! If
it doesn’t pop up when you start typing, you probably forgot to run the
code chunk above).

``` r
# read in weather station data
weather <- read_csv("../data/aggregated_station_data.csv")
```

    ## Rows: 139144 Columns: 12
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (1): station_id
    ## dbl (11): year, day, month, running_day, hour, temp, pressure, wind_speed, w...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

3.  Use the `glimpse()` function to take a peek at the data. How many
    rows and columns are in the data? Write these answers in the code
    chunk as comments.

``` r
# explore the data
glimpse(weather)
```

    ## Rows: 139,144
    ## Columns: 12
    ## $ year           <dbl> 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2…
    ## $ day            <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3…
    ## $ month          <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ running_day    <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3…
    ## $ hour           <dbl> 0, 300, 600, 900, 1200, 1500, 1800, 2100, 0, 300, 600, …
    ## $ temp           <dbl> -29.5, -27.4, -25.5, -24.9, -25.0, -27.5, -30.3, -30.1,…
    ## $ pressure       <dbl> 629.0, 628.9, 628.8, 629.1, 629.5, 629.7, 629.7, 630.1,…
    ## $ wind_speed     <dbl> 5.1, 5.8, 5.5, 5.8, 3.9, 3.4, 3.3, 3.8, 5.1, 4.9, 5.5, …
    ## $ wind_direction <dbl> 247, 236, 228, 219, 230, 242, 259, 243, 238, 235, 230, …
    ## $ humidity       <dbl> 60.9, 62.0, 64.0, 63.0, 61.0, 64.0, 64.0, 66.6, 62.0, 6…
    ## $ delta_t        <dbl> 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, …
    ## $ station_id     <chr> "ag4201801q3h", "ag4201801q3h", "ag4201801q3h", "ag4201…

``` r
# rows: 139, 144
# columns: 12
```

4.  Write code to determine how many unique stations are in the dataset.

(Hint: look up the help file for the `distinct()` function).

``` r
# number of unique stations
weather %>% 
  distinct(station_id) %>% 
  count() # optional 
```

    ## # A tibble: 1 × 1
    ##       n
    ##   <int>
    ## 1   571

5.  Write a chunk of code that calculates the mean temperature for the
    month of January for each station.

Hint: think about using the pipe, `filter()`, `group_by()`, and
`summarize()`.

``` r
weather %>% 
  filter(month == 1) %>% 
  group_by(station_id) %>% 
  summarize(mean_temp = mean(temp))
```

    ## # A tibble: 49 × 2
    ##    station_id   mean_temp
    ##    <chr>            <dbl>
    ##  1 ag4201801q3h   -27.6  
    ##  2 bal201801q3h   -17.2  
    ##  3 brp201801q3h    -4.23 
    ##  4 byd201801q3h   -15.5  
    ##  5 cbd201801q3h    -0.221
    ##  6 cha201801q3h    65.5  
    ##  7 d10201801q3h    16.5  
    ##  8 d47201801q3h   -13.4  
    ##  9 d85201801q3h   -22.3  
    ## 10 dc2201801q3h   -10.3  
    ## # … with 39 more rows

6.  Write code to determine which station had the coldest average
    temperature in January.

(hint: look up the `arrange()` function)

``` r
weather %>% 
  filter(month == 1) %>% 
  group_by(station_id) %>% 
  summarize(mean_temp = mean(temp)) %>% 
  arrange(mean_temp)
```

    ## # A tibble: 49 × 2
    ##    station_id   mean_temp
    ##    <chr>            <dbl>
    ##  1 ag4201801q3h    -27.6 
    ##  2 rls201801q3h    -26.1 
    ##  3 d85201801q3h    -22.3 
    ##  4 jas201801q3h    -18.0 
    ##  5 bal201801q3h    -17.2 
    ##  6 byd201801q3h    -15.5 
    ##  7 d47201801q3h    -13.4 
    ##  8 kth201801q3h    -10.8 
    ##  9 dc2201801q3h    -10.3 
    ## 10 sid201801q3h     -9.73
    ## # … with 39 more rows
