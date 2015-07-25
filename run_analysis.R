
#Download the file through a https connection:
 temp=tempfile()
 setInternet2(use=TRUE)
 if(!file.exists("data")){
    dir.create("data")
 }
 message("Downloading zip files ,pls. wait...")

 download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp, method="internal")
 unzip(temp,exdir="./data",unzip="internal")
#clear now the connection
 unlink(temp)
#read files
message("Exctracting data,pls. wait...")
 Xtrain<-read.table("./data/UCI HAR Dataset/train/X_train.txt",header=FALSE)
 Ytrain<-read.table("./data/UCI HAR Dataset/train/y_train.txt",header=FALSE)
 SbJtrain<-read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
 feature<-read.table("./data/UCI HAR Dataset/features.txt")
 Xtest<-read.table("./data/UCI HAR Dataset/test/X_test.txt",header=FALSE)
 Ytest<-read.table("./data/UCI HAR Dataset/test/y_test.txt",header=FALSE)
 SbJtest<-read.table("./data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
 ActLbls<-read.table("./data/UCI HAR Dataset/activity_labels.txt",header=FALSE)

## Merge the X-training and the X-test sets (measurements) to create one data set (Xtrain, Xtest) 
 TrainTest<-rbind(Xtrain,Xtest)

library(plyr)
library(dplyr)

## Merge the Y-training and the Y-test sets (Activity list) to create one data set (Ytrain, Ytest) 
 Y_trainTest<-rbind(Ytrain,Ytest)

## Merge the partecipating Subject's ID for the train and test sets (Sbjtrain, Sbjtest) 
 SBJ_TrainTest<-rbind(SbJtrain,SbJtest)

# Name all columns
 colnames(Y_trainTest)<-"Activity_Type"
 colnames(SBJ_TrainTest)<-"Subject_Name"
#get measurement's name (column's name) from the file feature
 colnames(TrainTest)<-feature[,2]

#merge the 2 columns without measurements, i.e subject person and Activity_ID
 Y_SBJ<-cbind(Y_trainTest,SBJ_TrainTest)

#look for duplicated column names and remove them
if(any(duplicated(colnames(TrainTest)))){
   TrainTest<-TrainTest[,!duplicated(colnames(TrainTest))]
}

# Extract all columns where there are "mean" and "STD" 
SeqMean<-TrainTest[grep("-mean" ,colnames(TrainTest),ignore.case=TRUE,fixed=FALSE,value=TRUE)]
SeqStd<-TrainTest[grep("-std" ,colnames(TrainTest),ignore.case=TRUE,fixed=FALSE,value=TRUE)]

#Complete the dataframe with measurements data + Activity Type and SubjectID
Mean_And_Std<-cbind(SeqMean,SeqStd)
DB<-cbind(Y_SBJ,Mean_And_Std)

#Replace the Activity ID with the corresponding descripion 
  DB[,"Activity_Type"]<-ActLbls[as.numeric(DB[,"Activity_Type"]),2] 

### Finish step 4 here

#From the data set in step 4, creates an independent tidy data set with the average of each 
#variable for each activity and each subject.


DBFinal<-DB%>%
	group_by(Activity_Type,Subject_Name)%>% 
	summarise_each(funs(mean))

write.table(DBFinal, file = "TidyDB.txt", row.names = FALSE)
message("File name DBFinal was created with"); dim(DBFinal); message("rows, columns ") 



##same result can be obtained using datatable
##library(data.table)
##DBS.dt<-data.table(DB)
##DBFinal1<-DBS.dt[,lapply(.SD,function(x) list(mean(x))),by="Activity_Type,Subject_Name"]
##write.table(DBFinal1, file = "TidyData.txt", row.names = FALSE)
##DBFinal12<-DBS.dt[,lapply(.SD,mean(x)),by="Activity_Type,Subject_Name"]
