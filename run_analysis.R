## M.Zikic
## 2014-05-26
##
## The following script loads UCI HAR Datasets (training and testing), combines
## them and then creates a second, independant "tidy" data set, 
## containing only a subset of features from the original datasets
## the features kept are the mean and standard deviation measurements

library(plyr)
library(reshape2)

# general datasets (labels)
features <- read.table("~/GettingandCleaningDataAssignment/UCI HAR Dataset/features.txt")
activity_labels <- read.table("~/GettingandCleaningDataAssignment/UCI HAR Dataset/activity_labels.txt")

# train datasets 
# X_train contains measures
# y_train contains activity ids related to the measures
# subject_train contains list of subjects peforming tests
X_train <- read.table("~/GettingandCleaningDataAssignment/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("~/GettingandCleaningDataAssignment/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("~/GettingandCleaningDataAssignment/UCI HAR Dataset/train/subject_train.txt")

# test datasets
X_test <- read.table("/Users/djjo/GettingandCleaningDataAssignment/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("/Users/djjo/GettingandCleaningDataAssignment/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("~/GettingandCleaningDataAssignment/UCI HAR Dataset/test/subject_test.txt")

# combine the three files related to test data, create Source column to indicate where data comes from
# only a subset of 'means' have been selected from the original file.  this is because X, Y and Z specific 
# means are used to calculate the overall mean for the maesure, i.e.
# tBodyAccMeanX, tBodyAccMeanY and tBodyAccMeanZ are used to calculate tBodyAccMagMean.  
# if other means are needed it's as simple as uncommeting them out from the following.
test_data <- as.data.frame(cbind(
           Source = "test",
           SubjectId = subject_test$V1, 
           ActivityId = y_test$V1,
           # means
           #tBodyAccMeanX = X_test$V1,
           #tBodyAccMeanY = X_test$V2,
           #tBodyAccMeanZ = X_test$V3,
           #tGravityAccMeanX = X_test$V41,
           #tGravityAccMeanY = X_test$V42,
           #tGravityAccMeanZ = X_test$V43,
           #tBodyAccJerkMeanX = X_test$V81,
           #tBodyAccJerkMeanY = X_test$V82,
           #tBodyAccJerkMeanZ = X_test$V83,
           #tBodyGyroMeanX = X_test$V121,
           #tBodyGyroMeanY = X_test$V122,
           #tBodyGyroMeanZ = X_test$V123,
           #tBodyGyroJerkMeanX = X_test$V161,
           #tBodyGyroJerkMeanY = X_test$V162,
           #tBodyGyroJerkMeanZ = X_test$V163,
           tBodyAccMagMean = X_test$V201,
           tGravityAccMagMean = X_test$V214,
           tBodyAccJerkMagMean = X_test$V227,
           tBodyGyroMagMean = X_test$V240,
           tBodyGyroJerkMagMean = X_test$V253,
           #fBodyAccMeanX = X_test$V266,
           #fBodyAccMeanY = X_test$V267,
           #fBodyAccMeanZ = X_test$V268,
           #fBodyAccJerkMeanX = X_test$V345,
           #fBodyAccJerkMeanY = X_test$V346,
           #fBodyAccJerkMeanZ = X_test$V347,
           #fBodyGyroMeanX = X_test$V424,
           #fBodyGyroMeanY = X_test$V425,
           #fBodyGyroMeanZ = X_test$V426,
           fBodyAccMagMean = X_test$V503,
           fBodyBodyAccJerkMagMean = X_test$V516,
           fBodyBodyGyroMagMean = X_test$V529,
           fBodyBodyGyroJerkMagMean = X_test$V542,
           # std
           #tBodyAccStdX = X_test$V4,
           #tBodyAccStdY = X_test$V5,
           #tBodyAccStdZ = X_test$V6,
           #tGravityAccStdX = X_test$V44,
           #tGravityAccStdY = X_test$V45,
           #tGravityAccStdZ = X_test$V46,
           #tBodyAccJerkStdX = X_test$V84,
           #tBodyAccJerkStdY = X_test$V85,
           #tBodyAccJerkStdZ = X_test$V86,
           #tBodyGyroStdX = X_test$V124,
           #tBodyGyroStdY = X_test$V125,
           #tBodyGyroStdZ = X_test$V126,
           #tBodyGyroJerkStdX = X_test$V164,
           #tBodyGyroJerkStdY = X_test$V165,
           #tBodyGyroJerkStdZ = X_test$V166,
           tBodyAccMagStd = X_test$V202,
           tGravityAccMagStd = X_test$V215,
           tBodyAccJerkMagStd = X_test$V228,
           tBodyGyroMagStd = X_test$V241,
           tBodyGyroJerkMagStd = X_test$V254, 
           #fBodyAccStdX = X_test$V269, 
           #fBodyAccStdY = X_test$V270,
           #fBodyAccStdZ = X_test$V271,
           #fBodyAccJerkStdX = X_test$V348,
           #fBodyAccJerkStdY = X_test$V349,
           #fBodyAccJerkStdZ = X_test$V350,
           #fBodyGyroStdX = X_test$V427,
           #fBodyGyroStdY = X_test$V428,
           #fBodyGyroStdZ = X_test$V429,
           fBodyAccMagStd = X_test$V504,
           fBodyBodyAccJerkMagStd = X_test$V517,
           fBodyBodyGyroMagStd = X_test$V530,
           fBodyBodyGyroJerkMagStd = X_test$V543))

# same rules as per test dataset
train_data <- as.data.frame(cbind(
                   Source = "train",
                   SubjectId = subject_train$V1, 
                   ActivityId = y_train$V1,
                   # means
                   #tBodyAccMeanX = X_train$V1,
                   #tBodyAccMeanY = X_train$V2,
                   #tBodyAccMeanZ = X_train$V3,
                   #tGravityAccMeanX = X_train$V41,
                   #tGravityAccMeanY = X_train$V42,
                   #tGravityAccMeanZ = X_train$V43,
                   #tBodyAccJerkMeanX = X_train$V81,
                   #tBodyAccJerkMeanY = X_train$V82,
                   #tBodyAccJerkMeanZ = X_train$V83,
                   #tBodyGyroMeanX = X_train$V121,
                   #tBodyGyroMeanY = X_train$V122,
                   #tBodyGyroMeanZ = X_train$V123,
                   #tBodyGyroJerkMeanX = X_train$V161,
                   #tBodyGyroJerkMeanY = X_train$V162,
                   #tBodyGyroJerkMeanZ = X_train$V163,
                   tBodyAccMagMean = X_train$V201,
                   tGravityAccMagMean = X_train$V214,
                   tBodyAccJerkMagMean = X_train$V227,
                   tBodyGyroMagMean = X_train$V240,
                   tBodyGyroJerkMagMean = X_train$V253,
                   #fBodyAccMeanX = X_train$V266,
                   #fBodyAccMeanY = X_train$V267,
                   #fBodyAccMeanZ = X_train$V268,
                   #fBodyAccJerkMeanX = X_train$V345,
                   #fBodyAccJerkMeanY = X_train$V346,
                   #fBodyAccJerkMeanZ = X_train$V347,
                   #fBodyGyroMeanX = X_train$V424,
                   #fBodyGyroMeanY = X_train$V425,
                   #fBodyGyroMeanZ = X_train$V426,
                   fBodyAccMagMean = X_train$V503,
                   fBodyBodyAccJerkMagMean = X_train$V516,
                   fBodyBodyGyroMagMean = X_train$V529,
                   fBodyBodyGyroJerkMagMean = X_train$V542,
                   # std
                   #tBodyAccStdX = X_train$V4,
                   #tBodyAccStdY = X_train$V5,
                   #tBodyAccStdZ = X_train$V6,
                   #tGravityAccStdX = X_train$V44,
                   #tGravityAccStdY = X_train$V45,
                   #tGravityAccStdZ = X_train$V46,
                   #tBodyAccJerkStdX = X_train$V84,
                   #tBodyAccJerkStdY = X_train$V85,
                   #tBodyAccJerkStdZ = X_train$V86,
                   #tBodyGyroStdX = X_train$V124,
                   #tBodyGyroStdY = X_train$V125,
                   #tBodyGyroStdZ = X_train$V126,
                   #tBodyGyroJerkStdX = X_train$V164,
                   #tBodyGyroJerkStdY = X_train$V165,
                   #tBodyGyroJerkStdZ = X_train$V166,
                   tBodyAccMagStd = X_train$V202,
                   tGravityAccMagStd = X_train$V215,
                   tBodyAccJerkMagStd = X_train$V228,
                   tBodyGyroMagStd = X_train$V241,
                   tBodyGyroJerkMagStd = X_train$V254, 
                   #fBodyAccStdX = X_train$V269, 
                   #fBodyAccStdY = X_train$V270,
                   #fBodyAccStdZ = X_train$V271,
                   #fBodyAccJerkStdX = X_train$V348,
                   #fBodyAccJerkStdY = X_train$V349,
                   #fBodyAccJerkStdZ = X_train$V350,
                   #fBodyGyroStdX = X_train$V427,
                   #fBodyGyroStdY = X_train$V428,
                   #fBodyGyroStdZ = X_train$V429,
                   fBodyAccMagStd = X_train$V504,
                   fBodyBodyAccJerkMagStd = X_train$V517,
                   fBodyBodyGyroMagStd = X_train$V530,
                   fBodyBodyGyroJerkMagStd = X_train$V543))

# rename columns in the activity dataset
names(activity_labels) <- c("ActivityId","Activity")

# combine test, train and activity labels
all_data <- merge(rbind(test_data, train_data),activity_labels)

# produce cleansed dataset containint subject, activity and means
clean_df <- ddply(all_data,.(SubjectId, Activity), summarize, 
        # means
        tBodyAccMagMean = mean(as.numeric(levels(tBodyAccMagMean))[tBodyAccMagMean], na.rm=FALSE),
        tGravityAccMagMean = mean(as.numeric(levels(tGravityAccMagMean))[tGravityAccMagMean], na.rm=FALSE),
        tBodyAccJerkMagMean = mean(as.numeric(levels(tBodyAccJerkMagMean))[tBodyAccJerkMagMean], na.rm=FALSE),
        tBodyGyroMagMean = mean(as.numeric(levels(tBodyGyroMagMean))[tBodyGyroMagMean], na.rm=FALSE),
        tBodyGyroJerkMagMean = mean(as.numeric(levels(tBodyGyroJerkMagMean))[tBodyGyroJerkMagMean], na.rm=FALSE),
        fBodyAccMagMean = mean(as.numeric(levels(fBodyAccMagMean))[fBodyAccMagMean], na.rm=FALSE),
        fBodyBodyAccJerkMagMean = mean(as.numeric(levels(fBodyBodyAccJerkMagMean))[fBodyBodyAccJerkMagMean], na.rm=FALSE),
        fBodyBodyGyroMagMean = mean(as.numeric(levels(fBodyBodyGyroMagMean))[fBodyBodyGyroMagMean], na.rm=FALSE),
        fBodyBodyGyroJerkMagMean = mean(as.numeric(levels(fBodyBodyGyroJerkMagMean))[fBodyBodyGyroJerkMagMean], na.rm=FALSE),
        # std
        tBodyAccMagStd = mean(as.numeric(levels(tBodyAccMagStd))[tBodyAccMagStd], na.rm=FALSE),
        tGravityAccMagStd = mean(as.numeric(levels(tGravityAccMagStd))[tGravityAccMagStd], na.rm=FALSE),
        tBodyAccJerkMagStd = mean(as.numeric(levels(tBodyAccJerkMagStd))[tBodyAccJerkMagStd], na.rm=FALSE),
        tBodyGyroMagStd = mean(as.numeric(levels(tBodyGyroMagStd))[tBodyGyroMagStd], na.rm=FALSE),
        tBodyGyroJerkMagStd = mean(as.numeric(levels(tBodyGyroJerkMagStd))[tBodyGyroJerkMagStd], na.rm=FALSE),
        fBodyAccMagStd = mean(as.numeric(levels(fBodyAccMagStd))[fBodyAccMagStd], na.rm=FALSE),
        fBodyBodyAccJerkMagStd = mean(as.numeric(levels(fBodyBodyAccJerkMagStd))[fBodyBodyAccJerkMagStd], na.rm=FALSE),
        fBodyBodyGyroMagStd = mean(as.numeric(levels(fBodyBodyGyroMagStd))[fBodyBodyGyroMagStd], na.rm=FALSE),
        fBodyBodyGyroJerkMagStd = mean(as.numeric(levels(fBodyBodyGyroJerkMagStd))[fBodyBodyGyroJerkMagStd], na.rm=FALSE) 
)


# write the dataset to a file
write.table(clean_df, file="UCI_HAR_DataSet_Clean.txt", sep=" ", row.names = TRUE)





