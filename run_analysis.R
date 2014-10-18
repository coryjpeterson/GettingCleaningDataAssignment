## Course Assignment for Getting and Cleaning Data
## Purpose: Create a tidy data set from the website: 
##   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##load dplyr package for data frames
library(dplyr)

##Read in all of the data
trainy <- read.table("y_train.txt")
trainx <- read.table("x_train.txt",sep="")
subtrain <- read.table("subject_train.txt")
testy <- read.table("y_test.txt")
testx <- read.table("x_test.txt",sep="")
subtest <- read.table("subject_test.txt")

##Modify to make new table with mean and std deviation
trainx <- data.frame(apply(trainx,1,mean), apply(trainx,1,sd))
testx <- data.frame(apply(testx,1,mean), apply(testx,1,sd))

##Combine into single tables
train <- tbl_df(data.frame(subtrain,trainy,trainx))
test <- tbl_df(data.frame(subtest,testy,testx))

##Change column names
colnames(train) <- c("Subject","Activity","Mean","SD")
colnames(test) <- c("Subject","Activity","Mean","SD")

##Combine training and test together
alldata <- rbind_list(train,test)

#Remove all unecessary data frames
rm(subtest,subtrain,test,testx,testy,train,trainx,trainy)

#Add descriptive names to the dataset
alldata$Activity[alldata$Activity=="1"] <- "WALKING"
alldata$Activity[alldata$Activity=="2"] <- "WALKING_UPSTAIRS"
alldata$Activity[alldata$Activity=="3"] <- "WALKING_DOWNSTAIRS"
alldata$Activity[alldata$Activity=="4"] <- "SITTING"
alldata$Activity[alldata$Activity=="5"] <- "STANDING"
alldata$Activity[alldata$Activity=="6"] <- "LAYING"

#Group the data together
allsummary <- group_by(alldata,Subject,Activity) %>% summarise_each(funs(mean))

#Rename the column names to represent average of mean and SD.
colnames(allsummary) <- c("Subject","Activity","Average Mean","Average SD")

write.table(allsummary,"2ndTidyData.txt",row.name=FALSE)
