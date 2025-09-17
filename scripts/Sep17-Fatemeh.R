#read the data -----

library(tidyverse)
library(here)
data1 <- read_delim(here("data", "exam_data.txt"), delim = "\t")

#exploring exam data file
#overview of the data
data1 %>% 
  glimpse()
data1 %>%
  head()
data1 %>%
  tail()
data1 %>%
  summary()
skimr::skim(data1)
naniar::gg_miss_var(data1)


#Tidy, adjust, and explore

##renaming
df1 <- data1 %>% 
  rename(gender_age = `gender-age`, pan_day = `pan day`, time_measurement = `time measurement`, value = .value, test_id = `1_test_id` )
df1

##Remove unnecessary columns from your dataframe: row, test_id, demo_group
df2 <- df1 %>%
  select(-row, -test_id, -demo_group)
df2

#Create a set of new columns:
##A column showing whether rec_ver_tat is higher than 100 or not: values High/Low
df3 <- df2 %>%
  mutate(rec_ver_tat_level = if_else( time_measurement> 100, "High", "Low"))
df3

#A numeric column showing pan_day in weeks
df4 <- df3 %>%
  mutate(pan_week = pan_day / 7)
df4

#A column showing drive_thru_ind as Yes/No
df5 <- df4 %>%
  mutate(drive_thru = if_else(drive_thru_ind == 1, "Yes", "No"))
df5

#A numeric column showing multiplication of ct_result and orderset for each person
df6 <- df5 %>%
  mutate(ct_orderset_product = ct_result * orderset)
df6

#seperating gender_age column 
df7 <- df6 %>%
  separate(gender_age, into = c("gender", "age"), sep = "-") %>%
  mutate(age = as.numeric(age))
df7

#Set the order of columns as: id, age, gender and other columns
df8 <- df7 %>%
  select(age, gender, everything())
df8

#Arrange ID column of your dataset in order of increasing number or alphabetically
df9 <- df1 %>%
  arrange(row)
df9

#Read and join the additional dataset to your main dataset.