#started on 26.09.25 -  ----
#loading libraries
install.packages("ggridges")
library(tidyverse)
library(here)
library(GGally)
library(ggridges)

#loading post-tidied data set
data1 <- read_delim(here("data", "exam_data_tidier_2025-09-09.txt"), delim = " ")

#Is the age of the individual associated with whether the test result is negative or positive?
ggplot(data1, aes(x = result, y = age, fill = result)) +
  geom_violin(trim = FALSE, alpha = 0.6) +
  geom_boxplot(width = 0.2, fill = "white") +
  labs(title = "Violin plot representing the age distribution of a corona test result",
       x = "",
       y = "age") +
  theme_minimal() +
  theme(legend.position = "none")
#Yes, in general: the younger the person, the more likely it is for the result to be negative.
#50 % of individuals age 10 or younger have negative results. Second most distribution (ca. 25 %) age 10 - ~23. Median at age 10.
#50 % of individuals age 20 or younger have positive results. Second most distribution (ca. 25 %) age 20 - ~27. Median at age 20.
#Individuals with negative results are approx. 10 years younger than individuals with positive result. 