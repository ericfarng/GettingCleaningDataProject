workingDirectory = "~/coursera/Getting and Cleaning Data/Assignment 2"


# download and unzip the file
dir.create(file.path(workingDirectory), showWarnings = FALSE)
setwd(workingDirectory)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile=paste(workingDirectory, "/Dataset.zip", sep=""), method="wget")
library(utils)
unzip(paste(workingDirectory, "/Dataset.zip", sep=""))


# combine all pairs of train/test set files into a single file into "allDir"
dataDir = paste(workingDirectory, "/UCI HAR Dataset/", sep="")
trainDir = paste(workingDirectory, "/UCI HAR Dataset/train/", sep="")
testDir = paste(workingDirectory, "/UCI HAR Dataset/test/", sep="")
allDir = paste(workingDirectory, "/UCI HAR Dataset/all/", sep="")

dir.create(file.path(allDir), showWarnings = FALSE)
dir.create(file.path(paste(allDir, "/Inertial Signals", sep="")), showWarnings = FALSE)

combineFile <- function(filename) {
    allFilename = gsub("train", "all", filename)
    outfile <- file(paste(allDir, allFilename,sep=""), open="w+")
    
    dat <- readLines(paste(trainDir, filename, sep=""))
    dat <- lapply(dat, function(x) {paste("train", x, sep=" ")})
    dat <- gsub("  ", " ", dat)
    dat <- gsub("  ", " ", dat)
    writeLines(as.character(dat),outfile)
    
    testFilename = gsub("train", "test", filename)
    dat <- readLines(paste(testDir, testFilename, sep=""))
    dat <- lapply(dat, function(x) {paste("test", x, sep=" ")})
    dat <- gsub("  ", " ", dat)
    dat <- gsub("  ", " ", dat)
    writeLines(as.character(dat),outfile)
    
    close(outfile)
    allFilename
}

# loop through all files and sapply the function
trainFiles <- list.files(trainDir, recursive=TRUE)
fileNames <- sapply(trainFiles, combineFile)

# read the data we care about
activity <- read.table(paste(allDir, "y_all.txt",sep=""))
subject <- read.table(paste(allDir, "subject_all.txt",sep=""))
feature <- read.table(paste(allDir, "x_all.txt",sep=""))
featureLabel <- read.table(paste(dataDir, "features.txt", sep=""))

# read the activity labels and create a vector of activities
activityLabel <- read.table(paste(dataDir, "activity_labels.txt", sep=""))
activityLabelled <- sapply(activity[,2], function(x) {as.character(activityLabel[x, 2])})

# include a column for train/test set and rename columns
names(feature) <- c("Data Set", as.character(featureLabel[,2]))
names(subject) <- c("Data Set", "Subject")

# keep only mean or std variables and rename column
dataSet <- cbind(subject, activityLabelled, feature[,grep("(mean|std)", names(feature))])
names(dataSet)[3] = "Activity"

#head(dataSet[,1:10])

# melt and dcast the data to get tidy data in wide format
library(reshape2)
melted <- melt(dataSet, id=c("Activity", "Subject"), measure.vars=names(dataSet[4:ncol(dataSet)]))
dcasted <- dcast(melted, Activity + Subject ~ variable, mean)
write.table(dcasted, file=paste(workingDirectory, "/measurementMean.txt", sep=""), row.names=FALSE)
