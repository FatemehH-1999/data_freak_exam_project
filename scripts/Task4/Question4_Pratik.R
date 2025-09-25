#Day6 
library(tidyverse)
library(here)
#Read the .txt file from the folder
exam_data_tidy <- read_delim(here("data", "exam_data_tidy.txt"), delim = " ")
spec(exam_data_tidy)
glimpse(exam_data_tidy)
skimr::skim(exam_data_tidy)
str(df)

# Create new column
exam_data_tidy_wide <- exam_data_tidy %>%
  distinct()%>%
pivot_wider(
  names_from = time_measurement, 
  values_from = value)

exam_data_tidy_wide <- exam_data_tidy_wide %>%
  mutate(rec_ver_tat_level = if_else(rec_ver_tat <= 100, "Low", "High"))
#merging two datasets 
exam_data_merged <- left_join(
  exam_data_tidy_wide,
  exam_data_join,
  by = c("ID" = "id")
)
View(exam_data_merged)
#developing .txt file for merged data
fileName <- paste0("exam_data_merged", ".txt")
write_delim(
  exam_data_merged, 
  file = here("data", fileName),
  delim = "\t"
)
merged_data <- read_delim(here("data", "exam_data_merged.txt"))
view(merged_data)

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
