#loading libraries
library(tidyverse)
library(here)
data2 <- read_delim(here("data", "exam_data_tidy1.txt"), delim = " ")

#exploring tidy version of the data se
glimpse(data2)

#A numeric column showing pan_day in weeks
data2 <- 
  data2 %>%
  mutate(pan_week = pan_day/7)
data2

#A numeric column showing multiplication of ct_result and orderset for each person
data2 <-
  data2 %>%
  mutate(multi_ct_result_orderset = ct_result*orderset) %>%
  drop_na(multi_ct_result_orderset)
data2

#arrange ID
data2 <-
  data2 %>%
  arrange(ID)
data2

#A column showing whether rec_ver_tat is higher than 100 or not: values High/Low
data2 <- data2 %>% 
  distinct() %>%
  pivot_wider(
    names_from = time_measurement,
    values_from = value)
  
data2 <- data2 %>%
  mutate(rec_ver_tat_level = if_else(rec_ver_tat <= 100, "Low", "High"))
data2

#Read and join the additional dataset to your main dataset

library(tidyverse)
library(here)
exam_data_join <- read_delim(here("data", "exam_data_join.txt"), delim = "\t")

data2 <- left_join(data2, exam_data_join, join_by( c("ID" == "id" )))
data2

data2 <- left_join(data2, exam_data_join, by = c("ID" = "id"))
data2




