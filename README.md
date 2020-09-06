---
title: "Human Activity Recognition Using Smartphones Dataset (Tidy) v1.0"
output:
  html_document: default
  pdf_document: default
---

## Contents
- **README.txt**: This file.
- **features.txt**: Code book for the data columns.
- **tidydata.txt**: Tidy data set containing means and standard deviations of the mesurements explained below.
- **avgdata.txt**: An independent tidy data set with the average of each variable for each activity and each subject in the tidydata.txt data set.
- **run_analysis.R**: R Script used to create the above two tidy datasets from the original data set.

## Details
This dataset is tidied up data from the original data collected and formatted by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. [1].  The original data set is provided as part of the Coursera course "Getting and Cleaning Data" [2].  A full description of the original dataset can be found at: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

There are 5 different measurements gathered in the original data set (in (T)ime Domain):

- **BodyAcc** (Body Acceleration),
- **BodyAccJerk** (Body acceleration jerk signals derived from body linear acceleration and angular velocity),
- **BodyGyro** (Body Angular velocity),
- **BodyGyroJerk** (Body gyro jerk signals derived from body linear acceleration and angular velocity)
- **GravityAcc** (Gravity Acceleration)
	
For each of these measurements, there are X, Y, Z components, and the overall (Mag)ntitude.

For (F)requency domain only first three measurements are taken, along with their X, Y, Z components and the overall (Mag)ntitude.  Apart from these in (F)requency domain, there is one more measurement BodyBodyGyroJerk with only (M)agnitude.

More details of the measurements are found in "features_info.txt" in the original dataset.

In this tidy dataset only mean and standard deviations are taken for all the above measurements, (Domain, Measurement, Component) combinations.  For the purposes of readability, in this dataset, we removed the dash ("-") and brackets from the feature names, and instead used camel case notation.  For example feature name, "fBodyAccJerk-mean()-X" is replaced with "FBodyAccJerkMeanX".  The details of the conversion is captured in the "camelCase" R-function in the accompanied "run_analysis.R" script.

Each row in the tidy dataset also contains the identification of the subject who performed the activity (provided in the "subject" coolumn), along with the activity name (provided in the "activity" column).  The activiy lables are provided in the original data set in "activity_labels.txt" file.  For readability purposes, in this tidy data set, we used camel case of the activity name as opposed to the id representing the activity.  For example activity "WALKING_UPSTAIRS" became "Walking Upstairs".

A second tidy dataset containing the averages on each of the 66 measurements captured in the previous tidy data set by activity by subject.

A codebook is provided with all the eature names.  Detailed description is provided in the original data set in the file "features_info.txt".

Generation of this tidy datasets from the original dataset is captured in the accompanied "run_analysis.R" script.

## Observations
- Features are normalized and bounded within [-1,1].
- There are 30 subjects who performed 6 different activities - Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying

## References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

[2] Coursera course "Getting and Cleaning Data" - <https://www.coursera.org/learn/data-cleaning>