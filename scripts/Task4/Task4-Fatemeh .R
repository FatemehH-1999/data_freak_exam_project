#Task4_Fatemeh 
#Create plots that would help answer these questions:
##Does the distribution of the ct_result differ with sex group? 

##Loading libraries
library(tidyverse)
library(here)

##Loading tidied dataset
data <- read_delim(here("data", "exam_data_tidier_2025-09-09.txt"), delim = " ")
data


# Violin plot: shows full distribution shape
##The violin plot indicates that the ct_result distributions for females and males are nearly identical, showing no meaningful difference between the two sex groups
ggplot(data, aes(x = gender, y = ct_result, fill = gender)) +
  geom_violin(trim = FALSE, alpha = 0.6) +
  geom_boxplot(width = 0.1, fill = "white") +
  labs(title = "Violin plot of ct_result by gender",
       x = "gender",
       y = "ct_result") +
  theme_minimal() +
  theme(legend.position = "none")

# Density plot: both groups overlaid
##The density plot shows that the ct_result distributions for females and males almost completely overlap
ggplot(data, aes(x = ct_result, colour = gender, fill = gender)) +
  geom_density(alpha = 0.4) +
  labs(title = "Density of ct_result by gender",
       x = "ct_result",
       y = "Density") +
  theme_minimal()

