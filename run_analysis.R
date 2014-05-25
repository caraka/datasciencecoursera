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

vnames <- read.table("features.txt")
vnames <- as.vector(vnames[,2])
vnames <- c("subject", "activityid", vnames)

colnames(data) <- vnames

people <- data[,1:2]
deviants <- data[,grepl("-std()-", colnames(data), fixed = TRUE)]
meanies <- data[,grepl("-mean()-", colnames(data), fixed = TRUE)]

data <- cbind(meanies, deviants)
data <- data[,sort(names(data))]


activitydesc <- people[,2]
# TODO Find idiomatic way to do this
activitydesc[activitydesc==1] <- "Walking"
activitydesc[activitydesc==2] <- "Walking_Upstairs"
activitydesc[activitydesc==3] <- "Walking_Downstairs"
activitydesc[activitydesc==4] <- "Sitting"
activitydesc[activitydesc==5] <- "Standing"
activitydesc[activitydesc==6] <- "Laying"

people <- cbind(people[,1], activitydesc, people[,2])
colnames(people) <- c("subject", "activitydesc", "activityid")

data <- cbind(people, data)
x <- colnames(data)
# TODO find idiomatic method to clean the labels
x <- gsub("\\(\\)", "", x)
x <- gsub("-", "", x)
x <- tolower(x)

colnames(data) <- x

data[,3] <- sapply(data[,3], as.numeric)
data[,1] <- sapply(data[,1], as.numeric)

avg_sub_act <- aggregate.data.frame(data[,3:51], list(data$subject, data$activitydesc), mean)
colnames(avg_sub_act)[1:2] <- c("subject", "activitydesc")
rownames(avg_sub_act) <- NULL
write.table(avg_sub_act, "AverageSubjectActivities.txt", sep="\t", row.names=FALSE)
