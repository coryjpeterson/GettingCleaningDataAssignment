## Course Assignment for Getting and Cleaning Data
## Purpose: Create a tidy data set from the website: 
##   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##load dplyr package for data frames
library(dplyr)

##Read in all of the data
trainy <- read.table("train/y_train.txt")
trainx <- read.table("train/x_train.txt",sep="")
subtrain <- read.table("train/subject_train.txt")
testy <- read.table("test/y_test.txt")
testx <- read.table("test/x_test.txt",sep="")
subtest <- read.table("test/subject_test.txt")

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
cleandata <- rbind_list(train,test)

#Remove all unecessary data frames
rm(subtest,subtrain,test,testx,testy,train,trainx,trainy)

#Add descriptive names to the dataset
cleandata$Activity[cleandata$Activity=="1"] <- "WALKING"
cleandata$Activity[cleandata$Activity=="2"] <- "WALKING_UPSTAIRS"
cleandata$Activity[cleandata$Activity=="3"] <- "WALKING_DOWNSTAIRS"
cleandata$Activity[cleandata$Activity=="4"] <- "SITTING"
cleandata$Activity[cleandata$Activity=="5"] <- "STANDING"
cleandata$Activity[cleandata$Activity=="6"] <- "LAYING"

#Group the data together
cleandatasummary <- group_by(cleandata,Subject,Activity) %>% summarise_each(funs(mean))

#Rename the column names to represent average of mean and SD.
colnames(cleandatasummary) <- c("Subject","Activity","Average Mean","Average SD")

#Write table to text file
write.table(cleandatasummary,"SummaryTidyData.txt",row.name=FALSE)
