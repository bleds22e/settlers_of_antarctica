set.seed(123)  # for reproducibility

# Logistic function
logistic_fun <- function(t, K, r, N0) {
  K / (1 + ((K - N0) / N0) * exp(-r * t))
}

years <- 0:25

# Common parameters
r  <- 0.7
N0_1000 <- 0.05 * 1000  # 5% of K
N0_800  <- 0.05 * 800   # 5% of K

## 1) K ~ 1000, little variation near asymptote
K1 <- 1000
true_N1 <- logistic_fun(years, K = 1025, r = r, N0 = 40)

# Small noise that shrinks as we get close to K
# sd1 <- 50 * (1 - true_N1 / 1000)  # near K, sd ~ 0
obs_N1 <- true_N1 + rnorm(length(years), mean = 0, sd = 20)
obs_N1 <- pmax(obs_N1, 0)       # avoid negative counts

dat1 <- data.frame(
  year = years,
  true_N = true_N1,
  obs_N = obs_N1,
  dataset = "K=1000_low_var"
)

plot(dat1$obs_N)
plot(dat1$true_N)

## 2) K ~ 1000, LOTS of variation around asymptote
K2 <- 1000
true_N2 <- logistic_fun(years, K = 980, r = r, N0 = 40)

# Larger noise, especially at/after ~year 8
sd2 <- ifelse(years >= 8, 200, 30)
obs_N2 <- true_N2 + rnorm(length(years), mean = 0, sd = sd2)
obs_N2 <- pmax(obs_N2, 0)

dat2 <- data.frame(
  year = years,
  true_N = true_N2,
  obs_N = obs_N2,
  dataset = "K=1000_high_var"
)

plot(dat2$obs_N)

## 3) K ~ 800, little variation near asymptote
K3 <- 800
true_N3 <- logistic_fun(years, K = K3, r = r, N0 = 32)

#sd3 <- 20 * (1 - true_N3 / K3)
obs_N3 <- true_N3 + rnorm(length(years), mean = 0, sd = 30)
obs_N3 <- pmax(obs_N3, 0)

dat3 <- data.frame(
  year = years,
  true_N = true_N3,
  obs_N = obs_N3,
  dataset = "K=800_low_var"
)

## Optional: combine into one long data frame (nice for ggplot)
sim_data <- rbind(dat1, dat2, dat3)

# Example quick check plot (optional)
library(tidyverse)
library(drc)

ggplot(sim_data, aes(x = year, y = obs_N, color = dataset)) +
  geom_point() +
  geom_line(aes(y = true_N), linetype = "dashed") +
  theme_minimal()

mod1 <- drc::drm(obs_N ~ year, data = dat1, fct = LL.4())
mod1

mod2 <- drc::drm(obs_N ~ year, data = dat2, fct = LL.4())
mod2

mod3 <- drc::drm(obs_N ~ year, data = dat3, fct = LL.4())
mod3

ggplot(sim_data, aes(x = year, y = obs_N, color = dataset)) +
  geom_point() +
  geom_line(aes(y = true_N), linetype = "dashed") +
  theme_minimal()

dat1 |> 
  mutate(fitted_model = predict(mod1))

dat1_10 <- filter(dat1, year > 10)
dat2_10 <- filter(dat2, year > 10)
dat3_10 <- filter(dat3, year > 10)

sim_data_10 <- rbind(dat1_10, dat2_10, dat3_10)

sim_data_10 |> 
  filter(dataset != "K=800_low_var") |> 
  t.test(obs_N ~ dataset, data = _)

sim_data_10 |> 
  aov(obs_N ~ dataset, data = _) |> 
  summary()

sim_data_10 |> 
  aov(obs_N ~ dataset, data = _) |> 
  TukeyHSD()

# sim_data <- read_csv("modules/module_4_fall2024/data/comparing_populations.csv")
# sim_data <- sim_data |> 
#   dplyr::select(year, abund = obs_N, population = dataset) |> 
#   mutate(population = case_when(population == "K=1000_low_var" ~ "NE",
#                                 population == "K=1000_high_var" ~ "SE",
#                                 population == "K=800_low_var" ~ "SW"),
#          abund = round(abund))
write_csv(sim_data, "modules/module_4_fall2024/data/comparing_populations.csv")
