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

#Task 4 Pratik
#Question 4, creating plots
install.packages("GGally")
library(GGally)

# Select only numeric columns from your dataset
merged_data %>%
  select(where(is.numeric)) %>%
  ggcorr(
    method = c("everything", "pearson"),
    label = TRUE, 
    label_round = 2
  )
#Question 4 Does the time spent waiting for the test result improve during these 100 days that the dataset includes?
#need to find correlation between rec_ver_tat and pan_day
#I cannot find improvement and the correlation matrix shows almost no correlation (r=0.01)
merged_data %>%
  ggplot(aes(x = pan_day, y = rec_ver_tat)) +
  geom_point(alpha = 0.4, color = "steelblue") +     # scatterplot of points
  geom_smooth(method = "loess", se = TRUE, color = "red") +  # smooth trend line
  labs(
    title = "Change in waiting time for test results over 100 days",
    x = "Day after start of pandemic",
    y = "Waiting time (receive → verification)"
  ) +
  theme_minimal()

#Were there more females than males that took the test at a drive through? 
merged_data %>%
  with(table(gender, drive_thru_ind))
#Yes, there were more females (n=4035) than males (n=3952)
merged_data %>%
  filter(drive_thru_ind == 1) %>%              # keep only drive-through tests
  ggplot(aes(x = gender, fill = gender)) +     # gender on x-axis
  geom_bar() +                                 # bar plot of counts
  labs(
    title = "Drive-through tests by gender",
    x = "Gender",
    y = "Number of tests at drive thru"
  ) +
  theme_minimal() +
  theme(legend.position = "none")              # remove legend (optional)

