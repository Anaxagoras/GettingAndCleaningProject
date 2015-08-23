runAnalysis <- function(){
    # Read in the various data files.
    activities <- read.table("UCI\ HAR\ Dataset/activity_labels.txt")
    features <- read.table("UCI\ HAR\ Dataset/features.txt")
    
    testSubject <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")
    testX <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")
    testY <- read.table("UCI\ HAR\ Dataset/test/y_test.txt")
    
    trainSubject <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")
    trainX <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
    trainY <- read.table("UCI\ HAR\ Dataset/train/y_train.txt")
    
    # Staple the participant IDs and activity IDs onto the test and training
    # data sets, then staple those data sets together.
    combinedTest <- cbind(testSubject, testY, testX)
    combinedTrain <- cbind(trainSubject, trainY, trainX)
    combinedData <- rbind(combinedTest, combinedTrain)
    
    # Prune the features to only keep those that measure mean or standard
    # deviation.
    featuresMeanStd <- which(
        grepl("mean()", features$V2, fixed=TRUE) 
        | grepl("std()", features$V2, fixed=TRUE)
        )
    featuresToKeep <- c(1L, 2L, featuresMeanStd + 2L)
    dataMeanStd <- combinedData[, featuresToKeep]
    
    # Edit the column names to reflect the underlying features.
    colnames(dataMeanStd) <- c("SubjectID", "Activity",
                               as.character(features[featuresMeanStd, 2]))
    
    # Replace the opaque activity IDs with one that gives the name of the
    # activity.
    dataMeanStd$Activity <- factor(dataMeanStd$Activity,
                                   labels = as.character(activities$V2))
    
    # Melts and casts the dataset to get the means for each combination
    # of subject and activity.
    meltedData <- reshape2::melt(dataMeanStd, id.vars=c("SubjectID", "Activity"))
    averages <- reshape2::dcast(meltedData, SubjectID + Activity ~ variable, mean)
}