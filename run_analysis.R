# Reading Features file
featuresData <- read.csv(file = "features.txt", sep = " ", header = FALSE)

# Finding Mean & Standard Deviation columns
meanStdCols <- grep("-mean\\(\\)|-std\\(\\)", featuresData$V2)

# Storing column names
meanStdColumnNames <- grep("-mean\\(\\)|-std\\(\\)", featuresData$V2, value = TRUE)

# Function to modify column names
colNameFunction <- function(x) {
  prefix <- ""
  if(startsWith(x, "tBodyAccJerk")) {
    prefix <- "Total Body Acceleration Jerk "
  } else if(startsWith(x,"tBodyAcc")) {
    prefix <- "Total Body Acceleration "
  } else if(startsWith(x, "tBodyGyroJerk")) {
    prefix <- "Total Body Gyroscope Jerk "
  } else if(startsWith(x, "tBodyGyro")) {
    prefix <- "Total Body Gyroscope "
  } else if(startsWith(x, "tGravityAcc")) {
    prefix <- "Total Gravity Acceleration "
  } else if(startsWith(x, "tBodyAccMag")) {
    prefix <- "Total Body Acceleration Mag "
  } else if(startsWith(x, "tGravityAccMag")) {
    prefix <- "Total Gravity Acceleration Mag "
  } else if(startsWith(x, "tBodyAccJerkMag")) {
    prefix <- "Total Body Acceleration Jerk Mag "
  } else if(startsWith(x, "tBodyGyroMag")) {
    prefix <- "Total Body Gyroscope Mag "
  } else if(startsWith(x, "tBodyGyroJerkMag")) {
    prefix <- "Total Body Gyroscope Jerk Mag "
  } else if(startsWith(x, "fBodyAccJerk")){
    prefix <- "Frequency Signal Body Acceleration Jerk "
  } else if(startsWith(x, "fBodyAcc")){
    prefix <- "Frequency Signal Body Acceleration "
  } else if(startsWith(x, "fBodyGyro")) {
    prefix <- "Frequency Signal Body Gyroscope "
  } else if(startsWith(x, "fBodyAccMag")) {
    prefix <- "Frequency Signal Body Acceleration Mag "
  } else if(startsWith(x, "fBodyBodyAccJerkMag")) {
    prefix <- "Frequency Signal Body Acceleration Jerk Mag "
  } else if(startsWith(x, "fBodyBodyGyroMag")) {
    prefix <- "Frequency Signal Body Gyroscope Mag "
  } else if(startsWith(x, "fBodyBodyGyroJerkMag")) {
    prefix <- "Frequency Signal Body Body Gyroscope Jerk Mag "
  }
  
  if(length(grep("mean()", x, value=TRUE)) != 0) {
    prefix <- paste(prefix, "Mean ", sep = "")
  } else {
    prefix <- paste(prefix, "Std ", sep = "")
  }
  
  if(length(grep("-X", x, value=TRUE) != 0)) {
    prefix <- paste(prefix, "X Direction", sep = "")
  } else if(length(grep("-Y", x, value = TRUE) != 0)) {
    prefix <- paste(prefix, "Y Direction", sep = "")
  } else if(length(grep("-Z", x, value = TRUE) != 0)) {
    prefix <- paste(prefix, "Z Direction", sep = "")
  }
  prefix
}

# Modifying column names
meanStdColumnNames <- sapply(meanStdColumnNames, colNameFunction)

# Reading Activity Labels
activityLabels <- read.csv(file = "activity_labels.txt", sep = " ", header = FALSE)

# Reading Activities of each observation for training and test data
trainingActivities <- read.table(file = "train//Y_train.txt")
testActivities <- read.table(file = "test//Y_test.txt")

# Reading Subjects for each observation for training and test data
trainingSubject <- read.table(file = "train//subject_train.txt")
testSubject <- read.table(file = "test//subject_test.txt")

# Used to store widths
widthsVector <- c()

# Using positive width to consider only mean and standard deviation columns
initialPositiveWidth <- 16

# Using negative width to ignore rest of the columns
initialNegativeWidth <- -16

for(i in 1:561) {
  if(i %in% meanStdCols) {
    widthsVector <- append(widthsVector, initialPositiveWidth)
  } else {
    widthsVector <- append(widthsVector, initialNegativeWidth)
  }
}

# Reading Activities
trainingActivityCol <- sapply(trainingActivities, function(x) if(x %in% activityLabels[,1]) activityLabels[x,2] else NULL)
testActivityCol <- sapply(testActivities, function(x) if(x %in% activityLabels[,1]) activityLabels[x,2] else NULL)

# Reading Training Data
trainingData <- read.fwf(file = "train//X_train.txt", widths = widthsVector, header = FALSE, as.is = T)
trainingData['Activity'] <- trainingActivityCol
trainingData['Subject'] <- trainingSubject
colnames(trainingData) <- c(as.character(meanStdColumnNames), 'Activity', 'Subject')

# Reading Test Data
testData <- read.fwf(file = "test//X_test.txt", widths = widthsVector, header = FALSE, as.is = T)
testData['Activity'] <- testActivityCol
testData['Subject'] <- testSubject
colnames(testData) <- c(as.character(meanStdColumnNames), 'Activity', 'Subject')

# Merging training and test data
mergedData <- merge(trainingData, testData, all = TRUE)

# Creating a subset of merge data to create tidy data
# Using 67:68 because my activity column is #67 and subject column is #68
tidyData <- mergedData[!duplicated(mergedData[67:68]),]
tidy <- tidyData

# Retriving unique subjects
uniqueSubjects <- unique(tidyData$Subject)

# Calculating the average values for each variable for each activity and each subject
for(i in activityLabels$V2) {
  for(j in uniqueSubjects) {
    rowNumber <- 1
    print(paste(i,j,sep=" "))
    for(k in 1:66) {
      tidyData[tidyData$Activity %in% i & tidyData$Subject %in% j,k] <- mean(mergedData[mergedData$Activity %in% i & mergedData$Subject %in% j,k])
    }
  }
}