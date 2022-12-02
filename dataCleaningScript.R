#getRawData accepts the folder path where the data are located and returns a data frame

getRawData<-function(dataFilePath) {

#load necessary libraries

	library(dplyr)
	library(data.table)

#import raw data

	X_test<-read.table(paste(dataFilePath,"test/X_test.txt",sep=""))

	Y_test<-read.table(paste(dataFilePath,"test/y_test.txt",sep=""))

	subject_test<-read.table(paste(dataFilePath,"test/subject_test.txt",sep=""))

	X_train<-read.table(paste(dataFilePath,"train/X_train.txt",sep=""))

	Y_train<-read.table(paste(dataFilePath,"train/y_train.txt",sep=""))

	subject_train<-read.table(paste(dataFilePath,"train/subject_train.txt",sep=""))

#import vector of column names

	v<-read.table("C:/Users/clark/Desktop/cleandata/dataset/features.txt")

	nameVector<-v[,2]

#rename Xs

	names(X_test)<-nameVector

	names(X_train)<-nameVector

#name Ys

	names(Y_test)<-"activity"

	names(Y_train)<-"activity"

#name subject

	names(subject_test)<-"subject"

	names(subject_train)<-"subject"

#combine test and train data

	trainData<-cbind(subject_train,Y_train,X_train)

	testData<-cbind(subject_test,Y_test,X_test)

#append train & test to make total raw data & delete imports

	rawData<-rbind(trainData,testData)

	rm("X_test","Y_test","X_train","Y_train","subject_test","subject_train","v","nameVector")

#drop columns that aren't needed & assign activity labels

	rawData<-rawData %>% 
		select("subject","activity",contains(c("mean()","std()"))) %>%
		mutate(activity=case_when (
							activity==1 ~ "WALKING",
							activity==2 ~ "WALKING UPSTAIRS",
							activity==3 ~ "WALKING DOWNSTAIRS",
							activity==4 ~ "SITTING",
							activity==5 ~ "STANDING",
							activity==6 ~ "LAYING"
						))

#clean data names

	names(rawData)<-stringCleaner(names(rawData))

#return data

	rawData

}

summarizeData<-function(df) {

	dt<-data.table(df)
	df<-dt[,lapply(.SD,mean),by=.(subject,activity)]
	df
}	


stringCleaner<-function(ls){

	#send to lower
	ls<-tolower(ls)

	#take out parentheses and dashes
	ls<-gsub("()",".",ls,fixed=TRUE)
	ls<-gsub("-",".",ls,fixed=TRUE)

	#take out duplicate . and trailing .
	ls<-gsub("..",".",ls,fixed=TRUE)
	ls<-sub("(.*?)\\.$", "\\1", ls)

}


