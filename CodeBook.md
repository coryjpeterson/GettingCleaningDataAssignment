---
title: "CodeBook.md"
output: html_document
---

This document outlines the variables, the data, and any tranformation performed by run_analysis.R on the data set described in README.md.

---
Library packages used: DPLYR

Input: The run_analysis.R program must be run in the UCI HAR Dataset folder of the data set provided above.  This directory contains the README.txt file for the data.

Output: Two data frames (cleandata, and cleandatasummary) and a txt file (SummaryTidyData.txt.)
    
---
Data Frame:  cleandata

Contents: Contains the tidy data set of both training and test data along with the subject and activity performed at the point of the measurement.

Variables:
- Subject - integer vector of type integer representing the subject ID for the measurement.
- Activity - character vector of type character representing the activity performed at the time of the measurement.
- Mean - numeric vector of type double representing the mean of all measurements for that observation.
- SD - numeric vector of type double representing the standard deviation of all measurement for that observation.

---
Data Frame: cleandatasummary

Contents: Contains the tidy data set summary of cleandata containing the average of each variable for each activity and each subject.

Variables:
- Subject - integer vector of type integer representing the subject ID for the measurement.
- Activity - character vector of type character representing the activity performed at the time of the measurement.
- Average Mean - numeric vector of type double representing the average over each subject and activity of the mean of all measurements for that observation.
- Average SD - numeric vector of type double representing the average over each subject and activity of the standard deviation of all measurement for that observation.

---
Transformation Overview:

1. The training and test data was read into independent data.frames.  Six files total: test and training (x,y,subject)
2. The x_train and x_test data measurements were used to calculate each observation (row) mean and sd.  The train and test tables were overwritten with two vectors for mean and average
3. A DPLYR data frame was created consolidating x,y,subject tables for both training and test.  This left us with two data frames for training and test with 4 variables (subject,activity,mean, and standard deviation)
4. New column names for the two data frames were written to be more descriptive. (Subject, Activity, Mean, SD)
5. The two data frames, training and test, were row binded together forming one data set.
6. The Activity variable was transformed from its integer representation for variable to a more descriptive verb. (see activity_labels.txt from the original data source)
7. The cleandata dataframe represents the steps 1 through 6.  The next steps are how cleandatasummary was transformed.
8. Using the data frame, cleandata, the data frame was grouped by Subject and Activity then all other variable (Mean and SD) were used to calculate the average across those groups.  This was saved as a new data frame cleandatasummary.
9. For cleandatasummary, variables Mean and SD were renamed to reflect they are now averages over the groups. (Average Mean, and Average SD)

