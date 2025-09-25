#loading libraries
library(tidyverse)
library(here)
data2 <- read_delim(here("data", "exam_data_tidy_2025-09-08.txt"), delim = " ")

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

#Read and join the additional dataset to your main dataset

