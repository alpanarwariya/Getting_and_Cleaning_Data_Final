library(dplyr)
filename <- "Getting_and_Cleaning_Data_Final"

# download the zip file from URL

if(!file.exists(filename)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, filename, method="curl")
}

# Unzip the downloaded file
if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}

# creating data frames from txt files

features <- read.table("UCI HAR Dataset/features.txt", col.names=c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="subject")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=features$functions)
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names="code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names="subject")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=features$functions)
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names="code")

# merging datasets

X <- rbind(X_train,X_test)
Y <- rbind(Y_train, Y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, Y, X)

# extract only the measurements for mean and Std deviation
TidyData <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

# use descriptive activity names to name the activities in the dataset

TidyData$code <- activities[TidyData$code,2]

# appropriate labeling of variable names in the dataset

names(TidyData) [2] <- "activity"
names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody", names(TidyData))
names(TidyData) <- gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-freq", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("angle", "Angle", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))

# Take average of each variable for each activity and each subject

FinalData <- TidyData %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(FinalData, file = "FinalData.txt", row.names=FALSE)







