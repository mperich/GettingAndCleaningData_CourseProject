require(data.table)
require(stringr)
require(dplyr)

ToDescriptiveVariableName <- function(oldVariableName)
{
      #Takes a variable name (column from dataset) and replaces commonly used 
      #abberviations with more readable strings. Also does some clean up on the strings
      #ie. removing trailing periods that were introduced from whitespace.
      
      oldVariableName <- gsub("^t", "time_", oldVariableName)
      oldVariableName <- gsub("^f", "frequency_", oldVariableName)
      oldVariableName <- gsub("Acc", "Accelerometer", oldVariableName)
      oldVariableName <- gsub("Gyro", "Gyroscope", oldVariableName)
      oldVariableName <- gsub("Mag", "Magnitude", oldVariableName)
      oldVariableName <- gsub("\\.\\.\\.([XYZ])", "_\\1-Axis", oldVariableName)
      oldVariableName <- gsub("\\.([XYZ])\\.", "_\\1-Axis_", oldVariableName)
      oldVariableName <- gsub("std", "std_dev", oldVariableName) 
      oldVariableName <- gsub("\\.+$", "", oldVariableName)
      oldVariableName <- gsub("^angle_t", "angle_time_", oldVariableName)
      oldVariableName
}

GetColumnNamesFromFile <- function()
{
      #Function that parses from the features.txt file included with the data. 
      
      columnHeaderFile <- "features.txt"
      
      unparsedColumnHeaders <- readChar(columnHeaderFile, file.info(columnHeaderFile)$size)
      
      #Columns in the file are in this format. The column names we want for our tidy
      #data set need to remove the starting numeric label and space and the trailing
      #newline character
      
      columnNamePattern <- "[0-9]+ (.*)\\n"
      
      matches <- as.data.frame(str_match_all(unparsedColumnHeaders, columnNamePattern))
      
      parsedColNames <- as.character(matches$X2)
      
      parsedColNames
}

#This script might be put into either the root directory of the dataset, or else in the "UCI HAR Dataset" directory
#If it is in the root directory we need to set the correct working directory.
if (file.exists(".\\UCI HAR Dataset\\features.txt"))
    setwd(".\\UCI HAR Dataset\\")

parsedColNames <- GetColumnNamesFromFile()

#Read test data and corresponding Subject IDs and Activity Labels
testData <- read.table("test/X_test.txt", col.names = parsedColNames)
testData$Subject.ID <- read.table("test/subject_test.txt")$V1
testData$Activity.Label <- read.table("test/y_test.txt")$V1

#Read training data
trainData <- read.table("train/X_train.txt")
trainData$Subject.ID <- read.table("train/subject_train.txt")$V1
trainData$Activity.Label <- read.table("train/y_train.txt")$V1

#Merge test and training data sets
HumanActivityData <- rbindlist(list(testData,trainData))

#Extract only mean and standard deviation measurements
HumanActivityData <- select(HumanActivityData, contains("mean"), contains("std"), 
                            Subject.ID, Activity.Label)

#Replace numeric activity labels with descriptive strings corresponding to the following vector
activityDescriptions <- c("WALKING", "WALKING_UPSTAIRS",
                          "WALKING_DOWNSTAIRS", "SITTING",
                          "STANDING", "LAYING")

HumanActivityData$Activity.Label <- activityDescriptions[as.numeric(HumanActivityData$Activity.Label)]

#Create more descriptive variable names by sapplying over the names of our dataset
#with the function ToDescriptiveVariableName
setnames(HumanActivityData, old = names(HumanActivityData),
         new = sapply(names(HumanActivityData), ToDescriptiveVariableName))

#Summarize Data on each column grouped by Subject ID and Activity Label. Also, sort this data to make it a little nice.
dataSummary <- HumanActivityData %>% group_by(Subject.ID, Activity.Label) %>% summarise_each(funs(mean)) %>% arrange(Subject.ID)

#Save the data summary to file
write.table(dataSummary, "HumanActivityData_Averages_By_Subject_And_Activity.txt", row.names = FALSE)
