#Task4_Fatemeh 
#Create plots that would help answer these questions:
##Does the distribution of the ct_result differ with sex group? 
library(tidyverse)
library(here)

data <- read_delim(here("data", "exam_data_tidier_2025-09-09.txt"), delim = " ")
data

# Boxplot: compares medians & spread
ggplot(data, aes(x = gender, y = ct_result, fill = gender)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red") +
  labs(title = "Distribution of ct_result by gender",
       x = "gender",
       y = "ct_result") +
  theme_minimal() +
  theme(legend.position = "none")

# Violin plot: shows full distribution shape
ggplot(data, aes(x = gender, y = ct_result, fill = gender)) +
  geom_violin(trim = FALSE, alpha = 0.6) +
  geom_boxplot(width = 0.1, fill = "white") +
  labs(title = "Violin plot of ct_result by gender",
       x = "gender",
       y = "ct_result") +
  theme_minimal() +
  theme(legend.position = "none")

# Density plot: both groups overlaid
ggplot(data, aes(x = ct_result, colour = gender, fill = gender)) +
  geom_density(alpha = 0.4) +
  labs(title = "Density of ct_result by gender",
       x = "ct_result",
       y = "Density") +
  theme_minimal()

