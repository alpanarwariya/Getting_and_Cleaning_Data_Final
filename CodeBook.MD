The run_analysis.R script downloads the data file from the web and performs the 5 steps as described in the course project discription.

1. Downloads the dataset
   Dataset is downloaded from given URL and unzipped under the folder 'UCI HAR Dataset' in the working firectory
   
2. Assigns each data to variables

   - features <- features.txt : 561 rows, 2 columns
   The features selected for this dstabase come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and 
   tGyro-  XYZ
   
   - activities <- activity_labels.txt : 6 rows, 2 columns
   List of activities performed when the corresponding measurements were taken and its codes (labels)

   - subject_test <- test/subject_test.txt : 2947 rows, 1 column
   contains test data of 9/30 volunteer test subjects being observed
   
   - x_test <- test/X_test.txt : 2947 rows, 561 columns
   contains recorded features test data

   - y_test <- test/y_test.txt : 2947 rows, 1 columns
   contains test data of activities’code labels

   - subject_train <- test/subject_train.txt : 7352 rows, 1 column
   contains train data of 21/30 volunteer subjects being observed

   - x_train <- test/X_train.txt : 7352 rows, 561 columns
   contains recorded features train data

   - y_train <- test/y_train.txt : 7352 rows, 1 columns
   contains train data of activities’code labels

3. Merges the training and test datasets to create to creare one data set
   
   - X (10299 rows, 561 cols) is created by merging x_test and x_train using rbind()
   - Y (10299 rows, 1 col) is cretaed by merging y_test and y_train uning rbind()
   - subject(10299 rows, 1 col) is created by merging subject_test and subject_train using rbind()
   - merged_data (10299 rows, 563 cols) is created by merging X, Y and subject using cbind()
   
4. Extracts only the mean and standard deviation meansurements for each meansurement

   TidyData (10299 rows, 88 columns) is created by selecting only subject, activity and meansurements for mean 
   and standard deviation from merged_data
   
5. Used description activity names to name the activities in the dataset
   Activity Code in TidyData is replaced with Activity Name using activites variable
   
6. Appropriately labels the variables in the dataset with descriptive names
   - 'code' column name in TidyData is renamed to 'activites'
   - All 'Acc' in column’s name replaced by 'Accelerometer'
   - All 'Gyro' in column’s name replaced by 'Gyroscope'
   - All 'BodyBody' in column’s name replaced by 'Body'
   - All 'Mag' in column’s name replaced by 'Magnitude'
   - All start with character 'f' in column’s name replaced by 'Frequency'
   - All start with character 't' in column’s name replaced by 'Time'
   - All '-mean()' in column’s name replaced by 'Mean'
   - All '-std()' in column’s name replaced by 'STD'
   
7. Creates final independent dataset from TidyData with the average of each measurement for each activity and each subject
   - FinalData(180 rows, 88 columns) is created by grouping TidyData by subject and activities and then taking mean of all 
     meansurement variables.
   - FinalData is wriiten into FinalData.txt file in the working directory using write.table() 
