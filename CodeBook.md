#Getting and Cleaning 

##CODE BOOK


The "Getting and Cleaning" project was carried out on a set of data from an experiment involving a group of 30 volunteers aged between 19 and 48 years old. Each Volunteer helped sampling data in six different situation, called "Activities" (WALKING, WALKING_UPSTAIRS, WALKING _DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

Using its embedded accelerometer and gyroscope,  3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The total number of measurements produced was found to be in sets of data of 561 columns, training ad test data. The number of rows these sets were different due to the above mentioned selecting criteria.   

Looking at duplicated column names I found a few and they have been removed. 

if(any(duplicated(colnames(TrainTest)))){
   TrainTest<-TrainTest[,!duplicated(colnames(TrainTest))]
}
At this point the number of columns of the training and test sequence were totally 447. 

The scope of this work was to extract some of those variables (after a merging (rowbinding) procedure of the training and test sequences) namely those reporting the "mean"" or the "STD"" value. No attention has been paied whether it would make sense  including or not some columns as long as their names partially matched our selecting criteria. The scope of this work is related on the capability of extracting some columns among many others partially matching the name of the variable with the requested one. In this case the search was on column names partially matching the string "-mean" and "-std" ignoring the case.

SeqMean<-TrainTest[grep("-mean" ,colnames(TrainTest),ignore.case=TRUE,fixed=FALSE,value=TRUE)]
SeqStd<-TrainTest[grep("-std" ,colnames(TrainTest),ignore.case=TRUE,fixed=FALSE,value=TRUE)]

At this point, all columns were merged including the 2 of the activity and volunteer's ID. The total number of variables were found to be totally 81, distributed with 49 "-mean" values, 33 "-std" values plus the activity column renamed to "Activity_ Type"" and the volunteer ID number column renamed to "Subject_Name".

The final question was to extract from the above mentioned data the mean of each variable for each activity and each subject. After calculating the mean for each variable, the point was to decide whether to change names of all columns but preserving in a way the original (for example adding the word "MEAN OF:" followed by the name of the original column name) easily done with a loop:

 for (i in 3: ncol(DBFinal)){
   names(RenameCol)[i]<- paste("MEAN OF:",names(RenameCol)[i] , sep=" ")
   #exception of the column 1 and 2, activity and subject
}

but I found that the final name would become too long and therefore I decided not to proceed. The final point was infact to calculate the mean of all columns and I wanted to preserve the original name in order of being able to see what it was. 

Following list reports column number [i] followed by its name of the final dataset.


 [1] "Activity_ Type"                  
 [2] "Subject_Name"                   
 [3] "tBodyAcc-mean()-X"               
 [4] "tBodyAcc-mean()-Y"              
 [5] "tBodyAcc-mean()-Z"              
 [6] "tGravityAcc-mean()-X"           
 [7] "tGravityAcc-mean()-Y"            
 [8] "tGravityAcc-mean()-Z"           
 [9] "tBodyAccJerk-mean()-X"           
[10] "tBodyAccJerk-mean()-Y"          
[11] "tBodyAccJerk-mean()-Z"          
[12] "tBodyGyro-mean()-X"             
[13] "tBodyGyro-mean()-Y"              
[14] "tBodyGyro-mean()-Z"             
[15] "tBodyGyroJerk-mean()-X"          
[16] "tBodyGyroJerk-mean()-Y"         
[17] "tBodyGyroJerk-mean()-Z"         
[18] "tBodyAccMag-mean()"             
[19] "tGravityAccMag-mean()"           
[20] "tBodyAccJerkMag-mean()"         
[21] "tBodyGyroMag-mean()"             
[22] "tBodyGyroJerkMag-mean()"        
[23] "fBodyAcc-mean()-X"              
[24] "fBodyAcc-mean()-Y"              
[25] "fBodyAcc-mean()-Z"               
[26] "fBodyAcc-meanFreq()-X"          
[27] "fBodyAcc-meanFreq()-Y"          
[28] "fBodyAcc-meanFreq()-Z"          
[29] "fBodyAccJerk-mean()-X"           
[30] "fBodyAccJerk-mean()-Y"          
[31] "fBodyAccJerk-mean()-Z"           
[32] "fBodyAccJerk-meanFreq()-X"      
[33] "fBodyAccJerk-meanFreq()-Y"      
[34] "fBodyAccJerk-meanFreq()-Z"      
[35] "fBodyGyro-mean()-X"             
[36] "fBodyGyro-mean()-Y"             
[37] "fBodyGyro-mean()-Z"              
[38] "fBodyGyro-meanFreq()-X"         
[39] "fBodyGyro-meanFreq()-Y"          
[40] "fBodyGyro-meanFreq()-Z"         
[41] "fBodyAccMag-mean()"              
[42] "fBodyAccMag-meanFreq()"         
[43] "fBodyBodyAccJerkMag-mean()"      
[44] "fBodyBodyAccJerkMag-meanFreq()" 
[45] "fBodyBodyGyroMag-mean()"         
[46] "fBodyBodyGyroMag-meanFreq()"    
[47] "fBodyBodyGyroJerkMag-mean()"     
[48] "fBodyBodyGyroJerkMag-meanFreq()"
[49] "tBodyAcc-std()-X"                
[50] "tBodyAcc-std()-Y"               
[51] "tBodyAcc-std()-Z"                
[52] "tGravityAcc-std()-X"            
[53] "tGravityAcc-std()-Y"            
[54] "tGravityAcc-std()-Z"            
[55] "tBodyAccJerk-std()-X"            
[56] "tBodyAccJerk-std()-Y"           
[57] "tBodyAccJerk-std()-Z"            
[58] "tBodyGyro-std()-X"              
[59] "tBodyGyro-std()-Y"              
[60] "tBodyGyro-std()-Z"              
[61] "tBodyGyroJerk-std()-X"           
[62] "tBodyGyroJerk-std()-Y"          
[63] "tBodyGyroJerk-std()-Z"           
[64] "tBodyAccMag-std()"              
[65] "tGravityAccMag-std()"           
[66] "tBodyAccJerkMag-std()"          
[67] "tBodyGyroMag-std()"             
[68] "tBodyGyroJerkMag-std()"         
[69] "fBodyAcc-std()-X"               
[70] "fBodyAcc-std()-Y"               
[71] "fBodyAcc-std()-Z"               
[72] "fBodyAccJerk-std()-X"           
[73] "fBodyAccJerk-std()-Y"           
[74] "fBodyAccJerk-std()-Z"           
[75] "fBodyGyro-std()-X"              
[76] "fBodyGyro-std()-Y"              
[77] "fBodyGyro-std()-Z"              
[78] "fBodyAccMag-std()"              
[79] "fBodyBodyAccJerkMag-std()"       
[80] "fBodyBodyGyroMag-std()"         
[81] "fBodyBodyGyroJerkMag-std()"
