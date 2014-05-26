## CodeBook for Cleaning Data Project

The client had a couple of specifications

#### You should create one R script called run_analysis.R that does the following:
 
* Merges the training and the test sets to create one data set.

* Extracts only the measurements on the mean and standard deviation for each measurement.
 
* Uses descriptive activity names to name the activities in the data set.

* Appropriately labels the data set with descriptive activity names.

* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Step 1

* The data was imported into R. 

* The training and test sets were reassembled independently using cbind to combine the subject, activity and observation data sets.

* The training and test sets were combined into one set using rbind.

* The column names were imported and applied to the master set.

### Step 2

The mean() and std() data for the X, Y and Z axis were subsetted. These were chosen because they represent the first tier of estimation from the raw signal data. 

meanFreq(), gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean and tBodyGyroJerkMean were not brought into the subset as they represent 2 order estimations from the raw signal data.

### Step 3

The Activity names in the provided data  were numeric and not particularly useful in a summary table of means and standard deviations like the one being produced.

These descriptions were provided by the client in a separate file, so these names were used. A column of human readable activity names was appended to the data, based on the id codes already present.

### Step 4

While not clear in the spec, the nature of this step was to make the variable labels conform to the client's wishes. This involved removing non-standard characters such as () and -, as well as making the names all lower case for easy typing when querying the tidy summary data set.

The gsub() and tolower() functions in R were used for this task.

For example, the variable fBodyAcc-std()-X has been renamed fbodyaccstdx.

## Step 5

A second, tidy data set that only includes the means for each subject/activity was generated in R using the aggregate.data.frame() function on the $subject and $activitydesc variables.

This was then written to a tab delimited file named AverageSubjectActivities.tx and provided to the client.