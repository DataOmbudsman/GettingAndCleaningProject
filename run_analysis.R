

# 1 Merges the training and the test sets to create one data set.

# reading and merging train data
dirTrain <- "UCI HAR Dataset\\train\\"
subjTrain <- read.table(paste(dirTrain, "subject_train.txt", sep=""))
XTrain <- read.table(paste(dirTrain, "X_train.txt", sep=""),
                     header=FALSE)
YTrain <- read.table(paste(dirTrain, "y_train.txt", sep=""),
                     header=FALSE)
allTrain <- cbind(subjTrain, YTrain, XTrain)

# reading and merging test data
dirTest <- "UCI HAR Dataset\\test\\"
subjTest <- read.table(paste(dirTest, "subject_test.txt", sep=""))
XTest <- read.table(paste(dirTest, "X_test.txt", sep=""),
                     header=FALSE)
YTest <- read.table(paste(dirTest, "y_test.txt", sep=""),
                     header=FALSE)
allTest <- cbind(subjTest, YTest, XTest)

# merging training and test data together
allData <- rbind(allTrain, allTest)


# 2 Extracts only the measurements on the mean and standard deviation
# for each measurement. 
# 4 Appropriately labels the data set with descriptive activity names. 

# feature name vector
pathVector <- "UCI HAR Dataset\\features.txt"
dfVector <- read.table(pathVector)
nameVector <- as.character(dfVector[ , 2])

# naming columns
names(allData) <- c("subject", "activity_label", nameVector)

# filtering names (only mean() and std() )
meanNames <- grepl("-mean()", nameVector)
stdNames <- grepl("-std()", nameVector)
meanorstdNames <- meanNames | stdNames 

# keeping needed columns
neededData <- allData[ , c(TRUE, TRUE, meanorstdNames)]


# 3 Uses descriptive activity names to name the activities
# in the data set

# getting activity labels
actPath <- "UCI HAR Dataset\\activity_labels.txt"
actLabes <- read.table(actPath)

# merging needed data and activity labels
apprlabelsData <- merge(neededData, actLabes,
                        by.x="activity_label", by.y = "V1")
apprlabelsData$activity_label <- NULL
names(apprlabelsData)[ncol(apprlabelsData)] <- "activity_label"


# 5 Creates a second, independent tidy data set with
# the average of each variable for each activity and each subject. 

apprlabelsData$subject <- as.factor(apprlabelsData$subject)
independent <- aggregate(. ~ activity_label + subject,
                         data = apprlabelsData, FUN="mean")

write.table(independent, file="independent_tidy.txt",
            row.names = FALSE)
