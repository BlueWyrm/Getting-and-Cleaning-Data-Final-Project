library(dplyr)

filename <- 'activityData.zip'


if (!file.exists(filename)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, filename, method="curl")
} 

if (!file.exists("UCI HAR Dataset")) { 
      unzip(filename) 
}
# read the data from the files
varNames <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
testData <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = varNames$functions)
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
trainData <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = varNames$functions)
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merge the training and the test sets into one data set.

totalData <- rbind(trainData, testData)
totalActivities <- rbind(trainActivities, testActivities)
totalSubject <- rbind(subject_train, subject_test)
mergedData <- cbind(totalSubject, totalActivities, totalData)

#extract only the mean and standard deviations
finalData <- mergedData %>% select(subject, code, contains('mean'), contains('std'))

#give the activities more descriptive names
finalData$code <- activities[finalData$code, 2]

#give the dataset more descriptive variable names
names(finalData)[2] = "activity"
names(finalData)<-gsub("Acc", "Accel", names(finalData))
names(finalData)<-gsub("BodyBody", "Body", names(finalData))
names(finalData)<-gsub("Mag", "Magnitude", names(finalData))
names(finalData)<-gsub("^t", "Time", names(finalData))
names(finalData)<-gsub("^f", "Frequency", names(finalData))
names(finalData)<-gsub("tBody", "TimeBody", names(finalData))
names(finalData)<-gsub("-mean()", "Mean", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("-std()", "STD", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("-freq()", "Frequency", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("angle", "Angle", names(finalData))
names(finalData)<-gsub("gravity", "Gravity", names(finalData))

#create a separate data set with the average of each variable for each activity and each subject.
summaryData <- finalData %>% group_by(subject, activity) %>% summarise_all(list(mean = mean))
write.table(summaryData, "summaryData.txt", row.name=FALSE)