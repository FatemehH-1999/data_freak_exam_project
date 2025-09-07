#tidying dataset 1: "exam_data.txt"

#loading necessary librarys----
library(tidyverse)
library(here)

#reading data and assining to data1----
data1 <- read_delim(here("data", "exam_data.txt"), delim = "\t")

#exploring data----

glimpse(data1)
## 15 columns and 34,048 rows
skimr::skim(data1)


#Task: Are all variables present as columns?----

data1
##checking for columns with double meaning or mult. values in column----

glimpse(data1$subject)
glimpse(data1$gender-age) #not working, bound by "-"
##column subject has ID and name together
##column gender-age needs splitting

#glimpse(data1$time measurement) #not working
#not working with space in name

####first changing column names to get access to data####----

#finding columns with false names
glimpse(data1)

#"gender-age", "pan day", "1_test_id", "time measurement" and ".value"

data1 <- data1 %>% 
  rename(gender_age = 'gender-age',
         pan_day = 'pan day',
         time_measurement = 'time measurement',
         value = '.value',
         test_id = '1_test_id')

glimpse(data1)
##names sucessfully changed

####end of column name changes for access####----

#looking for columns to separate
glimpse(data1)

##columns to separate: "subject", "gender_age"----

data1_dummy <- data1 %>% 
  separate_wider_delim(subject, delim = " ", names = c("ID", "first_name", "last_name")) %>% 
  separate_wider_delim(gender_age, delim = "-", names = c("gender", "age"))
glimpse(data1_dummy)

#writing file to save tidied data set----
write_csv(data1_dummy, here("data", "exam_data.csv"))