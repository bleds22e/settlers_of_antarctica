# Data: Team Member Applicants
# Ellen Bledsoe
# July 2022
# Originally K. Wilson's code

# PACKAGES ----------------------------------------------------------------
library(tidyverse)
library(randomNames)


# GENERATE DATA -----------------------------------------------------------

set.seed(11)

## Sex ----

# only M/F (0/1) for now to get names from randomNames
sex <- sample(0:1, 1000, replace = TRUE)

## Name Generation ----

names <- as_tibble(randomNames(n = 1000, gender = sex, name.sep = ",")) %>% 
  rename(name = value) %>% 
  separate(name, into = c("last", "first"), 
           sep = ",", remove = TRUE, extra =  "merge", fill = "right")

## Adjust Sexes ----

# include 23 intersex team members and change sexes from numeric to chr
sex[sample(length(sex), 23)] <- 2 
labels <- if_else(sex == 0, "M",
                  if_else(sex == 1, "F", "I"))

## Ages ----

# use a right-skewed distribution to get an average age of ~30
age <- round(rlnorm(1000, meanlog = 3.4, sdlog = .3)) 

# address ages younger than 18 and older than 80
for (i in 1:length(age)){ 
  if (age[i] < 18 | age[i] > 80){ 
    age[i] <- sample(18:80, size = 1)
  }
}

## Specialty/discipline ----

specialty = c("Mechanical Engineering", "Horticulture", "Aquaculture", "Computer Science", 
              "Data Science", "Geology", "Marine Biology", "Climatology", "Anthropology",
              "Electrical Engineering", "Chemical Engineering", "Medicine", "Psychology",
              "Management", "Applied Bioscience", "Genetics", "Hydrology", "Food Science")
specialties <- sample(specialty, size = 1000, replace = TRUE)

## Weight ----

weight <- round(rnorm(1000, mean = 78, sd = 25) , 1) 

# address highly improbable weights
for (i in 1:length(weight)){
  if (weight[i] < 38 | weight[i] > 120) { 
    weight[i] <- sample(35:115, size = 1)
  }
}

## Height ----

height <- round(rnorm(1000, mean = 167, sd = 30), 1)

# address highly improbable heights
for (i in 1:length(height)){
  if (height[i] < 100 | height[i] > 210){ 
    height[i] <- sample(140:200, size = 1)
  }
}


# CREATE DATAFRAME --------------------------------------------------------

# combine all vectors
mission_app <- data.frame(names, 
                          sex = labels, 
                          age, 
                          height_cm = height,
                          weight_kg = weight,
                          specialties)

# save dataframe
write_csv(mission_app, "./modules/module_1/data/mission_team_data.csv")
