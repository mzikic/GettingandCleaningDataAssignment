Gettinga and Cleaning Data Assignment
================================

Summary
--------------------------------
Author: M.Zikic
Date 2014-05-26

The following script loads UCI HAR Datasets (training and testing), combines
them and then creates a second, independant "tidy" data set, 
containing only a subset of features from the original datasets
the features kept are the mean and standard deviation measurements.

Prerequisites
--------------------------------
plyr package
datasets (input files) need to be in the subdirectory "UCI HAR Dataset"

Logic
--------------------------------

1. General datasets are loaded.  These include
   a. features
   b. activity_labels

2. Data files are loaded.  These include
   a. X_train, y_train, subject_train
   b. X_test, y_test, subject_test

   X_train contains measures
   y_train contains activity ids related to the measures
   subject_train contains list of subjects peforming tests

3. Merge Files

combine the three files related to test data, create Source column to indicate where data comes from.  Only a subset of 'means' have been selected from the original file.  this is because X, Y and Z specific means are used to calculate the overall mean for the maesure, i.e.
 tBodyAccMeanX, tBodyAccMeanY and tBodyAccMeanZ are used to calculate tBodyAccMagMean.  if other means are needed it's as simple as uncommeting them out from the following.

4. Means are calculated using ddply from plyr package.


