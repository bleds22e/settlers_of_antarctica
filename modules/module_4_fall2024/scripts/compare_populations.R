# Load packages
library(tidyverse)

# Load data
fish_data <- read_csv("modules/module_4_fall2024/data/fish_population_growth.csv")

# 1. Summary Statistics
fish_data %>%
  group_by(growth_type) %>%
  summarize(
    mean_population = mean(population),
    sd_population = sd(population),
    .groups = "drop"
  )

# 2. Visualizations
# Scatter plot with trendlines
ggplot(fish_data, aes(x = year, y = population, color = growth_type)) +
  geom_point() +
  geom_line() +
  labs(title = "Fish Population Growth", x = "Year", y = "Population") +
  theme_minimal()

# 3. Model Fitting
# Fit exponential model for exponential growth data
exp_model <- nls(population ~ a * exp(b * year), 
                 data = fish_data %>% filter(growth_type == "Exponential"), 
                 start = list(a = 100, b = 0.3))

summary(exp_model)

# Fit logistic model for logistic growth data
log_model <- nls(population ~ K / (1 + ((K - a) / a) * exp(-b * year)),
                 data = fish_data %>% filter(growth_type == "Logistic"),
                 start = list(a = 100, b = 0.4, K = 1000))

summary(log_model)

# 4. Compare Growth Rates
# Perform t-test on initial growth rates (early years)
initial_growth <- fish_data %>%
  filter(year <= 5) %>%
  group_by(growth_type) %>%
  summarize(mean_growth = mean(population), .groups = "drop")

t.test(
  population ~ growth_type,
  data = fish_data %>% filter(year <= 5)
)

t.test(
  population ~ growth_type,
  data = fish_data
)

# 5. Calculate Overall Growth Rates

growth_rates <- fish_data %>%
  group_by(growth_type) %>% # Group by growth type
  arrange(year) %>% # Ensure data is sorted by year
  mutate(
    growth_rate = (population - lag(population)) / (year - lag(year)) # Change in population / Change in time
  ) %>%
  drop_na() # Remove rows where lag values are not available (first year)

# View growth rates
print(growth_rates)

# Plot growth rates over time
ggplot(growth_rates, aes(x = year, y = growth_rate, color = growth_type)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Growth Rates Over Time",
    x = "Year",
    y = "Growth Rate"
  ) +
  theme_minimal()

# 6 Calculate Intrinsic Growth Rates (r)

# Estimate carrying capacity for logistic growth (assume maximum observed population)
K_est <- fish_data %>%
  filter(growth_type == "Logistic") %>%
  summarize(K = max(population)) %>%
  pull(K)

# Calculate intrinsic growth rate (r) for each year
growth_rates_r <- fish_data %>%
  group_by(growth_type) %>% # Group by growth type
  arrange(year) %>% # Ensure data is sorted by year
  mutate(
    delta_N = population - lag(population),           # Change in population
    delta_t = year - lag(year),                       # Change in time
    r = case_when(
      growth_type == "Exponential" ~ delta_N / (lag(population) * delta_t), # Exponential growth formula
      growth_type == "Logistic" ~ delta_N / (lag(population) * delta_t * (1 - lag(population) / K_est)) # Logistic growth formula
    )
  ) %>%
  drop_na() # Remove rows where lag values are not available (first year)

# View intrinsic growth rates
print(growth_rates_r)

# Plot intrinsic growth rates over time
ggplot(growth_rates_r, aes(x = year, y = r, color = growth_type)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Intrinsic Growth Rates (r) Over Time",
    x = "Year",
    y = "Intrinsic Growth Rate (r)"
  ) +
  theme_minimal()
