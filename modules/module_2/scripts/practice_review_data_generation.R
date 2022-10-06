# Practice Data for Review - We're going to need a bigger fish
# Keaton Wilson
# keatonwilson@me.com
# 2020-01-07

# packages
library(tidyverse)
library(truncnorm)

# Data - in general, we want to make a data set that students can work with to 
# practice the main skills learned in this module (simulation, functions, 
# iteration, basic plotting). 

tilapia_growth = data.frame(tank_id = rep(1:16, each = 20),
                            fish_id = 1:320, 
                            perc_soy_protein = rep(seq(0.20, 
                                                       0.80, 
                                                       by = 0.2), 
                                                   each = 80))

complement <- function(y, rho, x) {
  if (missing(x)) x <- rnorm(length(y)) # Optional: supply a default if `x` is not given
  y.perp <- residuals(lm(x ~ y))
  rho * sd(y.perp) * y + y.perp * sd(y) * sqrt(1 - rho^2)
}

tilapia_growth$day_30_weight = abs(complement(y = tilapia_growth$perc_soy_protein, rho = 0.68))*1500

tilapia_growth = as_tibble(tilapia_growth)
tilapia_growth$avg_tank_temp = rnorm(320, mean = 75, sd = 2)

write_csv(tilapia_growth, "../data/tilapia_growth.csv")

## edit data to have more appropriate temperature data

for (i in 1:nrow(tilapia_growth)){
  if (tilapia_growth$tank_id[i] == 1) {
    tilapia_growth$avg_tank_temp[i] =  77.2
  } else if (tilapia_growth$tank_id[i] == 2) {
    tilapia_growth$avg_tank_temp[i] = 75.9
  } else if (tilapia_growth$tank_id[i] == 3) {
    tilapia_growth$avg_tank_temp[i] = 74.8
  } else if (tilapia_growth$tank_id[i] == 4) {
    tilapia_growth$avg_tank_temp[i] = 72.4
  } else if (tilapia_growth$tank_id[i] == 5) {
    tilapia_growth$avg_tank_temp[i] = 75.2
  } else if (tilapia_growth$tank_id[i] == 6) {
    tilapia_growth$avg_tank_temp[i] = 76.0
  } else if (tilapia_growth$tank_id[i] == 7) {
    tilapia_growth$avg_tank_temp[i] = 73.9
  } else if (tilapia_growth$tank_id[i] == 9) {
    tilapia_growth$avg_tank_temp[i] = 73.1
  } else if (tilapia_growth$tank_id[i] == 10) {
    tilapia_growth$avg_tank_temp[i] = 75.2
  } else if (tilapia_growth$tank_id[i] == 11) {
    tilapia_growth$avg_tank_temp[i] = 76.4
  } else if (tilapia_growth$tank_id[i] == 12) {
    tilapia_growth$avg_tank_temp[i] = 71.9
  } else if (tilapia_growth$tank_id[i] == 13) {
    tilapia_growth$avg_tank_temp[i] = 75.9
  } else if (tilapia_growth$tank_id[i] == 14) {
    tilapia_growth$avg_tank_temp[i] = 73.2
  } else if (tilapia_growth$tank_id[i] == 15) {
    tilapia_growth$avg_tank_temp[i] = 74.7
  } else {
    tilapia_growth$avg_tank_temp[i] = 76.1
  }
}

write_csv(tilapia_growth, "../data/tilapia_growth.csv")
