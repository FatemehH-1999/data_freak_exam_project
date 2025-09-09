#loading libraries
library(tidyverse)
library(here)

#loading post-tidied data set
data <- read_delim(here("data", "exam_data_tidy1.txt"), delim = " ")

#looking at data set
glimpse(data)
data1_dummy <- data

#Make necessary changes in variable types.
#changing type of column "ID" and "age" to numeric instead of character
data1_dummy$ID <- as.numeric(data1_dummy$ID)
data1_dummy$age <- as.numeric(data1_dummy$age)

#A column showing whether rec_ver_tat is higher than 100 or not: values High/Low.
data1_dummy <- data1_dummy %>%
  distinct() %>% 
  pivot_wider(
    names_from = time_measurement, 
    values_from = value)

data1_dummy <- data1_dummy %>%
  mutate(rec_ver_tat_level = if_else(rec_ver_tat <= 100, "Low", "High"))

#Remove unnecessary columns from your dataframe: row, test_id, demo_group.
#removing 3 columns from data set: "row", "test_id", "demo_group"
data1_dummy <- data1_dummy %>% 
  select(-c(row, test_id, demo_group))

#Create a set of new columns: (each member of the group chooses one column)
#A column showing drive_thru_ind as Yes/No
data1_dummy <- data1_dummy %>% 
  mutate(drive_thru_ind = if_else(drive_thru_ind == TRUE, "Yes","No"))

#A numeric column showing multiplication of ct_result and orderset for each person


#Set the order of columns as: id, age, gender and other columns
data1_dummy <- data1_dummy %>% 
  select("ID", "age", "gender", everything())

#Arrange ID column of your dataset in order of increasing number or alphabetically.
data1_dummy <- data1_dummy %>% 
  arrange(ID)


