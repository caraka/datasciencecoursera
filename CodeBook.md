## CodeBook for Cleaning Data Project

The client specifications:

#### You should create one R script called run_analysis.R that does the following:
 
* Merges the training and the test sets to create one data set.

* Extracts only the measurements on the mean and standard deviation for each measurement.
 
* Uses descriptive activity names to name the activities in the data set.

* Appropriately labels the data set with descriptive activity names.

* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Step 1

* The data was imported into R. 

* The training and test sets were reassembled independently using cbind() to combine the subject, activity and observation data sets.

* The training and test sets were combined into one set using rbind().

* The column names were imported and applied to the master set.

### Step 2

The mean() and std() data for the X, Y and Z axis were subsetted. These were chosen because they represent the first order of estimation from the raw signal data and form logical pairs for furhter analysis based on this summary data. 

meanFreq(), gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean and tBodyGyroJerkMean were not brought into the subset as they represent second order estimations from the raw signal data.

### Step 3

The Activity names in the provided data  were numeric and not particularly useful in a summary table of means and standard deviations like the one being produced.

The descriptions added were provided by the client in a separate file, so those names were used. A column of human readable activity names was appended to the data, based on the id codes already present, while preserving the original activity id codes should they be required.

The added activity codes (variable = activitydesc):

* Walking

* Walking_Upstairs

* Walking_Downstairs

* Sitting

* Standing

* Laying

### Step 4

While not clear in the initial spec, the nature of this step was to make the variable labels conform to the client's wishes. This involved removing non-standard characters such as () and -, as well as making the names all lower case for easy typing when querying the tidy summary data set.

The gsub() and tolower() functions in R were used for this task.

For example, the variable fBodyAcc-std()-X has been renamed fbodyaccstdx.

## Step 5

A second, tidy data set that only includes the means for each subject/activity was generated in R using the aggregate.data.frame() function on the $subject and $activitydesc variables.

This was then written to a tab delimited file named AverageSubjectActivities.txt and provided to the client.

==================================================================

This script was written using RStudio Version 0.98.507 and R version 3.1.0 (2014-04-10) -- "Spring Dance" on Ubuntu 1404 LTS x64

==================================================================

## License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

==================================================================

Human Activity Recognition Using Smartphones Dataset
Version 1.0

==================================================================

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory

DITEN - Università degli Studi di Genova.

Via Opera Pia 11A, I-16145, Genoa, Italy.

activityrecognition@smartlab.ws

www.smartlab.ws

==================================================================