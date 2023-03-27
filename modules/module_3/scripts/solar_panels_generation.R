# Script for Generating Solar Panel Data 
# For an assignment using both t-tests and ANOVAs

library(tidyverse)
library(truncnorm)

solar_panels <- data.frame(panel_id = seq(1:250),
                           maker = c(rep("Solar Gain", 50), 
                                     rep("Sunny Side Up", 50),
                                     rep("Panel du Soliel", 50),
                                     rep("Function in the Sun", 50),
                                     rep("Bright Future", 50)), 
                           direction = c(rep("North", 100),
                                         rep("South", 150)),
                           watts_per_hour = c(rtruncnorm(n = 50, mean = 307, sd = 5, a = 0),
                                              rtruncnorm(n = 50, mean = 325, sd = 25, a = 0),
                                              rtruncnorm(n = 50, mean = 307, sd = 25, a = 0),
                                              rtruncnorm(n = 50, mean = 320, sd = 10, a = 0),
                                              rtruncnorm(n = 50, mean = 304, sd = 25, a = 0)))


# test the data
north <- filter(solar_panels, direction == "North")
south <- filter(solar_panels, direction == "South")

# summary values
north_summary <- north %>% 
  group_by(maker) %>% 
  summarise(mean = mean(watts_per_hour))
print(north_summary) # <- "Sunny Side Up" is higher (~321 wph)

south_summary <- south %>% 
  group_by(maker) %>% 
  summarise(mean = mean(watts_per_hour))
print(south_summary) # <- "Function in the Sun" is higher (~317 wph)


# t test for north
t.test(watts_per_hour ~ maker, data = north)

# ANOVA for south
summary(aov(watts_per_hour ~ maker, data = south))
TukeyHSD(aov(watts_per_hour ~ maker, data = south))

write_csv(solar_panels, "modules/module_3/data/solar_panels.csv")

# final test

final_panels <- data.frame(panel_id = seq(1:100),
                           maker = c(rep("Sunny Side Up", 50),
                                     rep("Function in the Sun", 50)), 
                           direction = c(rep("North", 100)),
                           watts_per_hour = c(rtruncnorm(n = 50, mean = 325, sd = 25, a = 0),
                                              rtruncnorm(n = 50, mean = 320, sd = 10, a = 0)))

t.test(watts_per_hour ~ maker, data = final_panels)

write_csv(final_panels, "modules/module_3/data/final_solar.csv")
