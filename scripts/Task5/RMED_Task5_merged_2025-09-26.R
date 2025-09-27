#Task-5 Group: Data_Freak
#Goal:
#Analyse the dataset and answer the following questions:

#Description of code parts----
##loading libraries----
install.packages("ggridges")
library(tidyverse)
library(here)
library(GGally)
library(ggridges)

##loading post-tidied data set----
data <- read_delim(here("data", "exam_data_tidier_2025-09-09.txt"), delim = " ")

###Pratik----
###Are there more positive tests in the drive-through?----
####Yes, there are more positive tests in the drive-through group both by count (479 versus 381) and proportion (3.1% versus 2.5%)
data %>%
  with(table(result, drive_thru_ind))
data %>%
  with(prop.table(table(result, drive_thru_ind)))

###Fatemeh----
###Is there a difference in the distributions of ct_results between different outcome groups (result)?----
####Boxplot – compare median and spread across groups
####Yes, ct_result values are lower in positive cases and higher in negative ones, with no data for the invalid group.
####The boxplot shows clear differences in ct_result by outcome group: positives have lower, more variable Ct values, while negatives and invalids cluster at higher, consistent levels, reflecting the expected inverse link between target amount and Ct.
ggplot(data, aes(x = result, y = ct_result, fill = result)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red") +
  labs(title = "Distribution of ct_result across outcome groups",
       x = "Outcome group (result)",
       y = "ct_result") +
  theme_minimal() +
  theme(legend.position = "none")

####Violin plot – show full distribution shape
####The violin plot shows that positive outcomes have distinctly lower and more variable Ct values, while negative and invalid groups cluster at higher, more uniform Ct values, indicating significant distribution differences across outcome groups
ggplot(data, aes(x = result, y = ct_result, fill = result)) +
  geom_violin(trim = FALSE, alpha = 0.6) +
  geom_boxplot(width = 0.2, fill = "white") +
  labs(title = "Violin plot of ct_result by outcome group",
       x = "Outcome group (result)",
       y = "ct_result") +
  theme_minimal() +
  theme(legend.position = "none")

###Sebastian----
###Is the age of the individual associated with whether the test result is negative or positive?----
####Yes, in general: the younger the person, the more likely it is for the result to be negative.
####50 % of individuals age 10 or younger have negative results. Second most distribution (ca. 25 %) age 10 - ~23. Median at age 10.
####50 % of individuals age 20 or younger have positive results. Second most distribution (ca. 25 %) age 20 - ~27. Median at age 20.
####Individuals with negative results are approx. 10 years younger than individuals with positive result.
ggplot(data, aes(x = result, y = age, fill = result)) +
  geom_violin(trim = FALSE, alpha = 0.6) +
  geom_boxplot(width = 0.2, fill = "white") +
  labs(title = "Violin plot representing the age distribution of a corona test result",
       x = "",
       y = "age") +
  theme_minimal() +
  theme(legend.position = "none")
