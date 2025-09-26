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

#Quesiton 5
#Are there more positive tests in the drive-through?
merged_data %>%
  with(table(result, drive_thru_ind))
merged_data %>%
  with(prop.table(table(result, drive_thru_ind)))

#Yes, there are more positive tests in the drive-through group both by count (479 versus 386) and proportion (3.1% versus 2.5%)
