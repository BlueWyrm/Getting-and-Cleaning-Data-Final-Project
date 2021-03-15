# Getting-and-Cleaning-Data-Final-Project
This is my submission for the peer-reviewed final project for the Coursera class Getting and Cleaning Data.
It contains four files:

README.md    This file. A description of the purpose and contents of this repo.

CodeBook.md   A description of the variables, data, and all transformations performed by the code.

run_analysis.R    The R code. This script does several things.
                 -Downloads the data
                 -Merges the 'test' and 'training' data sets into one dataset
                 -Extracts only the mean and standard deviation measurements in the data
                 -Gives all the varaibles slightly more readable names
                 -And creates a separate dataset with the means of all the measurements for each subject and activity

summaryData.txt    The data table created by run_analysis.R
