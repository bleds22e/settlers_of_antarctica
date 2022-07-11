# Data/Application Generation
# Keaton Wilson
# keatonwilson@me.com
# 2019-10-28
# EKB edits, July 2022

# packages
library(tidyverse)
library(randomNames)
library(stringr)

# sex
sex <- sample(0:1, 1000, replace = TRUE)
sex[sample(length(sex), 23)] <- 2 # include 23 intersex
labels <- if_else(sex == 0, "F",
                 if_else(sex == 1, "M", "I"))

# name generation
names <- as_tibble(randomNames(n = 1000, gender = sex, name.sep = ",")) %>% 
  rename(name = value) %>% 
  separate(name, into = c("last", "first"), 
           sep = ",", remove = TRUE, extra =  "merge", fill = "right")

# ages
age <- sample(18:90, size = 1000, replace = TRUE)

# specialty/discipline
specialty = c("Mechanical Engineering", "Horticulure", "Aquaculture", "Computer Science", 
              "Data Science", "Geology", "Marine Biology", "Climatology", "Anthropology",
              "Electrical Engineering", "Chemical Engineering", "Medicine", "Psychology",
              "Management", "Applied Bioscience", "Genetics", "Hydrology", "Food Science")
specialties <- sample(specialty, size = 1000, replace = TRUE)

# weight
weight = sample(seq(from = 90.0, to = 250, by = 0.5), size = 1000, replace = TRUE)

# height?

# combine all
mission_app <- data.frame(names, 
                          sex = labels, 
                          age, 
                          weight,
                          specialties)

write_csv(mission_app, "./modules/module_1/data/mission_team_data.csv")
