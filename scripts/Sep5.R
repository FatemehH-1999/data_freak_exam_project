library(tidyverse)
library(here)
data1 <- read_delim(here("data", "exam_data.txt"), delim = "\t")

data1 %>% 
  glimpse()

data1 %>%
  head()

data1 %>%
  tail()

data1 %>%
  summary()

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
