#Description of parts----
#loading libraries
library(tidyverse)
library(here)

#loading post-tidied data set
data <- read_delim(here("data", "exam_data_tidy1.txt"), delim = " ")
data_join <- read_delim(here("data", "exam_data_join.txt"), delim = "\t")


#looking at data set
glimpse(data)

#Make necessary changes in variable types.
#changing type of column "ID" and "age" to numeric instead of character
data$ID <- as.numeric(data$ID)
data$age <- as.numeric(data$age)

#A column showing whether rec_ver_tat is higher than 100 or not: values High/Low.
data <- data %>%
  distinct() %>% 
  pivot_wider(
    names_from = time_measurement, 
    values_from = value)

data <- data %>%
  mutate(rec_ver_tat_level = if_else(rec_ver_tat <= 100, "Low", "High"))

#Remove unnecessary columns from your dataframe: row, test_id, demo_group.
#removing 3 columns from data set: "row", "test_id", "demo_group"
data <- data %>% 
  select(-c(row, test_id, demo_group))

#Create a set of new columns: (each member of the group chooses one column)
##A numeric column showing pan_day in weeks
data <- 
  data %>%
  mutate(pan_week = pan_day/7)

##A column showing drive_thru_ind as Yes/No
data <- data %>% 
  mutate(drive_thru_ind = if_else(drive_thru_ind == TRUE, "Yes","No"))

##A numeric column showing multiplication of ct_result and orderset for each person
data <-
  data %>%
  mutate(multi_ct_result_orderset = ct_result*orderset) %>%
  drop_na(multi_ct_result_orderset)

#Set the order of columns as: id, age, gender and other columns
data <- data %>% 
  select("ID", "age", "gender", everything())

#Arrange ID column of your dataset in order of increasing number or alphabetically.
data <- data %>% 
  arrange(ID)

#Executable script----
library(tidyverse)
library(here)

data <- read_delim(here("data", "exam_data_tidy1.txt"), delim = " ") %>% 
  mutate(ID = as.numeric(ID), age = as.numeric(age)) %>% 
  distinct() %>% 
  pivot_wider(names_from = time_measurement, values_from = value) %>% 
  mutate(rec_ver_tat_level = if_else(rec_ver_tat <= 100, "Low", "High")) %>% 
  select(-c(row, test_id, demo_group)) %>% 
  mutate(pan_week = pan_day/7) %>% 
  mutate(drive_thru_ind = if_else(drive_thru_ind == TRUE, "Yes","No")) %>% 
  mutate(multi_ct_result_orderset = ct_result*orderset) %>%
  drop_na(multi_ct_result_orderset) %>% 
  select("ID", "age", "gender", everything()) %>%
  arrange(ID) %>% 
  write_delim(here("data", "exam_data_tidier.txt"), delim = " ")
#End of script----


  



