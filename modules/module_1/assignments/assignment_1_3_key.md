Module 1, Assignment 3: <br> Getting to Know Your Home
================
Ellen Bledsoe
2022-07-26

# Assignment Description

### Purpose

### Task

### Criteria for Success

Assignment 1-3 - Getting to know your new home

For this final assignment for module 1, you’ll be working with another
real-world data set, a collection of data from climate stations
scattered across antarctica. The file can be downloaded here
(<https://tinyurl.com/uwf9qzk>).

Your goal for this assignment is to use all of the programming skills
you’ve acquired so far to provide some insight into this complex and
large data set.

The assignment is to write an R script that is properly formatted with
best-coding practices we’ve discussed that accomplishes the following:

1)  Loads in the tidyverse packages to the workspace, and reads in the
    data  
2)  Performs a quality control check on the data and notes the number of
    columns and rows in commented notes  
3)  How many unique stations are there reported here? (Hint: look up the
    help file for the unique() function)  
4)  Write a chunk of code that calculates the mean temperature for the
    month of January for each station. You can use base R or tidyverse,
    but it will probably be easier in tidyverse. Hint: think about using
    the pipe, group_by(), filter() and summarize().  
5)  Which station had the coldest average temperature in January (hint:
    look up the arrange() function)

Upload the script to D2L when finished.

# Assignment Questions

1.  Load in tidyverse and read in the data. Remember to use read_csv().

``` r
# packages
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✔ ggplot2 3.3.6     ✔ purrr   0.3.4
    ## ✔ tibble  3.1.7     ✔ dplyr   1.0.9
    ## ✔ tidyr   1.2.0     ✔ stringr 1.4.0
    ## ✔ readr   2.1.2     ✔ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
# loading in the data
df <- read_csv("../data/aggregated_station_data.csv")
```

    ## Rows: 139144 Columns: 12

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (1): station_id
    ## dbl (11): year, day, month, running_day, hour, temp, pressure, wind_speed, w...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

2.  Perform a quality control check on the data and note the number of
    columns and rows in commented notes

``` r
# QC
glimpse(df)
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
#13 columns and 138,920 rows 
```

3.  How many unique stations are there reported here? (Hint: look up the
    help file for the unique() function)

``` r
# Unique Stations
unique(df$station_id)
```

    ##   [1] "ag4201801q3h" "ag4201802q3h" "ag4201803q3h" "ag4201804q3h" "ag4201805q3h"
    ##   [6] "ag4201806q3h" "ag4201807q3h" "ag4201808q3h" "ag4201809q3h" "ag4201810q3h"
    ##  [11] "ag4201811q3h" "ag4201812q3h" "bal201801q3h" "bal201802q3h" "bal201803q3h"
    ##  [16] "bal201804q3h" "bal201805q3h" "bal201806q3h" "bal201807q3h" "bal201808q3h"
    ##  [21] "bal201809q3h" "bal201810q3h" "bal201811q3h" "bal201812q3h" "brp201801q3h"
    ##  [26] "brp201802q3h" "brp201803q3h" "brp201804q3h" "brp201805q3h" "brp201806q3h"
    ##  [31] "brp201807q3h" "brp201808q3h" "brp201809q3h" "brp201810q3h" "brp201811q3h"
    ##  [36] "brp201812q3h" "byd201801q3h" "byd201802q3h" "byd201803q3h" "byd201804q3h"
    ##  [41] "byd201805q3h" "byd201806q3h" "byd201807q3h" "byd201808q3h" "byd201809q3h"
    ##  [46] "byd201810q3h" "byd201811q3h" "byd201812q3h" "cbd201801q3h" "cbd201802q3h"
    ##  [51] "cbd201803q3h" "cbd201804q3h" "cbd201805q3h" "cbd201806q3h" "cbd201807q3h"
    ##  [56] "cbd201808q3h" "cbd201810q3h" "cbd201811q3h" "cbd201812q3h" "cha201801q3h"
    ##  [61] "cha201802q3h" "cha201803q3h" "cha201804q3h" "cha201805q3h" "cha201806q3h"
    ##  [66] "d10201801q3h" "d10201802q3h" "d10201803q3h" "d10201804q3h" "d10201805q3h"
    ##  [71] "d10201806q3h" "d10201807q3h" "d10201808q3h" "d10201809q3h" "d10201810q3h"
    ##  [76] "d10201811q3h" "d10201812q3h" "d47201801q3h" "d47201802q3h" "d47201803q3h"
    ##  [81] "d47201804q3h" "d47201805q3h" "d47201806q3h" "d47201807q3h" "d47201808q3h"
    ##  [86] "d47201809q3h" "d47201810q3h" "d47201811q3h" "d47201812q3h" "d85201801q3h"
    ##  [91] "d85201802q3h" "d85201803q3h" "d85201804q3h" "d85201805q3h" "d85201806q3h"
    ##  [96] "d85201807q3h" "d85201808q3h" "d85201809q3h" "d85201810q3h" "d85201811q3h"
    ## [101] "d85201812q3h" "dc2201801q3h" "dc2201802q3h" "dc2201803q3h" "dc2201804q3h"
    ## [106] "dc2201805q3h" "dc2201806q3h" "dc2201807q3h" "dc2201808q3h" "dc2201809q3h"
    ## [111] "dc2201810q3h" "dc2201811q3h" "dc2201812q3h" "dis201801q3h" "dis201802q3h"
    ## [116] "dis201803q3h" "dis201804q3h" "dis201805q3h" "dis201806q3h" "dis201807q3h"
    ## [121] "dis201808q3h" "dis201809q3h" "dis201810q3h" "dis201811q3h" "dis201812q3h"
    ## [126] "ekn201801q3h" "ekn201802q3h" "ekn201803q3h" "ekn201804q3h" "ekn201805q3h"
    ## [131] "ekn201806q3h" "ekn201807q3h" "ekn201808q3h" "ekn201809q3h" "ekn201810q3h"
    ## [136] "ekn201811q3h" "ekn201812q3h" "eln201801q3h" "eln201802q3h" "eln201803q3h"
    ## [141] "eln201804q3h" "eln201805q3h" "eln201806q3h" "eln201807q3h" "eln201808q3h"
    ## [146] "eln201809q3h" "eln201810q3h" "eln201811q3h" "eln201812q3h" "elz201801q3h"
    ## [151] "elz201802q3h" "elz201803q3h" "elz201804q3h" "elz201805q3h" "elz201806q3h"
    ## [156] "elz201807q3h" "elz201808q3h" "elz201809q3h" "elz201810q3h" "elz201811q3h"
    ## [161] "elz201812q3h" "ema201801q3h" "ema201802q3h" "ema201803q3h" "ema201804q3h"
    ## [166] "ema201805q3h" "ema201806q3h" "ema201807q3h" "ema201808q3h" "ema201809q3h"
    ## [171] "ema201810q3h" "ema201811q3h" "ema201812q3h" "eml201801q3h" "eml201802q3h"
    ## [176] "eml201803q3h" "eml201804q3h" "eml201805q3h" "eml201806q3h" "eml201807q3h"
    ## [181] "eml201808q3h" "eml201809q3h" "eml201810q3h" "eml201811q3h" "eml201812q3h"
    ## [186] "ern201801q3h" "ern201802q3h" "ern201803q3h" "ern201804q3h" "ern201805q3h"
    ## [191] "ern201806q3h" "ern201807q3h" "ern201808q3h" "ern201809q3h" "ern201810q3h"
    ## [196] "ern201811q3h" "ern201812q3h" "fer201801q3h" "fer201802q3h" "fer201803q3h"
    ## [201] "fer201804q3h" "fer201805q3h" "fer201806q3h" "fer201807q3h" "fer201808q3h"
    ## [206] "fer201809q3h" "fer201810q3h" "fer201811q3h" "fer201812q3h" "fuj201801q3h"
    ## [211] "fuj201802q3h" "fuj201803q3h" "fuj201804q3h" "fuj201805q3h" "fuj201806q3h"
    ## [216] "fuj201807q3h" "fuj201808q3h" "fuj201809q3h" "fuj201810q3h" "fuj201811q3h"
    ## [221] "fuj201812q3h" "gil201801q3h" "gil201802q3h" "gil201803q3h" "gil201804q3h"
    ## [226] "gil201805q3h" "gil201806q3h" "gil201807q3h" "gil201808q3h" "gil201809q3h"
    ## [231] "gil201810q3h" "gil201811q3h" "gil201812q3h" "hen201812q3h" "hry201801q3h"
    ## [236] "hry201802q3h" "hry201803q3h" "hry201804q3h" "hry201805q3h" "hry201806q3h"
    ## [241] "hry201807q3h" "hry201808q3h" "hry201809q3h" "hry201810q3h" "hry201811q3h"
    ## [246] "hry201812q3h" "jas201801q3h" "jas201802q3h" "jas201803q3h" "jas201804q3h"
    ## [251] "jas201805q3h" "jas201806q3h" "jas201807q3h" "jas201808q3h" "jas201809q3h"
    ## [256] "jas201810q3h" "jas201811q3h" "jas201812q3h" "jnt201801q3h" "jnt201802q3h"
    ## [261] "jnt201803q3h" "jnt201804q3h" "jnt201805q3h" "jnt201806q3h" "jnt201807q3h"
    ## [266] "jnt201808q3h" "jnt201810q3h" "jnt201811q3h" "jnt201812q3h" "kms201801q3h"
    ## [271] "kms201802q3h" "kms201803q3h" "kms201804q3h" "kms201805q3h" "kms201806q3h"
    ## [276] "kms201807q3h" "kms201808q3h" "kms201809q3h" "kms201810q3h" "kms201811q3h"
    ## [281] "kms201812q3h" "kth201801q3h" "kth201802q3h" "kth201803q3h" "kth201804q3h"
    ## [286] "kth201805q3h" "kth201806q3h" "kth201807q3h" "kth201808q3h" "kth201809q3h"
    ## [291] "kth201810q3h" "kth201811q3h" "kth201812q3h" "lda201801q3h" "lda201802q3h"
    ## [296] "lda201803q3h" "lda201804q3h" "lda201805q3h" "lda201806q3h" "lda201807q3h"
    ## [301] "lda201808q3h" "lda201809q3h" "lda201810q3h" "lda201811q3h" "lda201812q3h"
    ## [306] "let201801q3h" "let201802q3h" "let201803q3h" "let201804q3h" "let201805q3h"
    ## [311] "let201806q3h" "let201807q3h" "let201808q3h" "let201809q3h" "let201810q3h"
    ## [316] "let201811q3h" "let201812q3h" "lr2201801q3h" "lr2201802q3h" "lr2201803q3h"
    ## [321] "lr2201804q3h" "lr2201805q3h" "lr2201806q3h" "lr2201807q3h" "lr2201808q3h"
    ## [326] "lr2201809q3h" "lr2201810q3h" "lr2201811q3h" "lr2201812q3h" "mgt201801q3h"
    ## [331] "mgt201802q3h" "mgt201803q3h" "mgt201804q3h" "mgt201805q3h" "mgt201806q3h"
    ## [336] "mgt201807q3h" "mgt201808q3h" "mgt201809q3h" "mgt201810q3h" "mgt201811q3h"
    ## [341] "mgt201812q3h" "miz201801q3h" "miz201802q3h" "miz201803q3h" "miz201804q3h"
    ## [346] "miz201805q3h" "miz201806q3h" "miz201807q3h" "miz201808q3h" "miz201809q3h"
    ## [351] "miz201810q3h" "miz201811q3h" "miz201812q3h" "mla201801q3h" "mla201802q3h"
    ## [356] "mla201803q3h" "mla201804q3h" "mla201805q3h" "mla201806q3h" "mla201807q3h"
    ## [361] "mla201808q3h" "mla201809q3h" "mla201810q3h" "mla201811q3h" "mla201812q3h"
    ## [366] "mln201801q3h" "mln201802q3h" "mln201803q3h" "mln201804q3h" "mln201805q3h"
    ## [371] "mln201806q3h" "mln201807q3h" "mln201808q3h" "mln201809q3h" "mln201810q3h"
    ## [376] "mln201811q3h" "mln201812q3h" "mnb201801q3h" "mnb201802q3h" "mnb201803q3h"
    ## [381] "mnb201804q3h" "mnb201805q3h" "mnb201806q3h" "mnb201807q3h" "mnb201808q3h"
    ## [386] "mnb201809q3h" "mnb201810q3h" "mnb201811q3h" "mnb201812q3h" "mp2201801q3h"
    ## [391] "mp2201802q3h" "mp2201803q3h" "mp2201804q3h" "mp2201805q3h" "mp2201806q3h"
    ## [396] "mp2201807q3h" "mp2201808q3h" "mp2201810q3h" "mp2201811q3h" "mp2201812q3h"
    ## [401] "mpt201801q3h" "mpt201802q3h" "mpt201803q3h" "mpt201804q3h" "mpt201805q3h"
    ## [406] "mpt201806q3h" "mpt201807q3h" "mpt201808q3h" "mpt201809q3h" "mpt201810q3h"
    ## [411] "mpt201811q3h" "mpt201812q3h" "mts201801q3h" "mts201811q3h" "nic201809q3h"
    ## [416] "nic201810q3h" "pda201802q3h" "pda201803q3h" "pda201810q3h" "pda201811q3h"
    ## [421] "pda201812q3h" "phx201801q3h" "phx201802q3h" "phx201803q3h" "phx201804q3h"
    ## [426] "phx201809q3h" "phx201810q3h" "phx201811q3h" "pos201801q3h" "pos201802q3h"
    ## [431] "pos201803q3h" "pos201804q3h" "pos201805q3h" "pos201806q3h" "pos201808q3h"
    ## [436] "pos201809q3h" "pos201810q3h" "pos201811q3h" "pos201812q3h" "rls201801q3h"
    ## [441] "rls201802q3h" "rls201803q3h" "rls201804q3h" "rls201805q3h" "rls201806q3h"
    ## [446] "rls201807q3h" "rls201808q3h" "rls201809q3h" "rls201810q3h" "rls201811q3h"
    ## [451] "rls201812q3h" "sab201801q3h" "sab201802q3h" "sab201803q3h" "sab201804q3h"
    ## [456] "sab201805q3h" "sab201806q3h" "sab201807q3h" "sab201808q3h" "sab201809q3h"
    ## [461] "sab201810q3h" "sab201811q3h" "sab201812q3h" "sid201801q3h" "sid201802q3h"
    ## [466] "sid201803q3h" "sid201804q3h" "sid201805q3h" "sid201806q3h" "sid201807q3h"
    ## [471] "sid201808q3h" "sid201809q3h" "sid201810q3h" "sid201811q3h" "sid201812q3h"
    ## [476] "swt201801q3h" "swt201802q3h" "swt201803q3h" "swt201804q3h" "swt201805q3h"
    ## [481] "swt201806q3h" "swt201807q3h" "swt201808q3h" "swt201809q3h" "swt201810q3h"
    ## [486] "swt201811q3h" "swt201812q3h" "thi201801q3h" "thi201802q3h" "thi201803q3h"
    ## [491] "thi201804q3h" "thi201805q3h" "thi201806q3h" "thi201807q3h" "thi201808q3h"
    ## [496] "thi201809q3h" "thi201810q3h" "thi201811q3h" "thi201812q3h" "trs201801q3h"
    ## [501] "trs201802q3h" "trs201803q3h" "trs201804q3h" "trs201805q3h" "trs201806q3h"
    ## [506] "trs201807q3h" "trs201808q3h" "trs201809q3h" "trs201810q3h" "trs201811q3h"
    ## [511] "trs201812q3h" "vto201801q3h" "vto201802q3h" "vto201803q3h" "vto201804q3h"
    ## [516] "vto201805q3h" "vto201806q3h" "vto201807q3h" "vto201808q3h" "vto201809q3h"
    ## [521] "vto201810q3h" "vto201811q3h" "vto201812q3h" "wdb201801q3h" "wdb201802q3h"
    ## [526] "wdb201803q3h" "wdb201804q3h" "wdb201805q3h" "wdb201806q3h" "wdb201807q3h"
    ## [531] "wdb201808q3h" "wdb201809q3h" "wdb201810q3h" "wdb201811q3h" "wdb201812q3h"
    ## [536] "wfd201801q3h" "wfd201802q3h" "wfd201803q3h" "wfd201804q3h" "wfd201805q3h"
    ## [541] "wfd201806q3h" "wfd201807q3h" "wfd201808q3h" "wfd201809q3h" "wfd201810q3h"
    ## [546] "wfd201811q3h" "wfd201812q3h" "wti201801q3h" "wti201802q3h" "wti201803q3h"
    ## [551] "wti201804q3h" "wti201805q3h" "wti201806q3h" "wti201807q3h" "wti201808q3h"
    ## [556] "wti201809q3h" "wti201810q3h" "wti201811q3h" "wti201812q3h" "wtl201801q3h"
    ## [561] "wtl201802q3h" "wtl201803q3h" "wtl201804q3h" "wtl201805q3h" "wtl201806q3h"
    ## [566] "wtl201807q3h" "wtl201808q3h" "wtl201809q3h" "wtl201810q3h" "wtl201811q3h"
    ## [571] "wtl201812q3h"

4.  Write a chunk of code that calculates the mean temperature for the
    month of January for each station. You can use base R or tidyverse,
    but it will probably be easier in tidyverse. Hint: think about using
    the pipe, group_by(), filter() and summarize().

``` r
# Mean for Jan for each station
df %>%
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

5.  Which station had the coldest average temperature in January (hint:
    look up the arrange() function)

``` r
# Mean for Jan for each station
df %>%
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
