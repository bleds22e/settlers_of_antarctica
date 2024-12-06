# Simulate data
set.seed(42)
library(tidyverse)

# Parameters
time <- seq(0, 20, by = 1)
r_exp <- 0.3   # Growth rate for exponential growth
r_log <- 0.4   # Growth rate for logistic growth
K <- 1000      # Carrying capacity for logistic growth

# Exponential growth data
exp_population <- 100 * exp(r_exp * time) + rnorm(length(time), sd = 50)

# Logistic growth data
log_population <- K / (1 + ((K - 100) / 100) * exp(-r_log * time)) + rnorm(length(time), sd = 50)

# Combine into a data frame
fish_data <- tibble(
  year = rep(time, 2),
  population = c(exp_population, log_population),
  growth_type = rep(c("Exponential", "Logistic"), each = length(time))
)

# Save dataset
write_csv(fish_data, "modules/module_4_fall2024/data/fish_population_growth.csv")
