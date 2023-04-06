# Generating tussock density data for linear regressions
# Keaton Wilson, modified by Mila Pruiett
# keatonwilson@me.com and ameliapruiett@clark.edu
# 2022-11-07

# packages
library(tidyverse)
library(truncnorm)
#library(faux)
library(MASS)
library(GGally)
library(Matrix)

# each row is data from a single site, all in one year
# varialbes- density, soil pH, nitrogen %, phosphorous %, 
# penguins within 100m sq, mean summer emp, mean winter temp, % soil rocks, max windspeed, avg UV index

# Major patterns in data:
# 1. Tussock density is positively correlated with temperature, penguin density, and nitrogen %
# 2. Tussock density is not correlated with any of the other variables


grass_data <- tibble(date =sort(rep(seq(as.Date("2021-03-01"), as.Date("2021-04-01"), by="days"), 15.5)), 
                                  location_ID = seq(from = 1, to = 480, by = 1),
                                  soil_pH = signif(rtruncnorm(n = 480, a = 0, mean = 5.5, sd = 1.3), digits = 3),
                                  p_content = signif(rtruncnorm(n = 480, a = 0, mean = 4, sd = 3.4), digits = 3),
                                  percent_soil_rock = signif(rtruncnorm(n = 480, mean = 65, sd = 20), digits = 3), 
                                  max_windspeed_knots = signif(rtruncnorm(n = 480, a= 0, mean = 12, sd = 10), digits = 4),
                                  avg_uv_index = round(rtruncnorm(n = 480, mean = 2, sd = 1)), 
                       
)



# makes it so that we always generate the same random bits if the number in
# set.set is the same each time
set.seed(8)

# create the variance covariance matrix
covMat <-rbind(c(1, 0.7, 1, 1, 0.7),
             c(0.7, 1, 0.5, 0.4, 0.1),
             c(1, 0.5, 1, 0.3, 0.12),
             c(1, 0.4, 0.3, 1, 0.9),
             c(0.7, 0.1, 0.12, 0.9, 1)) 

# get the nearest positive definite matrix for those numbers
nearPDforCov <- Matrix::nearPD(covMat, ensureSymmetry = T, keepDiag =T)

# extract the matrix from the pd fxn
sigmaVector <- nearPDforCov[["mat"]]@x

# transform that matrix (given as a vector) to a dataframe
sigma <- data.frame(split(sigmaVector, 
               cut(seq_along(sigmaVector),
                             5,
                             labels = F)))
  
# create the mean vector
mu<-c(8, 15, -3, 6, 10)

# generate the multivariate normal distribution
df<-as.data.frame(MASS::mvrnorm(n=480, mu=mu, Sigma=sigma))

# View the data to make sure it has the correlations we want
ggpairs(df)

# name the data frame's columns
df <- df %>% 
  rename(hairgrass_density = 1, 
         avg_summer_temp = 2,
         avg_winter_temp = 3, 
         penguin_density_within_100m = 4,
         n_content = 5)

# combine the correlated data with the uncorrelated data
hairgrass_data <- cbind(grass_data, df)

# sensibly round the numbers
hairgrass_data <- hairgrass_data %>% 
  mutate_at(c("avg_summer_temp", "avg_winter_temp", "n_content"), round, 1) %>% 
  mutate(hairgrass_density_m2 = round(hairgrass_density, 1),
         penguin_density_5m2 = round(penguin_density_within_100m, 1))

# remove uncessary rows
hairgrass_data <- hairgrass_data %>% 
  dplyr::select(-date, -hairgrass_density, -avg_winter_temp, -penguin_density_within_100m)

# write to a csv
write_csv(hairgrass_data, "modules/module_4/hairgrass_data.csv")



# check it out
hairgrass_data %>% ggplot(aes(x = hairgrass_density_per_m2, y = avg_summer_temp)) +
  geom_jitter() + 
  geom_smooth(method = "lm")

hairgrass_data %>% ggplot(aes(x = hairgrass_density_per_m2, y = n_content)) +
  geom_point() +
  geom_smooth(method = "lm")

summary(lm(hairgrass_density_per_m2 ~ avg_summer_temp + avg_winter_temp + 
             n_content + p_content + soil_pH + max_windspeed_knots +
             penguin_density_per_5m2_within_100_m +
             percent_soil_rock +
             avg_uv_index, data = hairgrass_data))

lm(data = hairgrass_data, formula = hairgrass_density_per_m2 ~ avg_uv_index)
