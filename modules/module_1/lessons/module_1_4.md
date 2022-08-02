Module 1, Introduction to the `tidyverse`
================
Keaton Wilson, Ellen Bledsoe
12/4/2019, revised August 2022

# 2-dimensional Data and the `tidyverse`

## Learning Outcomes

-   Students will be able to install and load packages, use helpfiles,
    and navigate file paths.  
-   Students will be able to use some functions of the tidyverse:
    select, filter, mutate, summarize and the pipe.  
-   Students will compare and contrast base R and tidyverse methodology
    for subsetting data frames.
-   Students will able to use tidyverse functions to summarize
    real-world data.

## The `tidyverse`: What is it?

Different programming languages have different syntax (language
structure). The `tidyverse` is a package (more accurately, a set of
packages) offered in R that all have similar goals and a unified syntax
designed to work particularly well with 2-dimensional data.

This syntax is often different from base R, which we learned last week.
Both are useful, which is why we start with base R.

That said, we will be primarily using the `tidyverse` for the rest of
the semester, but I will never punish you for using base R in place of
`tidyverse`, as long as you get the same answer!

### Wait, what is a package??

Packages are one of the neatest things of working in an open-source
environment like R. They contains bits of code (often in the form of
functions) that can be reused, making them a core component of
reproducible data science. Anyone can develop a package, and there are
thousands of them doing all sorts of things!

### Explore the `tidyverse`

Group Challenge and Discussion (10 min)

Let’s begin by scoping out what is in the `tidyverse`. Go to
www.tidyverse.org and browse the site. In your groups, answer the 3
questions below, and be prepared to report out at the end:  
1. What are the core packages in the tidyverse?  
2. Give a one sentence summary about what each package does.  
3. What is one question you have about the tidyverse/core packages?

## Practice with the `tidyverse`

### Download and install

First things first, we need to download the `tidyverse` from the
internet onto our computer before we can use it. We typically only need
to do this once.

We use the `install.packages()` function to do this. It might take a
little while.

``` r
# download and install the tidyverse package(s)
# if you haven't done this before, remove the # in front of the line of code below
# and run this chunk
# install.packages("tidyverse")
```

### Load into R

Any time we open R/RStudio and want to use functions from the
`tidyverse`, we need to “load” the package. We use the `library()`
function to do this.

When you run this code, you’ll see a message that says “Attaching
packages” and “Conflicts.” Don’t panic!

-   The first bit tells us that the core packages have been brought into
    our R session.
-   The “conflict” part is a little more complicated but we don’t need
    to worry too much about it.
    -   If you’re curious, though, it is telling us that there are some
        functions in the `tidyverse` that have the same names as
        functions that are automatically installed with R and that the
        `tidyverse` versions of those functions will be the ones that
        get used by default unless we specify otherwise.

``` r
# load the tidyverse (tell RStudio we want to use this package in this session)
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

### Climate Data

We’re going to use a real data set on climate change from Berkeley, CA.
It outlines temperatures in major cities across the world since 1750.
We’re going to use this data set to learn the `tidyverse`!

``` r
# read in the data file

# first, make sure you file path is pointing to the correct location!

# you might also notice that we are using the function `read_csv()` instead of 
# `read.csv().` These two functions do mostly the same thing, but `read_csv()`
# is part of the `tidyverse` and gives us some more options when reading in data.
climate_df <- read_csv("../data/GlobalLandTemperaturesByMajorCity.csv")
```

    ## Rows: 239177 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (4): City, Country, Latitude, Longitude
    ## dbl  (2): AverageTemperature, AverageTemperatureUncertainty
    ## date (1): dt
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
# Let's take a look at the climate data. 
climate_df
```

    ## # A tibble: 239,177 × 7
    ##    dt         AverageTemperat… AverageTemperat… City  Country Latitude Longitude
    ##    <date>                <dbl>            <dbl> <chr> <chr>   <chr>    <chr>    
    ##  1 1849-01-01             26.7             1.44 Abid… Côte D… 5.63N    3.23W    
    ##  2 1849-02-01             27.4             1.36 Abid… Côte D… 5.63N    3.23W    
    ##  3 1849-03-01             28.1             1.61 Abid… Côte D… 5.63N    3.23W    
    ##  4 1849-04-01             26.1             1.39 Abid… Côte D… 5.63N    3.23W    
    ##  5 1849-05-01             25.4             1.2  Abid… Côte D… 5.63N    3.23W    
    ##  6 1849-06-01             24.8             1.40 Abid… Côte D… 5.63N    3.23W    
    ##  7 1849-07-01             24.1             1.25 Abid… Côte D… 5.63N    3.23W    
    ##  8 1849-08-01             23.6             1.26 Abid… Côte D… 5.63N    3.23W    
    ##  9 1849-09-01             23.7             1.23 Abid… Côte D… 5.63N    3.23W    
    ## 10 1849-10-01             25.3             1.18 Abid… Côte D… 5.63N    3.23W    
    ## # … with 239,167 more rows

This looks a bit different from the 2D data were were looking at before,
doesn’t it?

The `tidyverse` converts 2D data into something called a tibble! For our
intents and purposes, it is basically the same as a data frame (and I’ll
probably call it a data frame, in reality).

This data set clearly has a lot of data! The `tidyverse` offers a great
function called `glimpse()` that lets us take a quick look at the
dataset. Let’s look at another way to quickly view our data.

``` r
# explore the data set
glimpse(climate_df)
```

    ## Rows: 239,177
    ## Columns: 7
    ## $ dt                            <date> 1849-01-01, 1849-02-01, 1849-03-01, 184…
    ## $ AverageTemperature            <dbl> 26.704, 27.434, 28.101, 26.140, 25.427, …
    ## $ AverageTemperatureUncertainty <dbl> 1.435, 1.362, 1.612, 1.387, 1.200, 1.402…
    ## $ City                          <chr> "Abidjan", "Abidjan", "Abidjan", "Abidja…
    ## $ Country                       <chr> "Côte D'Ivoire", "Côte D'Ivoire", "Côte …
    ## $ Latitude                      <chr> "5.63N", "5.63N", "5.63N", "5.63N", "5.6…
    ## $ Longitude                     <chr> "3.23W", "3.23W", "3.23W", "3.23W", "3.2…

## Select()ing columns

Let’s use our first function, `select()`.

``` r
# Select at its core allows you pick out a selection of columns from your data
# Can folks remember how do this with base R?

# climate_df$dt
# climate_df[,1:2]

#Select does this, but with more power. 
select(climate_df, dt)
```

    ## # A tibble: 239,177 × 1
    ##    dt        
    ##    <date>    
    ##  1 1849-01-01
    ##  2 1849-02-01
    ##  3 1849-03-01
    ##  4 1849-04-01
    ##  5 1849-05-01
    ##  6 1849-06-01
    ##  7 1849-07-01
    ##  8 1849-08-01
    ##  9 1849-09-01
    ## 10 1849-10-01
    ## # … with 239,167 more rows

``` r
# Multiple columns
select(climate_df, dt, City, Country)
```

    ## # A tibble: 239,177 × 3
    ##    dt         City    Country      
    ##    <date>     <chr>   <chr>        
    ##  1 1849-01-01 Abidjan Côte D'Ivoire
    ##  2 1849-02-01 Abidjan Côte D'Ivoire
    ##  3 1849-03-01 Abidjan Côte D'Ivoire
    ##  4 1849-04-01 Abidjan Côte D'Ivoire
    ##  5 1849-05-01 Abidjan Côte D'Ivoire
    ##  6 1849-06-01 Abidjan Côte D'Ivoire
    ##  7 1849-07-01 Abidjan Côte D'Ivoire
    ##  8 1849-08-01 Abidjan Côte D'Ivoire
    ##  9 1849-09-01 Abidjan Côte D'Ivoire
    ## 10 1849-10-01 Abidjan Côte D'Ivoire
    ## # … with 239,167 more rows

``` r
select(climate_df, dt:Country, -City)
```

    ## # A tibble: 239,177 × 4
    ##    dt         AverageTemperature AverageTemperatureUncertainty Country      
    ##    <date>                  <dbl>                         <dbl> <chr>        
    ##  1 1849-01-01               26.7                          1.44 Côte D'Ivoire
    ##  2 1849-02-01               27.4                          1.36 Côte D'Ivoire
    ##  3 1849-03-01               28.1                          1.61 Côte D'Ivoire
    ##  4 1849-04-01               26.1                          1.39 Côte D'Ivoire
    ##  5 1849-05-01               25.4                          1.2  Côte D'Ivoire
    ##  6 1849-06-01               24.8                          1.40 Côte D'Ivoire
    ##  7 1849-07-01               24.1                          1.25 Côte D'Ivoire
    ##  8 1849-08-01               23.6                          1.26 Côte D'Ivoire
    ##  9 1849-09-01               23.7                          1.23 Côte D'Ivoire
    ## 10 1849-10-01               25.3                          1.18 Côte D'Ivoire
    ## # … with 239,167 more rows

``` r
# Similar process for rows - though we typically don't have row names in R
slice(climate_df, 1:4)
```

    ## # A tibble: 4 × 7
    ##   dt         AverageTemperatu… AverageTemperat… City  Country Latitude Longitude
    ##   <date>                 <dbl>            <dbl> <chr> <chr>   <chr>    <chr>    
    ## 1 1849-01-01              26.7             1.44 Abid… Côte D… 5.63N    3.23W    
    ## 2 1849-02-01              27.4             1.36 Abid… Côte D… 5.63N    3.23W    
    ## 3 1849-03-01              28.1             1.61 Abid… Côte D… 5.63N    3.23W    
    ## 4 1849-04-01              26.1             1.39 Abid… Côte D… 5.63N    3.23W

## Filtering a Dataframe with filter()

`filter()` allows you filter rows by certain conditions. Recall that we
did this a bit with base R.

``` r
# base R
climate_df[climate_df$Country == "United States",]
```

    ## # A tibble: 8,455 × 7
    ##    dt         AverageTemperat… AverageTemperat… City  Country Latitude Longitude
    ##    <date>                <dbl>            <dbl> <chr> <chr>   <chr>    <chr>    
    ##  1 1743-11-01             5.44             2.20 Chic… United… 42.59N   87.27W   
    ##  2 1743-12-01            NA               NA    Chic… United… 42.59N   87.27W   
    ##  3 1744-01-01            NA               NA    Chic… United… 42.59N   87.27W   
    ##  4 1744-02-01            NA               NA    Chic… United… 42.59N   87.27W   
    ##  5 1744-03-01            NA               NA    Chic… United… 42.59N   87.27W   
    ##  6 1744-04-01             8.77             2.36 Chic… United… 42.59N   87.27W   
    ##  7 1744-05-01            11.6              2.10 Chic… United… 42.59N   87.27W   
    ##  8 1744-06-01            18.0              1.99 Chic… United… 42.59N   87.27W   
    ##  9 1744-07-01            21.7              1.79 Chic… United… 42.59N   87.27W   
    ## 10 1744-08-01            NA               NA    Chic… United… 42.59N   87.27W   
    ## # … with 8,445 more rows

``` r
# filter
filter(climate_df, Country == "United States")
```

    ## # A tibble: 8,455 × 7
    ##    dt         AverageTemperat… AverageTemperat… City  Country Latitude Longitude
    ##    <date>                <dbl>            <dbl> <chr> <chr>   <chr>    <chr>    
    ##  1 1743-11-01             5.44             2.20 Chic… United… 42.59N   87.27W   
    ##  2 1743-12-01            NA               NA    Chic… United… 42.59N   87.27W   
    ##  3 1744-01-01            NA               NA    Chic… United… 42.59N   87.27W   
    ##  4 1744-02-01            NA               NA    Chic… United… 42.59N   87.27W   
    ##  5 1744-03-01            NA               NA    Chic… United… 42.59N   87.27W   
    ##  6 1744-04-01             8.77             2.36 Chic… United… 42.59N   87.27W   
    ##  7 1744-05-01            11.6              2.10 Chic… United… 42.59N   87.27W   
    ##  8 1744-06-01            18.0              1.99 Chic… United… 42.59N   87.27W   
    ##  9 1744-07-01            21.7              1.79 Chic… United… 42.59N   87.27W   
    ## 10 1744-08-01            NA               NA    Chic… United… 42.59N   87.27W   
    ## # … with 8,445 more rows

``` r
# Pretty similar, but easy to chain stuff together
filter(climate_df, Country == "United States" & AverageTemperature > 25)
```

    ## # A tibble: 61 × 7
    ##    dt         AverageTemperat… AverageTemperat… City  Country Latitude Longitude
    ##    <date>                <dbl>            <dbl> <chr> <chr>   <chr>    <chr>    
    ##  1 1761-07-01             27.8            2.39  Chic… United… 42.59N   87.27W   
    ##  2 1868-07-01             25.1            0.699 Chic… United… 42.59N   87.27W   
    ##  3 1900-08-01             25.2            0.49  Chic… United… 42.59N   87.27W   
    ##  4 1921-07-01             25.6            0.264 Chic… United… 42.59N   87.27W   
    ##  5 1947-08-01             26.4            0.199 Chic… United… 42.59N   87.27W   
    ##  6 1955-08-01             25.3            0.153 Chic… United… 42.59N   87.27W   
    ##  7 1959-08-01             25.1            0.205 Chic… United… 42.59N   87.27W   
    ##  8 1988-08-01             25.4            0.305 Chic… United… 42.59N   87.27W   
    ##  9 1995-08-01             25.9            0.283 Chic… United… 42.59N   87.27W   
    ## 10 2012-07-01             25.9            0.516 Chic… United… 42.59N   87.27W   
    ## # … with 51 more rows

``` r
# Also worth noting here that we haven't saved any of this. We need to write to a new object. 

us_df = filter(climate_df, Country == "United States")
```

## Group Challenge

Work with the climate data we’ve been using this class period. Construct
a small set of code that does the following:  
1. Slims down the full dataframe to one that contains the columns dt,
AverageTemperature and City.  
2. Filters the data for Paris and Mexico City (hint:this may be hard
than you think…remember to do quality control on your data) with an
average temperature less than 22.  
3. Name this new dataframe “cold_paris_and_mexico_city”

``` r
# Piped
cold_paris_and_mexico_city = climate_df %>%
  select(dt, AverageTemperature, City) %>%
  filter(City == "Paris" | City == "Mexico", 
         AverageTemperature < 22)

# Not piped
slim = select(climate_df, dt, AverageTemperature, City)
filtered = filter(slim, City == "Paris" | City == "Mexico", 
                  AverageTemperature < 22)
cold_paris_and_mexico_city = filtered
```

## The pipe

You can use the pipe operator to chain tidyverse functions together.
This has a twofold benefit - it removes the clutter of creating a lot of
intermediate objects in your workspace, but also makes things very
human-readable.

``` r
climate_df %>%
  select(dt, AverageTemperature, City) %>%
  filter(City == "Paris" | City == "Mexico", 
         AverageTemperature < 22)
```

    ## # A tibble: 5,306 × 3
    ##    dt         AverageTemperature City  
    ##    <date>                  <dbl> <chr> 
    ##  1 1835-01-01               13.1 Mexico
    ##  2 1835-02-01               12.3 Mexico
    ##  3 1835-03-01               13.9 Mexico
    ##  4 1835-04-01               16.3 Mexico
    ##  5 1835-05-01               16.9 Mexico
    ##  6 1835-06-01               16.5 Mexico
    ##  7 1835-07-01               15.4 Mexico
    ##  8 1835-08-01               15.2 Mexico
    ##  9 1835-09-01               14.2 Mexico
    ## 10 1835-10-01               13.4 Mexico
    ## # … with 5,296 more rows

## Learning new verbs - Group Assignment

You’ve had an introduction to the tidyverse verbs, but there a few more
to learn. We’re going to practice extracting information from the web,
which is a key tool in the toolkit of data scientists.

Figure out what the `mutate()` and `summarize()` functions do. Use the
web (particularly useful links include the tidyverse website, and a
help-forum for stats and programming called stack overflow). Here are
the specifics: 1) Be able to briefly describe each function  
2) Come up with an example from the climate data frame we’ve been
working on.  
As always, be ready to present to your peers.
