## Code Book

run_analysis.R performs the following steps to process the data.

1. Downloads the dataset and unzips the file

2. Reads the various text files into R. X_test.txt and X_train.txt contain the raw data tables, while features.txt contains the column names, subject_test.txt and subject_train.txt contain the subject numbers, and y_test.txt and y_train.txt contain the activity codes.

3. Merges the 'test' and 'train' data sets into one set. This is done by merging the data, activity, and subject tables seperately using _rbind()_, then merging those tables together with  _cbind()_.

4. Extracts only the mean and standard deviation data for each measurement, done by subsetting the merged dataset by columns that include 'mean' or 'std' in their names. 

5. Replaces the code numbers for activities with more desctriptive names, using the reference in activity_labels.txt

6. Renames all variables for better readability, such as naming the activity column 'activities', and replacing all instances of 'Acc' with 'Accel', 'BodyBody' with 'Body', 'Mag' with 'Magnitude', and 'f's and 't's replaced by 'Frequency' and 'Time'.

7. Creates a data set named summaryData with the mean of each variable for each activity and subject, and exports it to a summaryData.txt file.
