# Module 4 Assignment 3 Data Generation
# December 2025

set.seed(123)  # for reproducibility

# Logistic function
logistic_fun <- function(t, K, r, N0) {
  K / (1 + ((K - N0) / N0) * exp(-r * t))
}

years <- 0:49

# Common parameters
r  <- 0.42

## 1) K ~ 1000, little variation near asymptote
true_N1 <- logistic_fun(years, K = 390, r = r, N0 = 10)

# Small noise that shrinks as we get close to K
# sd1 <- 50 * (1 - true_N1 / 1000)  # near K, sd ~ 0
obs_N1 <- true_N1 + rnorm(length(years), mean = 0, sd = 50)
obs_N1 <- pmax(obs_N1, 0)       # avoid negative counts

pat <- data.frame(
  year = years + 1975,
  true_N = true_N1,
  obs_N = obs_N1,
  population = "Patagonian"
)

plot(pat$obs_N)
plot(dat1$true_N)

## 2) K ~ 1000, LOTS of variation around asymptote
true_N2 <- logistic_fun(years, K = 407, r = r, N0 = 15)

# Larger noise, especially at/after ~year 8
sd2 <- ifelse(years >= 10, 100, 30)
obs_N2 <- true_N2 + rnorm(length(years), mean = 0, sd = sd2)
obs_N2 <- pmax(obs_N2, 0)

ant <- data.frame(
  year = years + 1975,
  true_N = true_N2,
  obs_N = obs_N2,
  population = "Antarctic"
)

plot(ant$obs_N)

## Optional: combine into one long data frame (nice for ggplot)
sim_data <- rbind(pat, ant)

# Example quick check plot (optional)
library(tidyverse)
library(drc)

ggplot(sim_data, aes(x = year, y = obs_N, color = population)) +
  geom_point() +
  geom_line(aes(y = true_N), linetype = "dashed") +
  theme_minimal()

mod1 <- drc::drm(obs_N ~ year, data = pat, fct = LL.4())
mod1

mod2 <- drc::drm(obs_N ~ year, data = ant, fct = LL.4())
mod2

pat_1995 <- filter(pat, year > 1995)
ant_1995 <- filter(ant, year > 1995)

sim_data_1995 <- rbind(pat_1995, ant_1995)

sim_data_1995 |> 
  t.test(obs_N ~ population, data = _)

sim_data <- sim_data |>
  dplyr::select(species = population, fish_kg = obs_N, date = year) |>
  mutate(fish_kg = round(fish_kg))
#write_csv(sim_data, "modules/module_4_fall2024/data/toothfish.csv")
