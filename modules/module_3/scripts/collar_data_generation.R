# Script to create seal collar data
# Keaton Wilson
# keatonwilson@me.com
# 2020-01-23 

# packages
library(tidyverse)

# The basic idea here is to create a dataframe on 100 collars, from two 
# different manufacturers, with two columns of data: battery life (how long it
# lasts) and signal distance (how far it reads before it won't respond). A 
# trade-off here - one brand probably has longer battery life and one has a 
# longer signalling distance. Also a column for failure (i.e. a collar was 
# noted or collected by fishing teams on a leopard seal that posed a threat, 
# but didn't ping on their instruments).

collars <- tibble(collar_id = seq(1:100), 
                  maker = c(rep("Collarium Inc.", 47), 
                            rep("Budget Collars LLC", 53)), 
                  battery_life = c(rnorm(n = 47, mean = 120, sd =10), 
                                   rnorm(n = 53, mean = 86, sd = 10)), 
                  signal_distance = c(rnorm(n = 47, mean = 4200, sd = 35),
                                      rnorm(n = 53, mean = 4300, sd = 35)), 
                  fail = c(rbinom(n = 47, size = 1, prob = 0.07), 
                           rbinom(n = 53, size = 1, prob = 0.3)))

# Checking

collars %>% 
  group_by(maker) %>%
  summarize(mean_fail = mean(fail))

ggplot(collars, aes(x = signal_distance, y = battery_life, col = maker)) +
  geom_point()

#writing to csv
write_csv(collars, "./modules/module_3/data/collar_data.csv")


## Add a new collar company to the existing data

collars <- read_csv("./modules/module_3/data/collar_data.csv")
collars_new <- tibble(collar_id = seq(1:50) + 100, 
                      maker = rep("Darn Tuff Collars Company", 50), 
                      battery_life = rnorm(n = 50, mean = 120, sd = 10), 
                      signal_distance = rnorm(n = 50, mean = 4175, sd = 35),
                      fail = rbinom(n = 50, size = 1, prob = 0.01))

collars <- bind_rows(collars, collars_new)

# test the new data out
anova_battery <- aov(data = collars, battery_life ~ maker)
summary(anova_battery)
TukeyHSD(anova_battery)

anova_signal <- aov(data = collars, signal_distance ~ maker)
summary(anova_signal)
TukeyHSD(anova_signal)

write_csv(collars, "modules/module_3/data/more_collars.csv")
