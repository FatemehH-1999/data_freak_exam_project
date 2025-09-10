#started on 10.09.25 -  ----
#loading libraries
library(tidyverse)
library(here)
library(GGally)

#Are there any correlated measurements?----
x <- (ggcorr(
  data1,
  method = c("complete.obs", "pearson"),
  name = "Schaft",
  geom = "circle",
  max_size = 10,
  min_size = 1,
  nbreaks = 6,
  size = 3,
  hjust = 0.75,
  angle = 0,
  palette = "RdBu" # colorblind safe, photocopy-able
)) 
x

#loading post-tidied data set
data1 <- read_delim(here("data", "exam_data_tidier_2025-09-09.txt"), delim = " ")

data1 <- data1 %>% 
  select(-c(ID))
