#started on 08.09.25----
#loading libraries
library(tidyverse)
library(here)

#loading post-tidied data set
data1 <- read_delim(here("data", "exam_data_tidy_2025-09-08.txt"), delim = " ")
data_join <- read_delim(here("data", "exam_data_join.txt"), delim = "\t")
data1_dummy <- data1

#looking at data set
glimpse(data1)

#Remove unnecessary columns from your dataframe: row, test_id, demo_group.
#removing 3 columns from data set: "row", "test_id", "demo_group"
data1_dummy <- data1_dummy %>% 
  select(-c(row, test_id, demo_group))

#Make necessary changes in variable types.
#changing type of column "ID" and "age" from "character" to "numeric"
data1_dummy$ID <- as.numeric(data1_dummy$ID)
data1_dummy$age <- as.numeric(data1_dummy$age)

####Pratik's part for tests and visualization
data1_dummy <- data1_dummy %>%
  distinct() %>% 
  pivot_wider(
    names_from = time_measurement, 
    values_from = value)

data1_dummy <- data1_dummy %>%
  mutate(rec_ver_tat_level = if_else(rec_ver_tat <= 100, "Low", "High"))
####End of Pratik's part

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

#clearing misunderstandings and start merging present code chunks from everybody into one merged script----


#continuation on 10.09.25----
#read and join the additional dataset to your main dataset.
data_join <- read_delim(here("data", "exam_data_join.txt"), delim = "\t")

data1_dummy <- data1_dummy %>%
  left_join(data_join, join_by("ID" == "id"))

#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations 
##Only for persons tested "pan_day" later than 50 

#getting every ID/person tested 50 days after pandemic start
data1_stratified_panday <- data1_dummy %>% 
  filter(pan_day > 50)

#count of observations
glimpse(data1_stratified_panday)
#down to 9842 rows

#calculating and outputting min, max, mean and sd of column "age" after grouping by day after pandemic (pan_day)
##for each day after start of pandemic
age_stratified_after_panday_each <- data1_dummy %>% 
  filter(pan_day > 50) %>% 
  group_by(pan_day) %>% 
  summarise(n = n(), 
  min = min(age),
  max = max(age), 
  mean = mean(age), 
  sd = sd(age))

##for all days after pandemic combined
age_stratified_after_panday_total <- data1_dummy %>% 
  filter(pan_day > 50) %>% 
  summarise(n = n(), 
  min = min(age),
  max = max(age), 
  mean = mean(age), 
  sd = sd(age))
  
#Use two categorical columns in your dataset to create a table (with count())
data1_dummy %>% 
  count (ID, first_name)
