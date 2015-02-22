# Source of data for this Project :https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#This R Script does the following:
#1. Merges the training and test sets to create one data set.
temp1 <- read.table("train/X_train.txt")
temp2 <- read.table("train/X_test.txt")
X <- rbind (temp1,temp2)

temp1 <-read.table("train/subject_train.txt")
temp2 <- read.table("test/subject_test.txt")
S <- rbind(temp1,temp2)

temp1 <- read.table("train/y_train.txt")
temp2 <- read.table("test/y_test.txt")
Y <- rbind(temp1,temp2)


#2. Extracts only the measurements on themean and Standard deviation for each measurement
features <- read.table("features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)",features[,2])
X <- X[,indices_of_good_features]
names(X) <- gsub("\\(|\\)","",names(X))
names(X) <- tolower(names(X))

#3. uses descriptive activity names to name th activities in the data set.

activities <- read.table("activity_labels.txt")
activities[,2] = gsub("","",tolower(as.character(activities[,2])))
Y[,1] = activities[Y[,1],2]
names(Y) <- "activity"

#4. Appropriately labels the data set with descriptive activity names.
names(S) <- "subject"
cleaned <- cbind(S, Y, X)
write.table(cleaned,"merged_clean_data.txt")

#5. Creates a 2nd, independ tidy data set with the average of each variable for each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols =dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities),]

row = 1 
for (S in 1:numSubjects) { 
	for ( a in 1:numActivities) {
		result[row, 1] = 
		uniqueSubjects[S] 
		result[row, 2]= 
		activities[a, 2]
		temp <- 
		cleaned[cleaned$subject== S & cleaned
		$activity==activities[a,
		2], ]
		 result[row,
		 3:numCols] <- colMeans(temp[,
		 3:numCols])
		          row = row+1
		      }
		  }
write.table(result,"data_set_with_averages.txt")




