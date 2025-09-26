# data_freak_exam_project
This project is part of the RMED901 course, and the answers were prepared by the Data Freak exam project group.
#Task2
#Goal
Read and tidy the dataset:

##Loading libraries
##Loading "exam_data.txt" into "data1":
The dataset "exam_data.txt" was imported into R using the read_delim(here().delim = "\t") function

###Checking dupilication
####are there  only unique observations in the data?
    .there are duplications as it shows 12344 observations
    
###finding columns with false names
#####changing "gender-age", "pan day", "1_test_id", "time measurement" and ".value"
    .Renamed certain columns to ensure consistent naming across both character and numeric fields

###looking for columns to separate
####columns to separate: "subject", "gender_age"
     .Split the original columns so that:
      Subject → separated into ID, First_Name, and Last_Name
      Gender_Age → separated into Gender and Age.
      
###Check variable types 
#####column type of "ID" and "age" have to be changed to numeric instead of character

###writing file to save pre-tidied data set
      ."exam_data_tidy1.txt"




  
  
   

