Getting and Cleaning Data Course Project
===================


This repository contains files for the Project assessment for Getting and Cleaning data coursera course.
The idea was to process data collected from the accelerometers from the Samsung Galaxy S smartphone, and produce a nice tidy data set for the purpose of learning how to clean data. The data were obtained from this source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The following files are present in this repo:

* run_analysis.R - A script that when run will process all the samsung data (provided they are unzipped in the local working directory), both train set and test set, merge them together, and produce a tidy data set with the average of each variable for each activity and each subject. It will also write it to a file in the working directory.

 The run_analysis.R script contains detailed comments for each step of the process but here is a brief overview:
  * Load the test and train tables from working directory.
  * Extract the activity id, activity label, and subject id from files in the working directory.
  * Add columns in both train and test data sets with information on activity id, activity label, and subject id from the previous step.
  * Merge the two data sets.
  * Extract only the columns related to mean and standard deviation.
  * Tidy the data so that it shows the average of each variable for each activity and each subject.
  * Write the new tidy data set back to the local working directory.

* Code_book - A file explaining all the varialbes that are present in the tidy data set.

* tidy_set.txt - The tidy data set itslef.
