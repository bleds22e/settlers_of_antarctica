# Tank generation data script (for module 2)
# Keaton Wilson
# keatonwilson@me.com
# 2020-01-01

# packages
library(tidyverse)
library(truncnorm)

# generating tank data frame
fish_tanks <- tibble(tank_id = c(1:1000), 
               species = c(rep("tilapia", 750), rep("trout", 250))) %>%
  mutate(avg_daily_temp = ifelse(species == "tilapia", 
                                 rnorm(n = 750, mean = 23.89, sd = 0.5), 
                                 rnorm(n = 250, mean = 15, sd = 0.5)), 
        num_fish = ifelse(species == "tilapia", 
                                 round(rnorm(n = 750, mean = 100, sd = 3)), 
                                 round(rnorm(n = 250, mean = 75, sd = 8))), 
        day_length = ifelse(species == "tilapia", 
                          round(rnorm(n = 750, mean = 10, sd = 1)), 
                          round(rnorm(n = 250, mean = 12, sd = 1))), 
        tank_volume = ifelse(species == "tilapia", 
                          (rnorm(n = 750, mean = 400, sd = 0.8)), 
                          (rnorm(n = 250, mean = 400, sd = 0.8))),
        num_sick = ifelse(species == "tilapia",
                          round(rtruncnorm(750, a = 0, mean = 2, sd = 5)),
                          round(rtruncnorm(250, a = 0, mean = 10, sd = 5))))

fish_sick <- fish_tanks %>%
  sample_n(50, weight = factor(species))
  
# Looking at data
fish_tanks %>%
  ggplot(aes(x = num_sick, fill = factor(species))) +
  geom_histogram(binwidth = 1)

# for THIS specific iteration of sick_fish (Spring 2023)
sick_fish <- sick_fish %>% 
  mutate(density = num_sick/num_fish, 
         num_sick = if_else(species == "tilapia" & density > 0.075, 0,
                           if_else(species == "trout", num_sick + 2, num_sick)),
         avg_daily_temp = if_else(species == "trout" & density < 0.08, 13.8, avg_daily_temp),
         day_length = if_else(density < 0.2 & density > 0.19, 13, day_length)) %>% 
  select(-density)

# writing to csv
write_csv(fish_tanks %>% 
            select(-num_sick), "./modules/module_2/data/fish_tank_data.csv")
write_csv(sick_fish, "./modules/module_2/data/fish_sick_data.csv")
# 
# Note, be careful overwriting this - I cherrypicked high density tanks with 
# high infection rates... if you re-run and re-write the csv file here, you'll 
# lose those modifications and have to go back in to make them again. 

