Module 1, Assignment 2: Getting to Know the Team
================
Ellen Bledsoe
2022-07-29

# Assignment Description

### Purpose

The goal of this assignment is to get comfortable using base R to look
at 1- and 2-dimensional datasets.

### Task

Write R code to successfully answer each question below.

### Criteria for Success

-   Code is within the provided code chunks
-   Code is commented with brief descriptions of what the code does
-   Code chunks run without errors
-   Code produces the correct result

### Due Date

# Assignment Questions

*Remember to comment your code and run each chunk of code as you go!*

## Vectors

Let’s start working with vectors, or 1-dimensional data, first.

Run this chunk of code to create a vector of data to use.

``` r
# vector with counts of penguins
counts <- c(2, 9, 4, 3, 6, 7, 1, 0, 3)
```

1.  What data class is `counts`? Write a line of code that tells you.

``` r
# data class for counts
class(counts)
```

    ## [1] "numeric"

2.  Write a line of code that pulls out the 2nd value in the vector.

``` r
# second value of counts vector
counts[2]
```

    ## [1] 9

3.  Calculate the average number of penguins that were counted.

``` r
# mean number of penguins
mean(counts)
```

    ## [1] 3.888889

## Data Frames

Now that we’ve practiced with vectors, let’s move on to 2-dimensional
data.

We need to add some new members to Team Antarctica! We have a dataset
with 1000 people who have qualified to join the mission and some general
info about them. In this part of the assignment, you’ll be exploring
this dataset to learn more about your incoming colleagues.

The data we are using are in a file called “mission_team_data.csv” and
should already be in your data folder for Module 1. The following code
chunk will read in the data. Be sure to run it before try to answer the
questions!

``` r
team_data <- read.csv("../data/mission_team_data.csv")
```

Running the code chunk above produces a message that gives us some
useful information, even before we look at the dataset. \* What are the
dimensions of the data? \* What are the names of the columns in the
data? \* What data *class* do you expect to find in each column (i.e.,
numbers, character strings, T/F, etc.)

4.  Take a look at the data frame using the `head()` function.
    Typically, `head()` provides the first 6 rows of data. Modify one of
    the arguments in `head()` so that the line of code prints the first
    10 rows. (If you aren’t sure how to do that, remember how you can
    look for help about functions!)

``` r
head(team_data, 10)
```

    ##           last   first sex age height_cm weight_kg            specialties
    ## 1     Williams  Dallas   F  37     183.4      98.1       Computer Science
    ## 2       Person Sabrina   F  29     204.5      54.6           Food Science
    ## 3           Yu Marissa   F  31     142.3      76.4             Psychology
    ## 4     Richards    Zane   M  39     140.7      84.6           Data Science
    ## 5      Douglas  Elyssa   F  31     141.9      98.2         Marine Biology
    ## 6         Tosi  Daniel   M  22     190.9      92.8           Anthropology
    ## 7        Perez    Ryan   M  26     185.4      65.9               Genetics
    ## 8       Campos    Tyra   F  45     173.9      78.0             Management
    ## 9       Wilcox    Kate   F  38     170.5      83.1            Climatology
    ## 10 Hoell-Dixon  Zakiya   F  36     198.5      63.9 Electrical Engineering

5.  Using what you know about subsetting data frames, write a line of
    code the pulls out the age for your new colleague, Marissa Yu (row
    3).

``` r
team_data[3, 4]
```

    ## [1] 31

When we have a large dataset like this, it is often helpful to summarize
the data in some way. The next few questions will help use get a better
understanding of the content of the dataset.

6.  What is the average weight (in kg) of the incoming team members?

``` r
mean(team_data$weight_kg)
```

    ## [1] 78.2531

7.  What is the mean height (cm) and mean weight (lbs) of the incoming
    team members? Add comments in your code chunk with the answers.

``` r
# minimum height
min(team_data$height_cm)
```

    ## [1] 100.3

``` r
# maximum height
max(team_data$height_cm)
```

    ## [1] 209.9

8.  Create a data frame that only includes rows of data for people whose
    specialty is “Management.”

``` r
team_data[team_data$specialties == "Management",]
```

    ##                       last       first sex age height_cm weight_kg specialties
    ## 8                   Campos        Tyra   F  45     173.9      78.0  Management
    ## 11          Urbina-Jimenez      Jessie   I  38     191.6      74.1  Management
    ## 32                el-Guler      Kabeer   M  42     115.8      63.3  Management
    ## 39               al-Hamdan       Ulyaa   F  33     173.4      88.1  Management
    ## 58                 Caradec     Breanne   F  53     169.7      43.0  Management
    ## 69                  Foutch    Kayleigh   F  28     137.1      84.0  Management
    ## 82                  Liskey       Kaela   F  23     140.9      64.5  Management
    ## 101                 Nguyen        Nhan   M  30     154.3     115.0  Management
    ## 119               Sisneros       Angel   M  24     173.6      61.6  Management
    ## 122                   Bean      Steven   M  21     184.6      57.9  Management
    ## 134                 Bowker       Jacob   M  21     140.2      57.5  Management
    ## 214             Ramamurthy       Susie   F  31     112.4      80.2  Management
    ## 215                  Ortiz        Jade   F  48     132.7      47.0  Management
    ## 246                  Hicks      Sydney   F  23     160.9      65.1  Management
    ## 292                 Becker       Carly   F  23     209.9      77.9  Management
    ## 303           Hord Sherrer       Kalan   M  27     169.8      95.5  Management
    ## 325              Stevenson     Ryshawn   M  27     137.7      71.6  Management
    ## 337 Scherschligt-Rodriguez      Ronald   M  36     167.8      62.7  Management
    ## 416               Gallardo        Eric   M  30     190.5      84.1  Management
    ## 425                  Dixon      Adaiah   F  20     161.7      56.6  Management
    ## 437                Marquez      Andrew   M  21     171.6      54.8  Management
    ## 453                el-Zaki       Aabid   M  26     166.8      76.8  Management
    ## 454                al-Alam     Hamaama   F  34     155.6     101.0  Management
    ## 455                 Tropsa     Adriana   F  37     129.7     103.8  Management
    ## 466                Carroll      Dakota   F  24     160.2      70.1  Management
    ## 470                Jamison        Gage   M  24     194.2      48.8  Management
    ## 476               el-Hamed     Haaniya   I  34     194.2      88.2  Management
    ## 486                 Farrow   Gabriella   F  38     147.5      67.8  Management
    ## 529                 Garcia       Megan   F  34     191.2      47.0  Management
    ## 550               al-Vohra     Haaniya   F  62     167.5      99.0  Management
    ## 553                 Boykin      Johnny   M  25     100.4      72.0  Management
    ## 586                   Mace    Michelle   F  34     152.1      69.6  Management
    ## 609                   John    Jonathan   M  23     141.9      83.0  Management
    ## 621                Apodaca      Cheryl   F  20     182.4      70.0  Management
    ## 635              al-Hamidi      Jameel   M  28     162.6      62.1  Management
    ## 663               al-Popal       Fawzi   M  31     198.1      86.8  Management
    ## 664                   Ross       Rocky   M  30     167.0      92.4  Management
    ## 672                Cruz Jr     Jessica   F  38     143.9      94.4  Management
    ## 687                  Vigil     Yesenia   F  40     186.8      70.0  Management
    ## 693                  Burns       Aaron   M  36     133.3      95.9  Management
    ## 713                Morales        Neil   M  33     185.5      65.9  Management
    ## 749               Greimann    Ashleigh   F  38     160.6      81.3  Management
    ## 771                   Zilm     Cynthia   F  44     198.0      81.7  Management
    ## 801              Good Wind    Willanna   F  18     192.3      74.5  Management
    ## 802                   Hong       Ashna   F  34     148.8     102.9  Management
    ## 815                Andrews        Noah   M  22     137.5      65.2  Management
    ## 821                  Smith         Eun   F  25     136.1      82.5  Management
    ## 848               al-Sabet     Zahraaa   F  26     182.8      42.2  Management
    ## 880               Hamilton       Ethan   M  25     149.3     113.7  Management
    ## 883                Hammond     Deirdra   F  20     190.2      85.3  Management
    ## 887               Hatchett         Tia   F  26     156.0      78.1  Management
    ## 934                  Lopez       Tyson   M  42     156.9      47.5  Management
    ## 948              Wirsching Alexandrina   F  49     180.7      76.2  Management
    ## 949               Fuhrmark     Zachary   M  27     150.0      82.6  Management
    ## 963                Briones       Jesus   M  35     133.4      66.6  Management
    ## 995                Skelton     Abigail   F  37     189.0      57.4  Management

9.  How many different specialties are represented amongst your new
    colleauges? This will require two steps.
    1.  First, use the `unique()` function to pull out each distinct
        value from the specialties column. Save this as an object called
        `specialties`, which is now a vector.
    2.  Use the `length()` function to count how many distinct
        specialties are in the `specialties` vector.

``` r
specialties <- unique(team_data$specialties)
specialties
```

    ##  [1] "Computer Science"       "Food Science"           "Psychology"            
    ##  [4] "Data Science"           "Marine Biology"         "Anthropology"          
    ##  [7] "Genetics"               "Management"             "Climatology"           
    ## [10] "Electrical Engineering" "Medicine"               "Hydrology"             
    ## [13] "Mechanical Engineering" "Chemical Engineering"   "Horticulture"          
    ## [16] "Aquaculture"            "Applied Bioscience"     "Geology"

``` r
length(specialties)
```

    ## [1] 18
