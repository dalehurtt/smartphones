Codebook for Human Activity Recognition Using Smartphones Dataset
========================================================

See the *README.md* file for instructions on how to prepare the environment and run the Rscript analysis code. It assumes that you have downloaded the *Human Activity Recognition Using Smartphones Dataset* and organized it as follows (directories in **bold**, files in *italics*):

* **<top level directory>**
    * *CodeBook.md*
    * *README.md*
    * *run_analysis.R*
    * *tidy-dataset.csv*
    * **UCI HAR Dataset**
        * *activity_labels.txt*
        * *features_info.txt*
        * *features.txt*
        * *README.txt*
        * **test**
            * *subject_test.txt*
            * *X_test.txt*
            * *y_test.txt*
            * **Inertial Signals**
        * **train**
            * *subject_train.txt*
            * *X_train.txt*
            * *y_train.txt*
            * **Inertial Signals**

In my environment the top-level directory is named **smartphones**, as indicated by the Github repository name.

As indicated in the *README.md* file, when the *run_analysis.R* script is sourced all code is automatically executed. No functions need be called separately.

Description of the *run_analysis.R* Process
-------------------------------------------

The *run_analysis.R* script performs the following functions, although not necessarily in the order indicated.

1. Merges the training and the test data sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Walking through the code, the operations are as follows:

1. Get the data that maps the activity codes to their names (e.g. "1" = "WALKING", etc.).
2. Get the names of the columns for the X data. There are 561 unnamed columns of data in the *X_test.txt* and *X_train.txt* files. The *features.txt* files contains the names of the 561 columns (one column name per row, reading left to right).
3. As the project calls for using only those columns containing mean and standard deviation measurements from the X data, each of the column names gathered in step 2 above are assessed to determine whether they should be retained or dropped. This is saved in a logical vector so it can be used against both X datasets.
4. Get the test data.
    * First read the X data into a data frame. This uses the column names defined in step 2.
    * Read the subject data into a separate data frame.
    * Read the y (activity) data into a third data frame.
    * Combine the three data frames into a master data frame.
    * Transforms the activity codes to their text equivalents, using the data from step 1.
    * Drop the unneeded columns, as indicated by the logical vector created in step 3.
5. Get the training data, using the same process as in step 4.
6. Combine the test and training data (setps 4 and 5, respectively) into a full dataset.
7. Order the full dataset by Subject ID. (Although this was not specified by the exercise instructions, it makes the data easier to work with.)
8. At this point you could save off the full dataset, should you want to perform other operations on it. I did not, as it was not called for in the instructions.
9. Create the tidy dataset.
    * Use the ddply () function to create a data frame, calculating the means of every data column (i.e. all columns other than the Subject and Activity columns), grouping by Subject and Activity.
    * Modify the column names (all except Subject and Activity), appending "_mean" to indicate how the values have changed.
10. Save the tidy dataset to the file "tidy_dataset.csv" in CSV format.

The "tidy_dataset.csv" File
---------------------------

The *tidy_dataset.csv* file contains the following columns (variables):

"Subject"                              
"Activity"                             
"tBodyAcc.mean...X_mean"              
"tBodyAcc.mean...Y_mean"               
"tBodyAcc.mean...Z_mean"               
"tBodyAcc.std...X_mean"               
"tBodyAcc.std...Y_mean"                
"tBodyAcc.std...Z_mean"                
"tGravityAcc.mean...X_mean"           
"tGravityAcc.mean...Y_mean"            
"tGravityAcc.mean...Z_mean"            
"tGravityAcc.std...X_mean"            
"tGravityAcc.std...Y_mean"             
"tGravityAcc.std...Z_mean"             
"tBodyAccJerk.mean...X_mean"          
"tBodyAccJerk.mean...Y_mean"           
"tBodyAccJerk.mean...Z_mean"           
"tBodyAccJerk.std...X_mean"           
"tBodyAccJerk.std...Y_mean"            
"tBodyAccJerk.std...Z_mean"            
"tBodyGyro.mean...X_mean"             
"tBodyGyro.mean...Y_mean"              
"tBodyGyro.mean...Z_mean"              
"tBodyGyro.std...X_mean"              
"tBodyGyro.std...Y_mean"               
"tBodyGyro.std...Z_mean"               
"tBodyGyroJerk.mean...X_mean"         
"tBodyGyroJerk.mean...Y_mean"          
"tBodyGyroJerk.mean...Z_mean"          
"tBodyGyroJerk.std...X_mean"          
"tBodyGyroJerk.std...Y_mean"           
"tBodyGyroJerk.std...Z_mean"           
"fBodyAcc.mean...X_mean"              
"fBodyAcc.mean...Y_mean"               
"fBodyAcc.mean...Z_mean"               
"fBodyAcc.std...X_mean"               
"fBodyAcc.std...Y_mean"                
"fBodyAcc.std...Z_mean"                
"fBodyAcc.meanFreq...X_mean"          
"fBodyAcc.meanFreq...Y_mean"           
"fBodyAcc.meanFreq...Z_mean"           
"fBodyAccJerk.mean...X_mean"          
"fBodyAccJerk.mean...Y_mean"           
"fBodyAccJerk.mean...Z_mean"           
"fBodyAccJerk.std...X_mean"           
"fBodyAccJerk.std...Y_mean"            
"fBodyAccJerk.std...Z_mean"            
"fBodyAccJerk.meanFreq...X_mean"      
"fBodyAccJerk.meanFreq...Y_mean"       
"fBodyAccJerk.meanFreq...Z_mean"       
"fBodyGyro.mean...X_mean"             
"fBodyGyro.mean...Y_mean"              
"fBodyGyro.mean...Z_mean"              
"fBodyGyro.std...X_mean"              
"fBodyGyro.std...Y_mean"               
"fBodyGyro.std...Z_mean"               
"fBodyGyro.meanFreq...X_mean"         
"fBodyGyro.meanFreq...Y_mean"          
"fBodyGyro.meanFreq...Z_mean"          
"fBodyAccMag.meanFreq.._mean"         
"fBodyBodyAccJerkMag.meanFreq.._mean"  
"fBodyBodyGyroMag.meanFreq.._mean"     
"fBodyBodyGyroJerkMag.meanFreq.._mean"

These columns correspond to the columns described in the file *features_info.txt*, which came with the source dataset.