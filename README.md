Run "run_analysis.R" from the directory that contains the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This will merge the training and test data sets and tidy up the data. It doesn't currently write the tidy data anywhere, but the data is contained in the data frame HumanActivityData. 

A seperate dataset is created which computes the mean  for each variable for each (Subject ID + Activity) combination and is written to "HumanActivityData_Averages_By_Subject_And_Activity.txt"

For more information on how the data was tidied please see CodeBook.md
