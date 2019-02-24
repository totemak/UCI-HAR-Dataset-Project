# NOTE: run the script when you are in the folder that contains the UCI HAR Dataset files

# step 1. load required packages
library(dplyr)
library(tidyr)

# step 2. read activity_labels.txt and features.txt
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("activityid", "activitydesc"))
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, col.names = c("featuresid","featuresdesc"))

# step 3. read training data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, col.names = features$featuresdesc)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names = "activityid")
subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names = "subject")

# step 4. read test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, col.names = features$featuresdesc)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names = "activityid")
subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names = "subject")

# step 5. combine test and training data
x_comb <- rbind(x_train,x_test)
y_comb <- rbind(y_train,y_test)
subj_comb <- rbind(subj_train,subj_test)

# step 6. combine all data sets to one new data frame
har_all <- cbind(x_comb,y_comb,subj_comb)

# step 7. remove all previous data frames that are not needed anymore
rm(x_train,x_test, y_train, y_test, subj_train, subj_test, x_comb, y_comb, subj_comb)

# step 8. select in a new data frame only the measurements on the mean and standard deviation for each measurement
har_sub <- select(har_all, subject, activityid, contains("mean"), contains("std"), -contains("meanFreq"))

# step 9. Use descriptive activity names and descriptive variable names
har_sub <- merge(har_sub, activity_labels, by = "activityid")

# step 10. reorganize and sort data frame
har_sub <- har_sub %>% 
  select(2, 1, 76, 3:75) %>% 
  arrange(subject, activityid)

# step 11. transform subject and activityid variables into factors for better data quality and reading
har_sub$subject <- as.factor(har_sub$subject)
har_sub$activityid <- as.factor(har_sub$activityid)

# step 12. create a tidy dataset, long format for better reading
har_sub_long <- gather(har_sub, "features", "measurement", 4:76)

# step 13. create a summarized dataset
har_summary <- har_sub_long %>% 
  group_by(subject, activitydesc, features) %>% 
  summarize(avg_measurement = mean(measurement)) %>% ungroup() %>% 
  arrange(subject, activitydesc, features)

# step 14. preview results of the cleanup work
tbl_df(har_sub_long)
tbl_df(har_summary)

# step 15. export final data/results
write.table(har_sub_long, file = "HAR_tidy_dataset.txt", quote = FALSE, sep = " ", row.names = FALSE, col.names = TRUE)

write.table(har_summary, file = "HAR_summary.txt", quote = FALSE, sep = " ", row.names = FALSE, col.names = TRUE)

# step 16. remove all previous not needed data frames
rm(activity_labels,all_data,features,har_all,har_sub)


# The export has finished, you should find 2 new TXT files with the results in your folder.

