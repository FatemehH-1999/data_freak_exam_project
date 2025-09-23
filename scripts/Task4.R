#Task4_Fatemeh 
#Create plots that would help answer these questions:
##Does the distribution of the ct_result differ with sex group? 
library(tidyverse)
library(here)

data <- read_delim(here("data", "20250917-tidy-exam-data.txt"), delim = "\t")
data

ggplot(data, aes(x = age, y = ct_result, fill = age)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red") +
  labs(title = "Distribution of ct_result by age",
       x = "age",
       y = "ct_result") +
  theme_minimal() +
  theme(legend.position = "none")
ggplot(data1, aes(x = sex, y = ct_result)) +
  geom_boxplot()
