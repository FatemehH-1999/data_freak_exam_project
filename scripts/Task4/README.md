# data_freak_exam_project
This project is part of the RMED901 course, and the answers were prepared by the Data Freak exam project group.
# Task4
# Goal
Create plots that would help answer these questions

# Loading libraries
# Loading tidied data set
The dataset "exam_data_tidier_2025-09-09.txt" was imported into R using the read_delim(here().delim = " ") function
# Plotting

## Sebastian
### Are there any correlated measurements?
Few correlations visible: 
Strongest correlations (0,67 - 1) between pan_day & pan_week and orderset & multi_ct_result_orderset. Here, correlation is expected, since pan_week and multi_ct_result_orderset were created out of pan_day and orderset.
weaker correlations (0,33 - 0,67) between age & pan_day, age & pan_week, age & col_rec_tat. Again, pan_day and pan_week are based on each other. 
Rest mostly correlations between 0 - 0,33 and some between -0,33 - 0.

## Pratik
### Does the time spent waiting for the test result improve during these 100 days that the dataset includes?
#### point plot
need to find correlation between rec_ver_tat and pan_day
No improvement found and the correlation matrix shows almost no correlation (r=0.01)
### Were there more females than males that took the test at a drive through?
#### bar plot
Yes, there were more females (n=3997) than males (n=3912)

## Fatemeh
### Does the distribution of the ct_result differ with sex group?
#### Violin plot: shows full distribution shape
The violin plot indicates that the ct_result distributions for females and males are nearly identical, showing no meaningful difference between the two sex groups
Their medians and overall spread are very similar, with no distinct peaks. 
gender has no meaningful effect on ct_result
#### Density plot: both groups overlaid
The density plot shows that the ct_result distributions for females and males almost completely overlap, indicating no noticeable difference between the two gender groups.

## Sebastian
### Does the distribution of the ct_result differ with payor_group?
#### Violin plot: shows full distribution shape
#### Ridgeline chart: shows density distribution for all groups
All groups share the largest distribution at ct_result = 45, with "commercial" having the most results at 45.
"Government" and "medical assistance" have second highest number at 45. Rest groups approx. same number.
Some outlier in all groups, with "commercial", "government" and "NA" having the most. Least outliers are in group "charity care" and "other", "medical assistnance".