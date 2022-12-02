# Non-Vascular Plant Data Generation for Multiple Regression

# percent plant cover is dependent variable
# plant type is additional independent variable

nonvascular <-  tibble(site = rep(1:200),
                       plant_type = c(rep("moss", 100), rep("liverwort", 100)), 
                       percent_plant_cover = c(rnorm(33, 40, 5), rnorm(34, 60, 5), rnorm(33, 80, 5),
                                               rnorm(33, 60, 5), rnorm(34, 40, 5), rnorm(33, 20, 5)),
                       penguin_density_m2 = c(abs(rnorm(50, 1.5, 0.5)), rnorm(50, 2.5, 0.5),
                                              abs(rnorm(50, 1.5, 0.5)), rnorm(50, 2.5, 0.5)))

ggplot(nonvascular, aes(penguin_density_m2, percent_plant_cover)) +
  geom_point() +
  geom_smooth(method = "lm")

summary(lm(data = nonvascular, percent_plant_cover ~ penguin_density_m2))

ggplot(nonvascular, aes(penguin_density_m2, percent_plant_cover, color = plant_type)) +
  geom_point() +
  geom_smooth(method = "lm")

summary(lm(data = nonvascular, percent_plant_cover ~ penguin_density_m2 * plant_type))

write_csv(nonvascular, "modules/module_4/data/nonvascular_plants.csv")
