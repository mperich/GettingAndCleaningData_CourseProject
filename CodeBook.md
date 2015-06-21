<h2>Data Tidying Steps</h2>

The original data was split into 7 files. These included:

3 files (\train\X_train.txt, \train\subject_train.txt, \train\y_train.txt) for the training data consisting of the data, subject IDs and numeric activity labels respectively.
3 files(\test\X_test.txt, \train\subject_test.txt, \train\y_test.txt) in the same format for the test data.
1 file (features.txt) which included the feature names for the data set in an unparsed format.

The training and test sets were loaded and merged into a single dataset. The datasets variable names were loaded from features.txt.

The variables that contained mean and standard deviation measurements were then extracted from the dataset. 

The numeric activity labels were replaced with descriptive strings according to the following mapping:

1 => WALKING
2 => WALKING_UPSTAIRS
3 => WALKING_DOWNSTAIRS
4 => SITTING
5 => STANDING
6 => LAYING

Finally, variable names were made more descriptive and cleaned up using the function ToDescriptiveVariableName. This function replaced various abbreviations with more readable descriptions and removed some extraneous text introduced when parsing variable names from files.

<h2>Variables</h2>

Description from original dataset, modified to describe cleaned variable names.

Notation for X-, Y- and Z-axis data is denoted by "-(XYZ)_Axis" which denotes 3 variables, one for each respective axis. 

Each of these variables consists of two variables in the data set, one for <variable name>.std_dev which contains the standard deviation for the measurements of that variable and either <variable name>.mean for time variables or <variable name>.meanfreq for frequency variables.

<b>time_BodyAccelerometer-(XYZ)_Axis
time_GravityAccelerometer-(XYZ)_Axis</b>

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (time_BodyAccelerometer-(XYZ)_Axis and time_GravityAccelerometer-(XYZ)_Axis) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

<b>time_BodyAccelerometerJerk-(XYZ)_Axis
time_BodyGyroscope-(XYZ)_Axis
time_BodyGyroscopeJerk-(XYZ)_Axis
time_BodyAccelerometerMagnitude
time_GravityAccelerometerMagnitude
time_BodyAccelerometerJerkMagnitude
time_BodyGyroscopeMagnitude
time_BodyGyroscopeJerkMagnitude</b>

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (time_BodyAccelrometerJerk-XYZ and time_BodyGyroscopeJerk-(XYZ)_Axis). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (time_BodyAccelerometerMagnitude, time_GravityAccelerometerMagnitude, time_BodyAccelerometerJerkMagnitude, time_BodyGyroscopeMagnitude, time_BodyGyroscopeJerkMagnitude). 

<b>frequency_BodyAccelerometer-(XYZ)_Axis
frequency_BodyAccelerometerJerk-(XYZ)_Axis
frequency_BodyGyroscope-(XYZ)_Axis
frequency_BodyAccelerometerMagnitude
frequency_BodyAccelerometerJerkMagnitude
frequency_BodyGyroscopeMagnitude
frequency_BodyGyroscopeJerkMagnitude</b>

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency_BodyAccelerometer-(XYZ)_Axis, frequency_BodyAccelerometerJerk-(XYZ)_Axis, frequency_BodyGyroscope-(XYZ)_Axis, frequency_BodyAccelerometerJerkMagnitude, frequency_BodyGyroscopeMagnitude, frequency_BodyGyroscopeJerkMagnitude. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'_(XYZ)-axis' is used to denote 3-axial signals in the X, Y and Z directions.

<b>Subject.ID</b>

The unique subject ID that the observation belongs to

<b>Activity.Label</b>

A human described activity label for the data observation from one of: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

<h1>Summary File</h1>

A seperate dataset is created which computes the mean for each (Subject ID + Activity) combination and is written to "HumanActivityData_Averages_By_Subject_And_Activity.txt"




