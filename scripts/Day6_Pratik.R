#Day6 
library(tidyverse)
library(here)
#Read the .txt file from the folder
exam_data_tidy <- read_delim(here("data", "exam_data_tidy.txt"), delim = "\t")
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
