#task5_Fatemeh
##Analyse the dataset and answer the following questions
###Is there a difference in the distributions of ct_results between different outcome groups (result)?
library(tidyverse)
library(here)

data <- read_delim(here("data", "20250917-tidy-exam-data.txt"), delim = "\t")
data


data1 %>%
  group_by(result) %>%
  summarise(
    n           = n(),
    mean_ct     = mean(ct_result, na.rm = TRUE),
    median_ct   = median(ct_result, na.rm = TRUE),
    sd_ct       = sd(ct_result, na.rm = TRUE),
    min_ct      = min(ct_result, na.rm = TRUE),
    max_ct      = max(ct_result, na.rm = TRUE)
  )
