# data_freak_exam_project
This project is part of the RMED901 course, and the answers were prepared by the Data Freak exam project group.
# Task3
# Goal
Tidy, adjust, and explore

## Loading librararies
## Loading post tidied data set 
The dataset "exam_data_tidY_2025-09-08.txt" and "exam_data_join.txt" were imported into R using the read_delim(here().delim = " ") and read_delim(here().delim = "\t") function

### Looking at data set 
### Make necessary changes in variable types
#### Changing type of column "ID" and "age" to numeric instead of character
Converted the "ID" and "age" columns from character to numeric type

### Remove unnecessary columns from your dataframe: row, test_id, demo_group.----
Removing 3 columns from data set: "row", "test_id", "demo_group"

### Create a set of new columns: (each member of the group chooses one column)
#### A column showing whether rec_ver_tat is higher than 100 or not: values High/Low
#### A numeric column showing pan_day in weeks
#### A column showing drive_thru_ind as Yes/No
#### A numeric column showing multiplication of ct_result and orderset for each person

### Set the order of columns as: id, age, gender and other columns
The order of these columns were changes 

### Arrange ID column of your dataset in order of increasing number or alphabetically

### Read and join the additional dataset to your main dataset\
The join dataset was added to the main dataset

### Explore and comment on the missing variables
missing_count = 0, missing_percent = 0 

### Stratifying of data by each person
#### Sebastian
##### Only for persons tested "pan_day" later than 50 
##### Getting every ID/person tested 50 days after pandemic start and sort after "pan_day"
##### Calculating and outputting min, max, mean and sd of column "age" after grouping by day after pandemic (pan_day)
##### For each day after start of pandemic
##### For all days after pandemic combined

#### Fatemeh
##### Only for persons with ct_result == 45
##### Calculating and outputting min, max, mean and sd of column "age" after grouping by ct_result == 45

#### Pratik
##### Only for persons with patient_class == inpatient
