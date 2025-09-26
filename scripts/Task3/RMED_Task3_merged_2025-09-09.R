#Task-3 Group: Data_Freak

#Description of code parts----
##loading libraries----
library(tidyverse)
library(here)

##loading post-tidied data set----
data <- read_delim(here("data", "exam_data_tidy_2025-09-08.txt"), delim = " ")
data_join <- read_delim(here("data", "exam_data_join.txt"), delim = "\t")

#looking at data set
glimpse(data)

##Make necessary changes in variable types.----
###changing type of column "ID" and "age" to numeric instead of character
data$ID <- as.numeric(data$ID)
data$age <- as.numeric(data$age)

##A column showing whether rec_ver_tat is higher than 100 or not: values High/Low.
data <- data %>%
  distinct() %>% 
  pivot_wider(
    names_from = time_measurement, 
    values_from = value)

data <- data %>%
  mutate(rec_ver_tat_level = if_else(rec_ver_tat <= 100, "Low", "High"))

##Remove unnecessary columns from your dataframe: row, test_id, demo_group.----
###removing 3 columns from data set: "row", "test_id", "demo_group"
data <- data %>% 
  select(-c(row, test_id, demo_group))

##Create a set of new columns: (each member of the group chooses one column)----
###A column showing whether rec_ver_tat is higher than 100 or not: values High/Low.----
#data <- data %>%
#  distinct() %>% 
#  pivot_wider(
#    names_from = time_measurement, 
#    values_from = value)

#data <- data %>%
#  mutate(rec_ver_tat_level = if_else(rec_ver_tat <= 100, "Low", "High"))

###A numeric column showing pan_day in weeks----
data <- 
  data %>%
  mutate(pan_week = pan_day/7)

###A column showing drive_thru_ind as Yes/No----
data <- data %>% 
  mutate(drive_thru_ind = if_else(drive_thru_ind == TRUE, "Yes","No"))

###A numeric column showing multiplication of ct_result and orderset for each person----
data <-
  data %>%
  mutate(multi_ct_result_orderset = ct_result*orderset) %>%
  drop_na(multi_ct_result_orderset)

##Set the order of columns as: id, age, gender and other columns----
data <- data %>% 
  select("ID", "age", "gender", everything())

##Arrange ID column of your dataset in order of increasing number or alphabetically.----
data <- data %>% 
  arrange(ID)

##read and join the additional dataset to your main dataset.----
data_join <- read_delim(here("data", "exam_data_join.txt"), delim = "\t")

data <- data %>%
  left_join(data_join, join_by("ID" == "id"))

#Executable script----
library(tidyverse)
library(here)

data <- read_delim(here("data", "exam_data_tidy_2025-09-08.txt"), delim = " ") %>% 
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
  left_join(read_delim(here("data", "exam_data_join.txt"), delim = "\t"), join_by("ID" == "id")) %>% 
  write_delim(here("data", "exam_data_tidier_2025-09-09.txt"), delim = " ")
#End of script----

#Explore data----
head(data)
glimpse(data)  
tail(data)

#Explore and comment on the missing variables----
##missing_count = 0, missing_percent = 0 

data <- read_delim(here("data", "exam_data_tidy_2025-09-08.txt"), delim = "\t") %>%                                 
  summarise(across(everything(), ~sum(is.na(.)))) %>%
  pivot_longer(cols = everything(),
               names_to = "variable",
               values_to = "missing_count") %>%
  mutate(missing_percent = 100 * missing_count / nrow(data)) %>%   
  arrange(desc(missing_percent))
data


#Stratifying of data by each person----

##Sebastian----
###Only for persons tested "pan_day" later than 50 

###getting every ID/person tested 50 days after pandemic start and sort after "pan_day"
data1 <- read_delim(here("data", "exam_data_tidy_2025-09-08.txt"), delim = " ") 
data_stratified_panday <- data1 %>% 
  filter(pan_day > 50) %>% 
  arrange(pan_day)

###calculating and outputting min, max, mean and sd of column "age" after grouping by day after pandemic (pan_day)
####for each day after start of pandemic
age_stratified_after_panday_each <- data_stratified_panday %>% 
  filter(pan_day > 50) %>% 
  group_by(pan_day) %>% 
  summarise(n = n(), 
            min = min(age),
            max = max(age), 
            mean = mean(age), 
            sd = sd(age))

####for all days after pandemic combined
age_stratified_after_panday_total <- data1 %>% 
  filter(pan_day > 50) %>% 
  summarise(n = n(), 
            min = min(age),
            max = max(age), 
            mean = mean(age), 
            sd = sd(age))

##Fatemeh----
##Only for persons with ct_result == 45
data1 <- read_delim(here("data", "exam_data_tidy_2025-09-08.txt"), delim = " ") 
data_stratified_ct_result <- data1 %>% 
  filter(ct_result == 45) %>% 
  arrange(ct_result)

###calculating and outputting min, max, mean and sd of column "age" after grouping by ct_result == 45
data1 %>%
  filter(ct_result == 45) %>%                               
  group_by(ct_result) %>% 
  summarise(n = n(), 
            min = min(age),
            max = max(age), 
            mean = mean(age), 
            sd = sd(age))


##Pratik----
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



#End of Stratifying----

#Use two categorical columns in your dataset to create a table (with count())----
data1_dummy %>% 
  count (ID, first_name)
#any more ideas???
#Pratik
merged_data %>%
  with(table(gender, rec_ver_tat_level))
