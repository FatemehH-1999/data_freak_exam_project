library(tidyverse)
library(here)

#loading dataset into "data1"
data1 <- read_delim(here("data", "exam_data.txt"), delim = "\t")

#are there  only unique observations in the data?
length(unique(data1$subject))
data1%>%
  distinct(data1$subject)
#there are duplications as it shows 12344 observations

#finding columns with false names
glimpse(data1)

#changing "gender-age", "pan day", "1_test_id", "time measurement" and ".value"
data1 <- data1 %>% 
  rename(gender_age = 'gender-age',
         pan_day = 'pan day',
         time_measurement = 'time measurement',
         value = '.value',
         test_id = '1_test_id')

#looking for columns to separate
glimpse(data1)

##columns to separate: "subject", "gender_age"
data1 <- data1 %>% 
  separate_wider_delim(subject, delim = " ", names = c("ID", "first_name", "last_name")) %>% 
  separate_wider_delim(gender_age, delim = "-", names = c("gender", "age"))
glimpse(data1)

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

#column type of "ID" and "age" have to be changed to numeric instead of character

#writing file to save pre-tidied data set
write_delim(data1, here("data", "exam_data_tidy.txt"))


#executable script----
data1 <- read_delim(here("data", "exam_data.txt"), delim = "\t")

data1 <- data1 %>% 
  rename(gender_age = 'gender-age',
         pan_day = 'pan day',
         time_measurement = 'time measurement',
         value = '.value',
         test_id = '1_test_id') %>%
  separate_wider_delim(subject, delim = " ", names = c("ID", "first_name", "last_name")) %>% 
  separate_wider_delim(gender_age, delim = "-", names = c("gender", "age"))

  write_delim(data1, here("data", "exam_data_tidy1.txt"))

glimpse(data1)  
  



