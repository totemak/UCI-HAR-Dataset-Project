---
title: "CodeBook"
output: html_document
---

The data set `HAR_tidy_dataset.txt` contains the following variables:

- `subject` - a numeric identifier for the subject being observed
- `activityid` - activity code identifier that matches up to an activity description the following way, 1 - WALKING, 2 - WALKING_UPSTAIRS, 3 - WALKING_DOWNSTAIRS, 4 - SITTING, 5 - STANDING, 6 - LAYING
- `activitydesc` - description of activityid being performed by the subject (see previous variable)
- `features` - selected variables containing the mean() or std() of observed activity
- `measurement` - measured values

The data set `HAR_summary.txt` contains the following variables:

- `subject` - a numeric identifier for the subject being observed
- `activitydesc` - description of activity being performed by the subject
- `features` - selected variables containing the mean() or std() of observed activity
- `avg_measurement` - average of measured values across time

#### Original datasets ####

From the original `UCI HAR Dataset` folder (or the ZIP file), we used the following files for this assignment:

- `activity_labels.txt` 
- `features.txt`
- `subject_test.txt` 
- `X_test.txt`
- `y_test.txt`
- `subject_train.txt` 
- `X_train.txt`
- `y_train.txt`

Their description is provided in separate README files in the original `UCI HAR Dataset` folder

#### Analysis Steps ####

We performed the data load, data combinations, merging, clean up and sort, as well as the final summary overview, in the following steps:

- step 1. load required packages - dplyr, tidyr
- step 2. read activity_labels.txt and features.txt
- step 3. read training data from the `train` folder
- step 4. read test data from the `test` folder
- step 5. combine test and training data with `rbind` (x with x, y with y, subject with subject)
- step 6. combine all data sets from step 5. to one new data frame with `cbind`
- step 7. remove all interim data frames that are not needed anymore
- step 8. select only the measurements on the mean and standard deviation
- step 9. apply descriptive activity names
- step 10. reorganize and sort data frame with `select` and `arrange`
- step 11. transform subject and activityid variables into factors
- step 12. create a tidy dataset, long format for better reading
- step 13. create a summarized dataset
- step 14. print preview results of the cleanup work
- step 15. export final data/results with `write.table`
- step 16. remove all previous not needed data frames once again to clean memory

