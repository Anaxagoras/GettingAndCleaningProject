# Tidy Accelerometer Data Set
The tidy data set produced by this code, named tidyAccelerometerData.txt. It contains a 180 row by 68 column table. It may be read using the following line of R:
```
read.table("tidyAccelerometerData.txt", header = TRUE)
```
The first and second columns respectively represent the subject's ID and the activity they were performing. Each row corresponds to some combination of the thirty test subjects and six activities — note that there are 180 rows, which is equal to 30*6. Each of the remaining 66 columns contain the mean values of a certain feature across all measurements of that feature for each pairing of subject and activity. Since each row represents one pairing, and each column a single feature for that pairing, the data are therefore tidy.

In accordance to the assignment, I kept from the original data set only those 66 out of 561 features that are measure mean or standard deviation. Reviewing the information about the features, I concluded that these were the ones that ended with "mean()" or "std()". The various mean meaures for the angle variable did not seem relevant here, and neither did the "meanFreq()" features.

For further details about tidyAccelerometerData.txt, consult the data dictionary in CodeBook.md.

# Script
My code to process the data may be found in run_analysis.R. I first read in several files containing the subject IDs, the activity IDs, and the feature data all for both the train and test data sets. I also read in the keys matching activities to their numerical IDs and features to columns of the data set.

For each of the test and train data sets, I stapled the participant IDs and activity IDs onto the left side of the data set as new columns. I then stapled these two resulting complete train and test data sets together row-wise.

I used grepl to find those features ending in exactly "mean()" or "std()", then kept the corresponding columns of the merged data set, along with the first and second columns, which represent participant and activity.

To make the data more human-readable, I set the column names to be more descriptive, using the feature names from the rows of the feature dictionary corresponding to the ones measuring mean and standard deviation. I also replaced opaque activity IDs with ones that tell the name of the activity, as derived from the activity key.

Lastly, to produce the final tidy data set, I used reshape2's melt and dcast functions to find aggregated means of each column for each combination of values in the Activity and SubjectID columns. For more details on this process, consult TA David Hood's thread [here](https://class.coursera.org/getdata-031/forum/thread?thread_id=113).
