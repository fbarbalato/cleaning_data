# cleaning_data


#Getting & cleaning data Project

##This project consists on the following points:

1:  Downloading a zip file from a https site
 (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
  and unzip the content in a directory
 
2: Merge the training sets (files: Xtrain and Xtest) found in the respective directories  train and test

3: Extract only measurements on the mean and standard deviation of each measurements from file point 2

4: Merge result from point 3 with files where are found the activity_ID (Y_train, Ytest) and Subjects_ID 
   (Subject_train, Subject_est) found inside the train and test folder.     

5: rename all columns with the corresponding descriptive measurement (features) found in the main directory, (UCI HAR Dataset) 

6: replace the activity_ID's with the corresponding descriptive variable names

7: Extract from point 6 independent tidy data set with the average of each variable for each activity and each subject

8: Save the result of the process into a .txt file
  
 Point 1 is included into the run_analysis.r script 2 as I mean it is part of the project. CAUTION must be taken to    this as the downloading instructions are valid for my specific OS whic is Windows (W. 8 in this case to be precise).
   
 The zip file was unzipped below my "data" directory located below my working directory. However, the program checks   the availabily of a "data" directory and if not present it creates it.

 Concerning point 3 and 5, it was choosen to invert operations i.e. naming the columns first and then extracting the 
 mean and STD mesurements.  
    
Point 7 was carried out in two different ways, one, the current requires the packages dplyr. The second is NOT enabled  as it is included within comments (see the script) at the end of it. In order to try it it must be activated by    deleating the coment sign but then it requires loading the data.table package. Appropriate call to those library is carried out along the script but packages must be installed in  advance from cran
    
The resulting data base (DBFinal) is saved in a text file named TidyDB.txt


