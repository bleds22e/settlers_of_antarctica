# Load necessary packages
library(tidyverse)

# Set seed for reproducibility
set.seed(11)

# Number of observations
n <- 240

# Generate predictor variables with specified ranges and relationships
soil_nitrogen <- rnorm(n, mean = 20, sd = 5)         # Soil nitrogen in ppm
soil_phosphorus <- rnorm(n, mean = 5, sd = 1.5)      # Soil phosphorus in ppm
penguin_density <- rpois(n, lambda = 15)             # Average penguin density in the area
avg_summer_temp <- rnorm(n, mean = 1.5, sd = 0.1)    # Summer temperature with small variation
avg_windspeed <- rnorm(n, mean = 15, sd = 3)         # Average wind speed in km/h
soil_ph <- rnorm(n, mean = 6.5, sd = 0.4)            # Soil pH
percent_rock <- rnorm(n, mean = 30, sd = 2)          # Percent rocky soil with small variation

# Simulate hairgrass density based on selected predictors, handling NAs
hairgrass_density <- round(
  50 + 
    2 * ifelse(is.na(soil_nitrogen), 0, soil_nitrogen) + 
    3 * ifelse(is.na(soil_phosphorus), 0, soil_phosphorus) + 
    0.85 * ifelse(is.na(penguin_density), 0, penguin_density) +
    5 * (7 - soil_ph) +  # Higher density in slightly acidic conditions
    rnorm(n, mean = 0, sd = 10) # Random noise
)

# Ensure density is non-negative
hairgrass_density <- pmax(hairgrass_density, 0)

# Create the data frame
hairgrass_data <- tibble(
  soil_nitrogen = soil_nitrogen,
  soil_phosphorus = soil_phosphorus,
  penguin_density = penguin_density,
  avg_summer_tempC = avg_summer_temp,
  avg_windspeed = avg_windspeed / 1.852, # convert to knots per hour
  soil_ph = soil_ph,
  percent_rock = percent_rock,
  hairgrass_density = hairgrass_density
)

# Display the first few rows of the data
print(head(hairgrass_data))

# Summary of the dataset
summary(hairgrass_data)


# Define independent variables to iterate over
independent_vars <- c("soil_nitrogen", "soil_phosphorus", "penguin_density", 
                      "avg_summer_tempC", "avg_windspeed", "soil_ph", "percent_rock")

# Iterate through each independent variable and plot against hairgrass density
for (var in independent_vars) {
  # Create the plot
  p <- ggplot(hairgrass_data, aes_string(x = var, y = "hairgrass_density")) +
    geom_point(alpha = 0.6) +                     # Scatter plot with transparency
    geom_smooth(method = "lm", color = "blue", se = FALSE) +   # Linear smoothing line
    labs(x = var, y = "Hairgrass Density", 
         title = paste("Hairgrass Density vs", var)) +
    theme_minimal()
  
  # Print the plot
  print(p)
}

# Check correlation coefficients and R-squared values

# Initialize an empty data frame to store results
cor_results <- tibble(
  variable = character(),
  correlation_coefficient = numeric(),
  r_squared = numeric()
)

# Calculate correlation coefficient and R-squared for each independent variable
for (var in independent_vars) {
  # Calculate correlation, handling NA values with `use = "complete.obs"`
  corr <- cor(as.numeric(hairgrass_data[[var]]), hairgrass_data$hairgrass_density, use = "complete.obs")
  r_squared <- corr^2
  
  # Add the results to the data frame
  cor_results <- cor_results %>%
    add_row(variable = var, 
            correlation_coefficient = corr, 
            r_squared = r_squared)
}

# Display the results
print(cor_results)

# Reorder the data so hairgrass density is at the front
hairgrass_data <- hairgrass_data %>% 
  select(hairgrass_density, soil_nitrogen:percent_rock)

# Save the new dataframe
write_csv(hairgrass_data, "modules/module_3/data/hairgrass_data.csv")
