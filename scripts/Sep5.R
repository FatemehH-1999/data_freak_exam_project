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

library(dplyr)
data1 %>%
  select(starts_with(data1, is.numeric()))
data1

cols_start_num <- grep("^[0-9]", colnames(df), value = TRUE)
cols_start_num

data1 
glimpse(data1)


#renaming 
data1 %>% 
  rename(gender_age = `gender-age`, pan_day = `pan day`, time_measurement = `time measurement`, value = .value, test_id = `1_test_id` )
 
#columns containing combined variables
data1 %>%
  select(contains("age")) %>%
  count()

#unique observations in the data set
data1 %>%
  distinct(subject)
data1

#Check variable types 
typeof(data1$clinic_name)
typeof(data1$`gender-age`)
typeof(data1$demo_group)
typeof(data1$drive_thru_ind)
typeof(data1$orderset)
typeof(data1$payor_group)
typeof(data1$result)
typeof(data1$patient_class)
typeof(data1$ct_result)
