# Antarctica Station Data
# Keaton Wilson
# keatonwilson@me.com
# 2019-11-7
# EKB edits, July 2022

# packages
library(tidyverse)

# aggregate weather data from all stations

all_station_data <- data.frame()

files <- list.files("./modules/module_1/data/raw_antarctica_station_data/", 
                   full.names = TRUE)

for(i in 1:length(files)) {
  
  temp <- read_table(files[i], 
                    skip = 2, 
                    col_names = c("year", "day", "month", 
                                  "running_day", "hour", 
                                  "temp", "pressure", 
                                  "wind_speed", "wind_direction", 
                                  "humidity", "delta_t"))
  
  temp <- temp %>%
    mutate_if(is.character, as.numeric) %>%
    mutate(station_id = str_remove(str_sub(files[i], start = -16), 
                                   pattern = ".txt"))
  
  all_station_data <- bind_rows(all_station_data, temp)
  
}

# replace 444 and 444.0 with NA
all_station_data <- all_station_data %>% 
  mutate(across(where(is.double), ~na_if(., c(444))))


write_csv(all_station_data, "./modules/module_1/data/aggregated_station_data.csv")
