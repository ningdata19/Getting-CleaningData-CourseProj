#CodeBook.md

This code book describes the variables, the data, and any transformations or work performed to clean up data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Variables used
* x_testing to read data in x_text.txt
* y_testing to read data in y_text.txt
* subject_testing to read data in subject_test.txt
* x_training to read data in X_train.txt
* y_training to read data in y_train.txt
* subject_training to read data in subject_train.txt
* features to read vectors in features.txt
* activityLabels to read activity labels in activity_labels.txt

## Data 
features[,2] 
activityId
subjectId
activityType

## Merging all using cbind() and rbind()

cbind(y_training, subject_training, x_training)
cbind(y_testing, subject_testing, x_testing)
rbind(mrg_training, mrg_testing)

## Vector for Defining ID...
mean_and_std

## Subset for all in one
setForMeanAndStd

## Second tidy set
secTidySet 

## Second tidy set in txt file
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)


