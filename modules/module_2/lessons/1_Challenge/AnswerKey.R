# Answer Key for Module2_1_Challenge

hist(x = sick$age, col = "lightblue", labels = TRUE, main = NULL,
     xlab = "Age of Crew Members", ylab = "Frequency", ylim = c(0,100))
abline(v = mean(sick$age), col = "black")

plot(x = sick$doctor_trips, y = sick$perc_fish,
     xlab = "Number of Doctor Visits", ylab = "Percent Fish in Diet",
     pch = 23, col = "green", bg = "black")

