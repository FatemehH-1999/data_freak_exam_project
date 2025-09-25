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
#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column
#Only for persons with patient_class == inpatient
merged_data %>%
  filter(patient_class == "inpatient") %>% 
  group_by(gender) %>%
  summarise(
    min_value  = min(pan_day,na.rm = TRUE),
    max_value  = max(pan_day,na.rm = TRUE),
    mean_value = mean(pan_day,na.rm = TRUE),
    sd_value   = sd(pan_day,na.rm = TRUE),
    .groups = "drop"
)
#Use two categorical columns in your dataset to create a table (either with table(), count(), or janitor::tabyl())
merged_data %>%
  with(table(gender, rec_ver_tat_level))
