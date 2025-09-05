#day5_postlunch
#workingtogether
library(tidyverse)

# Read the .txt file from the data folder
exam_data_join <- read_delim(here("data", "exam_data_join.txt"), delim = "\t")
spec(exam_data_join)
glimpse(exam_data_join)
skimr::skim(exam_data_join)
#are there  only unique observations in the data?
length(unique(exam_data_join$id))

# Get all column names
col_names <- colnames(exam_data_join)

# Check for columns with values containing common delimiters
combined_vars <- exam_data_join %>%
  summarise(across(everything(), ~ any(grepl("[,;/|]", .)))) %>%
  pivot_longer(everything(), names_to = "column", values_to = "has_combined_values") %>%
  filter(has_combined_values)

# Read the .txt file from the data folder
exam_data <- read_delim(here("data", "exam_data.txt"), delim = "\t")
spec(exam_data)
glimpse(exam_data)
skimr::skim(exam_data)



#are there  only unique observations in the data?
#I do not know at the moment as the id is combined with first name and family name but let me check

length(unique(exam_data$subject))
#there are duplications as it shows 12344 observations

# Get all column names
col_names <- colnames(exam_data)

# Check for columns with values containing common delimiters
combined_vars <- exam_data %>%
  summarise(across(everything(), ~ any(grepl("[,;/|]", .)))) %>%
  pivot_longer(everything(), names_to = "column", values_to = "has_combined_values") %>%
  filter(has_combined_values)

#Question5 checking variable type
#In subject,we need to delimit ID, first name and family name
#gender and age need to be delimited, age is numeric, gender is character
#clinic name has values in 'numeric combined with character' or 'character', need to make it uniform
#in result, the values are in character, positive, negative, and invalid
#In demogroup, values are in character, patient, client, and unindentified
#variable 'driv_thru_ind' is not understandable unless defined, the values are numeric, either 0 or 1, the same with orderset
#variable 'ct_result' is in numberic but values either are whole number or in decimal points, need to check for consitency
#payor group has values in integer, unassigned and charity care
#patient class has integer
#pan day is numeric
#1_test_id, either covid or xcvd1
#variable called 'row', looks like there are two tests for an individual 
#could not understand .value, values are numberic, one value has negative while there are some zero values
#
