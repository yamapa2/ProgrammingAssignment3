## Create a data folder to save all the downloaded data
if(!file.exists("data"))
    dir.create("data")

## If data is not downloaded yet, download the dataset from the web location
if(!file.exists("data/dataset.zip"))
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data/dataset.zip")

## If the dataset zip file is not extracted yet, unzip the downloaded data file
if(!file.exists("data/UCI HAR Dataset"))
    unzip("data/dataset.zip", exdir = "data")

## Utility function to create a camel case notation from a given phrase
## c1, c2 are word separators in the incoming and outgoing phrases  respectively
camelCase <- function(phrase, c1, c2) {
    capitalize <- function(word) paste0(toupper(substring(word, 1, 1)), substring(word, 2, nchar(word)))
    sapply(strsplit(phrase, c1), function(word) paste(capitalize(word), collapse=c2))
}

## Read feature list, extract mean and std features, remove brackets and create a camel case names
features <- read.table("data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
efindices <- grep("(mean\\(\\))|(std\\(\\))", features$V2)
efnamesorig <- features$V2[efindices]
efnames <- camelCase(gsub("\\(\\)", "", efnamesorig), "-", "")

## Read activity labels and create camel case names
activitylabels <- read.table("data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
activitylabels <- camelCase(tolower(activitylabels$V2), "_", " ")   ## use lower case for the entire label before applying camel case

## Read x_train dataset, extract mean and std and columns and rename the column names to match to feature names
xtrain <- read.table("data/UCI HAR Dataset/train/X_train.txt")
xtrain <- xtrain[, efindices]
names(xtrain) <- efnames

## Read y_train dataset, rename the column heading and replace the activity id with the corresponding label
ytrain <- read.table("data/UCI HAR Dataset/train/Y_train.txt")
names(ytrain) <- c("Activity")
ytrain$Activity <- factor(ytrain$Activity)
levels(ytrain$Activity) <- activitylabels

## Read subject_train dataset, rename the column heading to "subject"
strain <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
names(strain) <- c("Subject")

## Read x_test dataset, extract mean and std and columns and rename the column names to match to feature names
xtest <- read.table("data/UCI HAR Dataset/test/X_test.txt")
xtest <- xtest[, efindices]
names(xtest) <- efnames

## Read y_train dataset, rename the column heading and replace the activity id with the corresponding label
ytest <- read.table("data/UCI HAR Dataset/test/Y_test.txt")
names(ytest) <- c("Activity")
ytest$Activity <- factor(ytest$Activity)
levels(ytest$Activity) <- activitylabels

## Read subject_train dataset, rename the column heading to "subject"
stest <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
names(stest) <- c("Subject")

## Combine all the data sets into a single data frame (Subject, Activity and Measurements)
tidydata <- rbind(cbind(strain, ytrain, xtrain), cbind(stest, ytest, xtest))

## Create a tidy folder to save all the tidy data
if(!file.exists("tidy"))
    dir.create("tidy")

## Write tidy data
write.table(tidydata, "tidy/tidydata.txt", row.names = FALSE)

library(reshape2)

## Melt the tidy data set keeping the Subject and Activity
tdmelted <- melt(tidydata, id = c("Subject", "Activity"))

## Summarize melted data with dcast using "mean" aggregation
avgdata <- dcast(tdmelted, Subject + Activity ~ variable, mean)

## Write second tidy data (summarized averages of each variable for each activity and each subject)
write.table(avgdata, "tidy/avgdata.txt", row.names = FALSE)

## Create code book
tdfdescr <- sapply(efnamesorig, function(f) {
    paste(": Feature named, '", f, "', from original data set", sep="")
})
tdfdescr[length(tdfdescr)+1] = ": Activity performed"
tdfdescr[length(tdfdescr)+1] = ": Identification of the subject who performed the activity"

tidyfeatures <- data.frame(1:dim(tidydata)[2], names(tidydata), tdfdescr)

## Write out (codebook)
write.table(tidyfeatures, "tidy/features.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)