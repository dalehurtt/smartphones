Human Activity Recognition Using Smartphones Dataset
===========

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

This projects uses the Human Activity Recognition Using Smartphones Dataset available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The data for the project is at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

In addition the R script requires you to have installed the *plyr* package. If you have not done so already your will
have to execute:

```
install.packages ("plyr")
```

Preparation
-----------

In order to run the analysis on this data, create a directory that contains this *README.md* file, the *CodeBook.md* file, and the R script *run_analysis.R*. (I named my directory **smartphones**.) In addition, download the ZIP archive indicated above and extract it into the directory. This will create a data directory named **UCI HAR Dataset**. The directory structure will thus be as follows:

* smartphones
    * UCI HAR Dataset
        * test
        * train

With the above data downloaded and the directory structure set as indicated, set your working directory to the top level directory (in this example, to the **smartphones** directory), then source the R script. For example:

```
setwd ("~/smartphones")
source ("run_analysis.R")
```

Executing the Script
--------------------

By sourcing the *run_analysis.R* script (see above) the code is automatically run. All functions are executed in their proper order. At the end of the run the file *tidy_dataset.csv* is created, residing in the same directory as the *run_analysis.R* script.