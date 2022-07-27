Module 1, Assignment 2: Getting to Know the Team
================
Ellen Bledsoe
2022-07-26

# Assignment Description

### Purpose

The goal of this assignment is to get more comfortable dealing with
large 2-dimensional data sets that you’ll often see in the wild.

### Task

Write R code to successfully answer each question below.

### Criteria for Success

-   Data and packages are loaded
-   Code is within the provided code chunks
-   Code is commented with brief descriptions of what the code does
-   Code chunks run without errors
-   Code produces the correct result
-   Questions requiring writing are answered fully

### Due Date

# Assignment Questions

We need to add some new members to Team Antarctica! We have a dataset
with 1000 people who have qualified to join the mission and some general
data about them. In this assignment, you’ll be exploring this dataset to
learn more about your incoming colleagues.

The data we are using are in a file called “mission_team_data.csv” and
should already be in your data folder.

*Remember to comment your code and run each chunk of code as you go!*

1.  In your own words, describe what a “package” is (1-2 sentences).

2.  Load the tidyverse package into the workspace.

``` r
# load the tidyverse
library(tidyverse)
```

3.  Import the dataset. Assign the dataset to an object called
    team_data. Use the read_csv() function to do this.

``` r
team_data <- read_csv("../data/mission_team_data.csv")
```

    ## Rows: 1000 Columns: 6
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (4): last, first, sex, specialties
    ## dbl (2): age, weight
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

4.  Running the code chunk above produces a message that gives us some
    useful information, even before we look at the dataset.

-   What are the dimensions of the data?
-   What are the names of the columns in the data?
-   What data *type* do you expect to find in each column (i.e.,
    numbers, character strings, T/F, etc.)

5.  Now, let’s look at the data. Uses the glimpse() *and* head()
    functions to examine the data.

``` r
glimpse(team_data)
```

    ## Rows: 1,000
    ## Columns: 6
    ## $ last        <chr> "Langston", "el-Harroun", "al-Mousa", "Johnson", "Alvarez"…
    ## $ first       <chr> "Ashante", "Shajee'a", "Mansoor", "Khamel", "Julissa", "Je…
    ## $ sex         <chr> "M", "M", "M", "F", "M", "M", "M", "F", "F", "F", "M", "M"…
    ## $ age         <dbl> 29, 48, 54, 73, 46, 35, 23, 64, 22, 59, 78, 69, 27, 76, 31…
    ## $ weight      <dbl> 186.5, 203.5, 237.0, 95.0, 161.0, 210.0, 92.5, 160.5, 235.…
    ## $ specialties <chr> "Applied Bioscience", "Horticulure", "Aquaculture", "Medic…

``` r
head(team_data)
```

    ## # A tibble: 6 × 6
    ##   last       first    sex     age weight specialties       
    ##   <chr>      <chr>    <chr> <dbl>  <dbl> <chr>             
    ## 1 Langston   Ashante  M        29   186. Applied Bioscience
    ## 2 el-Harroun Shajee'a M        48   204. Horticulure       
    ## 3 al-Mousa   Mansoor  M        54   237  Aquaculture       
    ## 4 Johnson    Khamel   F        73    95  Medicine          
    ## 5 Alvarez    Julissa  M        46   161  Hydrology         
    ## 6 Seitz      Jesse    M        35   210  Horticulure

When we have a large dataset like this, it is often helpful to summarize
the data in some way. The next few questions will help use get a better
understanding of the content of the dataset.

6.  Write some code to determine how many of our new colleagues are
    male, female, and intersex (biological sex is not binary, and not
    really even a spectrum but more of a mosaic! Happy to chat about
    this more if you’re interested, but lets just focus on getting some
    numbers for now).

7.  What is the mean height (cm) and mean weight (lbs) of the incoming
    team members? Add comments in your code chunk with the answers.

8.  What is the most common specialty for incoming team members? Least
    common?
