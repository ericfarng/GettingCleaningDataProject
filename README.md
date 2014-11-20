GettingCleaningDataProject
==========================

###Coursera's Getting and Cleaning Data - Course Project

This script will download the data set locally, unzip it, and create the tidy data set file. It requires that the library "reshape2" has been installed.

The working directory is a variable in the first line of the file.

After the files have been unzipped, all the training and test set files are merged into a new file. Consecutive spaces are removed for easier reading into tables.

The data is loaded from these new files. Tables are joined, mean/std columns are kept, and columns are renamed. Using reshape2, the data is melted and dcasted to compute the means.

The data was retrieved here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The first column in the tidy data set is the activity.
The second column is an indicator for which volunteer.
From the original 561-feature vector, only the mean and standard deviation columns were kept.
Then the mean for each activity/subject combination for these columns were computed.

##From the URL above:
###Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Check the README.txt file for further details about this dataset.


###Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
