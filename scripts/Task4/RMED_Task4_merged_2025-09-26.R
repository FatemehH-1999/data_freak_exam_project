#Task-4 Group: Data_Freak
#Goal
Create plots that would help answer these questions

#Description of code parts----
##loading libraries----
install.packages("ggridges")
library(tidyverse)
library(here)
library(GGally)
library(ggridges)

##loading post-tidied data set----
data <- read_delim(here("data", "exam_data_tidier_2025-09-09.txt"), delim = " ")

data <- data %>% 
  select(-c(ID))

###Sebastian
###Are there any correlated measurements?----
x <- (ggcorr(
  data,
  method = c("complete.obs", "pearson"),
  name = "Legend",
  geom = "circle",
  max_size = 10,
  min_size = 1,
  nbreaks = 6,
  size = 2.5,
  hjust = 0.75,
  angle = 0,
  palette = "RdBu"
)) 
x
####Few correlations visible: 
####Strongest correlations (0,67 - 1) between pan_day & pan_week and orderset & multi_ct_result_orderset. Here, correlation is expected, since pan_week and multi_ct_result_orderset were created out of pan_day and orderset.
####weaker correlations (0,33 - 0,67) between age & pan_day, age & pan_week, age & col_rec_tat. Again, pan_day and pan_week are based on each other. 
####Rest mostly correlations between 0 - 0,33 and some between -0,33 - 0.

###Pratik----
###Does the time spent waiting for the test result improve during these 100 days that the dataset includes?----
####need to find correlation between rec_ver_tat and pan_day
####I cannot find improvement and the correlation matrix shows almost no correlation (r=0.01)
data %>%
  ggplot(aes(x = pan_day, y = rec_ver_tat)) +
  geom_point(alpha = 0.4, color = "steelblue") +     # scatterplot of points
  geom_smooth(method = "loess", se = TRUE, color = "red") +  # smooth trend line
  labs(
    title = "Change in waiting time for test results over 100 days",
    x = "Day after start of pandemic",
    y = "Waiting time (receive → verification)"
  ) +
  theme_minimal()

###Were there more females than males that took the test at a drive through?----
data %>%
  with(table(gender, drive_thru_ind))
####Yes, there were more females (n=3997) than males (n=3912)
data %>%
  filter(drive_thru_ind == 1) %>%              # keep only drive-through tests
  ggplot(aes(x = gender, fill = gender)) +     # gender on x-axis
  geom_bar() +                                 # bar plot of counts
  labs(
    title = "Drive-through tests by gender",
    x = "Gender",
    y = "Number of tests at drive thru"
  ) +
  theme_minimal() +
  theme(legend.position = "none")     # remove legend (optional)

###Fatemeh----
###Does the distribution of the `ct_result` differ with sex group?----
####Violin plot: shows full distribution shape
####The violin plot indicates that the ct_result distributions for females and males are nearly identical, showing no meaningful difference between the two sex groups
ggplot(data, aes(x = gender, y = ct_result, fill = gender)) +
  geom_violin(trim = FALSE, alpha = 0.6) +
  geom_boxplot(width = 0.1, fill = "white") +
  labs(title = "Violin plot of ct_result by gender",
       x = "gender",
       y = "ct_result") +
  theme_minimal() +
  theme(legend.position = "none")

####Density plot: both groups overlaid
####The density plot shows that the ct_result distributions for females and males almost completely overlap, showing no meaningful difference between the two sex groups
ggplot(data, aes(x = ct_result, colour = gender, fill = gender)) +
  geom_density(alpha = 0.4) +
  labs(title = "Density of ct_result by gender",
       x = "ct_result",
       y = "Density") +
  theme_minimal()

###Sebastian----
###Does the distribution of the ct_result differ with payor_group?----
####Violin plot: shows full distribution shape
ggplot(data, aes(x = payor_group, y = ct_result, fill = payor_group)) +
  geom_violin(trim = FALSE, alpha = 0.6) +
  geom_boxplot(width = 0.2, fill = "white") +
  labs(title = "Violin plot of CT results grouped by health care category",
       x = "health care",
       y = "ct result") +
  theme_minimal() +
  theme(legend.position = "none") +
  ylim(0, 50)

####Ridgeline chart: shows density distribution for all groups
ggplot(data, aes(y = payor_group, x = ct_result, fill = payor_group, height = after_stat(density))) +
  geom_density_ridges(scale = 2, stat = "density") +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_x_continuous(expand = c(0.01, 0)) +
  theme_ridges() +
  labs(title = "Ridgeline chart of CT results grouped by health care category",
       x = "ct results",
       y = "") +
  theme(legend.position = "none") +
  xlim(15, 50)
####All groups share the largest distribution at ct_result = 45, with "commercial" having the most results at 45.
####"Government" and "medical assistance" have second highest number at 45. Rest groups approx. same number.
####Some outlier in all groups, with "commercial", "government" and "NA" having the most. Least outliers are in group "charity care" and "other", "medical assistnance".