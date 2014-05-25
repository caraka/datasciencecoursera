#*****************************************************************************

# This script assumes that the UCI Har Dataset folder is the working directory
# and the data is present.

#*****************************************************************************

## Import and assemble the training data

subtrain <- read.table("./train/subject_train.txt")
xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/y_train.txt", stringsAsFactors=FALSE)

# combine the columns Subject, Activity, Observations
train <- cbind(subtrain, ytrain, xtrain)

# Import and assemble the testing data
subtest <- read.table("./test/subject_test.txt")
xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/y_test.txt", stringsAsFactors=FALSE)

# combine the columns Subject, Activity, Observations
test <- cbind(subtest, ytest, xtest)

# Bind the training and testing observations together:
data <- rbind(train, test)

# Import the variable names and pre-pend the subject and activity names
vnames <- read.table("features.txt")
vnames <- as.vector(vnames[,2])
vnames <- c("subject", "activityid", vnames)

# Assign the names to the data frame
colnames(data) <- vnames

# Break up the data frame, selecting only the columns we want
people <- data[,1:2]
deviants <- data[,grepl("-std()-", colnames(data), fixed = TRUE)]
meanies <- data[,grepl("-mean()-", colnames(data), fixed = TRUE)]

# Bind the columns we want and sort them by name
data <- cbind(meanies, deviants)
data <- data[,sort(names(data))]

# Create a vector with more descriptive activity names from the activity id's
activitydesc <- people[,2]
# TODO Find idiomatic way to do this
activitydesc[activitydesc==1] <- "Walking"
activitydesc[activitydesc==2] <- "Walking_Upstairs"
activitydesc[activitydesc==3] <- "Walking_Downstairs"
activitydesc[activitydesc==4] <- "Sitting"
activitydesc[activitydesc==5] <- "Standing"
activitydesc[activitydesc==6] <- "Laying"

# bind the original subject column, the new activity descriptions and the id's
people <- cbind(people[,1], activitydesc, people[,2])
colnames(people) <- c("subject", "activitydesc", "activityid")

# Re-combine the subject and activity columns with the data columns
data <- cbind(people, data)

# Let's clean up the variable names to meet client's spec
x <- colnames(data)
# TODO find idiomatic method to clean the labels
x <- gsub("\\(\\)", "", x)
x <- gsub("-", "", x)
x <- tolower(x)
colnames(data) <- x

# Before we aggregate the data, let's make sure we've got numeric columns out front
data[,3] <- sapply(data[,3], as.numeric)
data[,1] <- sapply(data[,1], as.numeric)

# Aggregate the data frame based on subject and activity, taking the mean
avg_sub_act <- aggregate.data.frame(data[,3:51], list(data$subject, data$activitydesc), mean)

# rename the two columns we aggregated by
colnames(avg_sub_act)[1:2] <- c("subject", "activitydesc")

# Clean up the row names before wrting to a txt file
rownames(avg_sub_act) <- NULL

# Write the tidy data set to file
write.table(avg_sub_act, "AverageSubjectActivities.txt", sep="\t", row.names=FALSE)
