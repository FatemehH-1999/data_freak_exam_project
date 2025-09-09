#loading libraries
library(tidyverse)
library(here)

#loading post-tidied data set
data1 <- read_delim(here("data", "exam_data_tidy1.txt"), delim = " ")

#looking at data set
glimpse(data1)

#Remove unnecessary columns from your dataframe: row, test_id, demo_group.
#removing 3 columns from data set: "row", "test_id", "demo_group"
data1_dummy <- data1 %>% 
  select(-c(row, test_id, demo_group))

####Pratik's part







####End of Pratik's part

#Make necessary changes in variable types.
#changing type of column "ID" and "age" to numeric instead of character
data1_dummy$ID <- as.numeric(data1_dummy$ID)
data1_dummy$age <- as.numeric(data1_dummy$age)

#Create a set of new columns: (each member of the group chooses one column)
#A column showing drive_thru_ind as Yes/No
data1_dummy <- data1_dummy %>% 
  mutate(drive_thru_ind = if_else(drive_thru_ind == TRUE, "Yes","No"))
  
#Set the order of columns as: id, age, gender and other columns
data1_dummy <- data1_dummy %>% 
  select("ID", "age", "gender", everything())

#Arrange ID column of your dataset in order of increasing number or alphabetically.
data1_dummy <- data1_dummy %>% 
  arrange(ID)


