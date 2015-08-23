# Code Book
My columns closely match the features of the original UCI HAR data set. A good understanding of these may be found in that data set's data dictionary, from which I have reproduced the relevant section here:
> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
> 
> These signals were used to estimate variables of the feature vector for each pattern:  '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. 
> * tBodyAcc-XYZ
> * tGravityAcc-XYZ
> * tBodyAccJerk-XYZ
> * tBodyGyro-XYZ
> * tBodyGyroJerk-XYZ
> * tBodyAccMag
> * tGravityAccMag
> * tBodyAccJerkMag
> * tBodyGyroMag
> * tBodyGyroJerkMag
> * fBodyAcc-XYZ
> * fBodyAccJerk-XYZ
> * fBodyGyro-XYZ
> * fBodyAccMag
> * fBodyAccJerkMag
> * fBodyGyroMag
> * fBodyGyroJerkMag
>
> The set of variables that were estimated from these signals are: 
> * mean(): Mean value
> * std(): Standard deviation
> 
> [Remainder of variables omitted]

There are three major places where my tidy data set departs from the UCI HAR one. Firstly, I include the subject ID and activity in the data set, rather than having them in separate files. I also have changed the activity signifiers from numbers to descriptive names.

Secondly, I've thrown out most of the derived variables, keeping only mean() and std(), in accordance with the project requirements. As discussed in README.md, other variables containing the word "mean" do not appear to actually represent averages of the features.

Thirdly, each column after the SubjectId and Activity columns (which are unitless) represents the mean of all measurements of a feature. Note that taking the mean will not affect the units, so the summary statistics will have the same units as the underlying ones.

Since there are 33 signals after separating out the X, Y, and Z axial components where relevant, and I used two variables for each signal, along with the participant and activity identifiers, there are 2 + 33 * 2 = 68 columns to my final data set. As there is one row for each combination of one of the thirty test subjects and one of the six activities, there are 30 * 6 = 180 rows.

To help the reader understand the columns, they have been titled with the underlying signal and variable, as "tBodyAccMag-std()" or "fBodyAcc-mean()-X". The exceptions to this are the first two columns, labeled "SubjectID" and "Activity" respectively. Activity now is populated with the name of the activity, rather than an opaque number.

To achieve this, I stapled together the sundry data sets provided in the UCI HAR data set from both the Test and Train compenents. I then used grepl to subset only those columns corresponding to mean and standard deviation variables, then relabled the data set as described above. Lastly, I used the library reshape2's melt and dcast functions to find summary means for each feature for each configuration of participant and task, as described [here](https://class.coursera.org/getdata-031/forum/thread?thread_id=113) in TA David Hood's thread.

If you are interested in learning more about or working with the original UCI HAR data set, it may be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
