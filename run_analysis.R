####
# This script does the following, not necessarily in the listed order.
#
# 1. Merges the training and the test data sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##########
# VARIABLE DEFINITION
#
# This section lists the variables used in multiple functions, either getting or setting their values. It also 
# provides a convenient location to document each variable's use, for data exploration and debugging purposes.
#
# activity_data : Map of activity codes to named values (i.e. 1 = "WALKING", etc.) as a data frame
# cols : Logical vector indicating the columns to "keep" (i.e. Subject, Activity, and those with mean() or std())
# full : Data frame containing the subject, x, and y (activity) data from both the test and training sets.
# labels : Data frame with the labels to each of the 561 columns in the X data files.
# test : Data frame containing the subject, x, and y (activity) data from the test set.
# tidy : 
# train : Data frame containing the subject, x, and y (activity) data from the training set.
##########

########## START OF UTILITY FUNCTIONS ##########

##########
# Reads the "activity_labels.txt" file into the data frame 'activity_data'. This variable will be used to map
# activity codes to text values.
##########
getActivity <- function () {
    activity_data <<- read.table ("UCI HAR Dataset/activity_labels.txt")
}

##########
# Calculates which of the columns in the test and training data to discard. It looks at the name of each column,
# referencing the 'labels' variable, matching exactly on "Subject"or "Activity", or partially on ".mean..." or 
# ".std..." It sets the logical vector 'cols' indicating which columns are a match. Note that this function is aware
# of the two columns added beyond those provided by the 'labels' data frame, and that the label names get transformed
# when the data is read in by read.table (). (Specifically, "-mean()-" is transformed to ".mean..." and "-std()-"
# to ".std...".) 
##########
getColumns <- function () {
    col_labels <- c ("Subject", "Activity", as.character (labelnames$V2))
    cols <<- (col_labels == "Subject" | col_labels == "Activity" | grepl (".mean...", col_labels) | 
                  grepl (".std...", col_labels))
}

##########
# Reads the "features.txt" into the data frame 'labels'. This variable will be used to add column names to the X data.
##########
getLabels <- function () {
    labelnames <<- read.table ("UCI HAR Dataset/features.txt")
}

##########
# Reads the "X_test.txt", "subject_test.txt", and "y_test.txt" data files, combining them into a single data frame,
# and then subsetting the data frame to include only those columns indicated by the 'cols' variable. The final data
# is loaded into the variable 'test'.
##########
getTest <- function () {
    # Read in the test data.
    test_data <- read.table ("UCI HAR Dataset/test/X_test.txt", 
                             col.names = as.character (labelnames$V2))  # Produces 2947 obs of 561 vars
    test_subjects <- read.table ("UCI HAR Dataset/test/subject_test.txt", 
                                 col.names = "Subject")  # Produces 2947 obs of 1 var
    test_activity <- read.table ("UCI HAR Dataset/test/y_test.txt", 
                                 col.names = "Activity")  # Produces 2947 obs of 1 var
    test_full <- cbind (test_subjects, test_activity, test_data)  # Produces 2947 obs of 563 vars
    test_full$Activity <- factor (test_full$Activity, levels = activity_data$V1, labels = activity_data$V2)
    test <<- test_full [cols]
}

##########
# Reads the "X_train.txt", "subject_train.txt", and "y_train.txt" data files, combining them into a single data frame,
# and then subsetting the data frame to include only those columns indicated by the 'cols' variable. The final data
# is loaded into the variable 'train'.
##########
getTrain <- function () {
    # Read in the training data.
    train_data <- read.table ("UCI HAR Dataset/train/X_train.txt",
                              col.names = as.character (labelnames$V2))  # Produces 7352 obs of 561 vars
    train_subjects <- read.table ("UCI HAR Dataset/train/subject_train.txt", 
                                  col.names = "Subject")  # Produces 7352 obs of 1 var
    train_activity <- read.table ("UCI HAR Dataset/train/y_train.txt", 
                                  col.names = "Activity")  # Produces 7352 obs of 1 var
    train_full <- cbind (train_subjects, train_activity, train_data)  # Produces 7352 obs of 563 vars
    train_full$Activity <- factor(train_full$Activity, levels = activity_data$V1, labels = activity_data$V2)
    train <<- train_full [cols]
}

########## END OF UTILITY FUNCTIONS ##########

########## START OF MAIN CODE ##########

# Do all of the preparatory file reading and data transformations.
if (!exists ("activity_data")) getActivity ()
if (!exists ("labelnames")) getLabels ()
if (!exists ("cols")) getColumns ()
if (!exists ("test")) getTest ()
if (!exists ("train")) getTrain ()

# Merge the data sets into one.
if (!exists ("full")) {
    full <- rbind (test, train)
    full <- full [order (full$Subject),]  # Sort the data by Subject ID
    # Save some memory by flushing the previous data sets from memory.
    rm (test)
    rm (train)
}

# Now create a tidy data set with the mean of each variable for each activity and each subject.
if (!exists ("tidy")) {
    library (plyr)
    # Group on Subject and Activity, calculating the mean of every other column in the set.
    tidy <- ddply (full, .(Subject, Activity), .fun = function (x) {
        colMeans (x [, -c(1:2)])
        })
    # Modify the data column names by appending "_mean".
    colnames (tidy)[-c(1:2)] <- paste (colnames (tidy)[-c(1:2)], "_mean", sep = "")
}

# Save the tidy data as a file. I use CSV for convenience.
write.csv (tidy, "tidy_dataset.csv")

########## END OF MAIN CODE ##########
