#started on 10.09.25 -  ----
#loading libraries
install.packages("ggridges")
library(tidyverse)
library(here)
library(GGally)
library(ggridges)

#loading post-tidied data set
data1 <- read_delim(here("data", "exam_data_tidier_2025-09-09.txt"), delim = " ")

data1 <- data1 %>% 
  select(-c(ID))

#Are there any correlated measurements?----
x <- (ggcorr(
  data1,
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

#Few correlations visible: 
#Strongest correlations (0,67 - 1) between pan_day & pan_week and orderset & multi_ct_result_orderset. Here, correlation is expected, since pan_week and multi_ct_result_orderset were created out of pan_day and orderset.
#weaker correlations (0,33 - 0,67) between age & pan_day, age & pan_week, age & col_rec_tat. Again, pan_day and pan_week are based on each other. 
#Rest mostly correlations between 0 - 0,33 and some between -0,33 - 0.

#Does the distribution of the ct_result differ with payor_group?
# Violin plot: shows full distribution shape
ggplot(data1, aes(x = payor_group, y = ct_result)) +
  geom_violin(trim = FALSE, alpha = 0.6) +
  geom_boxplot(width = 0.2, fill = "white") +
  labs(title = "Violin plot of CT results grouped by health care category",
       x = "health care",
       y = "ct result") +
  theme_minimal() +
  theme(legend.position = "none") +
  ylim(0, 50)

#Ridgeline chart: shows density distribution for all groups
ggplot(data1, aes(y = payor_group, x = ct_result, fill = payor_group, height = after_stat(density))) +
  geom_density_ridges(scale = 2, stat = "density") +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_x_continuous(expand = c(0.01, 0)) +
  theme_ridges() +
  xlim(0, 50)

#All groups share the largest distribution at ct_result = 45, with "commercial" having the most results at 45.
#"Government" and "medical assistance" have second highest number at 45. Rest groups approx. same number.
#Some outlier in all groups, with "commercial", "government" and "NA" having the most. Least outliers are in group "charity care" and "other", "medical assistnance".
