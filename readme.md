readme.md

Coursea Getting and Cleaning Data Course Project

Description of R code: dataCleaningScript.R

The necessary libraries are base, dplyr, and data.table.

The function getRawData accepts an argument that is the path to the folder holding the unzipped data files and
it returns the data frame requested in step 1 of the assignment.  getRawData calls stringCleaner which renames
the column names found in features.txt so that they jive with 'tidy data' principles.  All other function calls
are included in the necessary libraries listed above.

The function summarizeData calculates the average of all the numeric columns in getRawData by subject 
and activity.

Example usage for these functions is shown below:

> myData<-getRawData("C:/Users/clark/Desktop/cleandata/dataset/") ;
> mySummarizedData<-summarizeData(myData) ;
> write.table(myData,"C:/Users/clark/Desktop/cleandata/dataset/data.csv",sep=",") ;
> write.table(mySummarizedData,"C:/Users/clark/Desktop/cleandata/dataset/summarizedData.csv",sep=",")






