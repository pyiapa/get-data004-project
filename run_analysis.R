# Load the test and train data sets
test_data = read.table("UCI HAR Dataset/test/X_test.txt")
train_data = read.table("UCI HAR Dataset/train/X_train.txt")

# Load the activity labels into a data frame
activity_labels = read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("id", "activity")

# Get the id's that correspond to each activity for the subjects
test_id_data = read.table("UCI HAR Dataset/test/y_test.txt")
activity_id <- test_id_data$V1

# Create a vector with activity labels that correspond to the 
# activity id's. 
activities <- character()
for(i in 1:length(activity_id)){
  temp <- activity_labels[activity_id[i],]
  activities <- c(activities,as.character(temp$activity))
}
# Attach the column with activity labels to the test data set
test_data <- cbind(activities, test_data)
# Attach the column with activity id's to the test data set
test_data <- cbind(activity_id, test_data)

# Load the subject id's
subject_test_data = read.table("UCI HAR Dataset/test/subject_test.txt")
subject_id <- subject_test_data$V1

# Attach the column with subject id's to the test data set
test_data <- cbind(subject_id, test_data)



# Collect train data

# Get the id's that correspond to each activity for the subjects
train_id_data = read.table("UCI HAR Dataset/train/y_train.txt")
activity_id <- train_id_data$V1

# Create a vector with activity labels that correspond to the 
# activity id's. 
activities <- character()
for(i in 1:length(activity_id)){
  temp <- activity_labels[activity_id[i],]
  activities <- c(activities,as.character(temp$activity))
}

# Attach the columns with activity labels and activity ids to the test data set
train_data <- cbind(activities, train_data)
train_data <- cbind(activity_id, train_data)

# Load the subject id's
subject_train_data = read.table("UCI HAR Dataset/train/subject_train.txt")
subject_id <- subject_train_data$V1
# Attach the column with subject id's to the train data set
train_data <- cbind(subject_id, train_data)


# Merge the two data sets together
mergedData = merge(test_data, train_data, all=TRUE)


# Name the columns with proper labels from the features file
features_data = read.table("UCI HAR Dataset/features.txt")
column_names <- features_data$V2
column_names <- c("SubjectID", "ActivityID","Activity", as.character(column_names))
colnames(mergedData) <- column_names


# Extract mean and standard deviation related columns
col_names <- colnames(mergedData)

mean_std_vector <- character()

for(col in col_names){
  
  if(grepl("std",col) | grepl("mean",col) |  grepl("Mean",col)){
    mean_std_vector <- c(mean_std_vector, col)
  }
}
mean_std_vector <- c("SubjectID", "ActivityID","Activity",mean_std_vector)

mean_std_data <- mergedData[,mean_std_vector]



# Find the averages and put them in a tidy file

library(reshape2)

# Get approproate column labels
column_labels <- colnames(mean_std_data)
column_labels <- column_labels[4:length(column_labels)]

# Calculate avarages based on Acticity and Subject ID
meltData <- melt(mean_std_data, id=c("Activity", "SubjectID"), measure.vars=column_labels)
tidy_data <- dcast(meltData, SubjectID + Activity ~ column_labels, mean)

# Tidy up the column labels
column_labels <- lapply(column_labels, FUN= function(x) paste("AVG-", x, sep=""))
column_labels <- c("SubjectID", "Activity", column_labels)
colnames(tidy_data) <- column_labels


# Write the tidy talbe back to a txt file
write.table(tidy_data, file="tidy_set.txt")

