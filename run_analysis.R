# Download files
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# STEP 1
#Reading files

# Reading testing tables:
x_testing <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_testing <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_testing <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading training tables:
x_training <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_training <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_training <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

#assigning column names

colnames(x_training) <- features[,2] 
colnames(y_training) <-"activityId"
colnames(subject_training) <- "subjectId"

colnames(x_testing) <- features[,2] 
colnames(y_testing) <- "activityId"
colnames(subject_testing) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#merging all

mrg_training <- cbind(y_training, subject_training, x_training)
mrg_testing <- cbind(y_testing, subject_testing, x_testing)
setAllInOne <- rbind(mrg_training, mrg_testing)

# STEP 2
#reading column names

colNames <- colnames(setAllInOne)

#vector for defining ID...
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

#subset all in one
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

# STEP 3
#Activity names
setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

# STEP 4
#Second tidy set
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

# STEP 5
#Second tidy set in txt file
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
