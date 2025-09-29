#read the data -----

library(tidyverse)
library(here)
data1 <- read_delim(here("data/raw_data", "exam_data.txt"), delim = "\t")

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
df3 <- df1 %>%
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

#columns containing combined variables
df6 %>%
  select(contains("age")) %>%
  count()

#unique observations in the data set
df6 %>%
  distinct(subject)
df6

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

#Remove rows where any NA appears anywhere
df6 %>%
  drop_na()
df6

#separating gender_age column 
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

#Remove rows where any NA appears anywhere
df9 %>%
  drop_na()
df9

# Check the dimensions and variable type of the tidied data
dim(df9) #34048 rows and 15 columns 
glimpse(df9)

# Save the tidy data ----
# make sure the "data" folder exists
dir.create(here("data"), showWarnings = FALSE)

# path to the file you want to create
fileName <- here("data", "20250917-tidy-exam-data.txt")

# write df9 as a tab-delimited text file
write_delim(
  df9,
  file = fileName,  
  delim = "\t"
)




#Read and join the additional dataset to your main dataset.
