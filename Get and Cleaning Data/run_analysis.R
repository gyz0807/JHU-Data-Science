library(dplyr); library(tidyr)

# 1. Merges the training and the test sets to create one data set

############################## Merges the training sets
# Loading data

# Each row identifies the subject (person) who performed the activity for each window 
# sample. Its range is from 1 to 30.
subject_train <- read.table("./UCI HAR Dataset-2/train/subject_train.txt")

# Training set
X_train <- read.table("./UCI HAR Dataset-2/train/X_train.txt")

# Training tabels (1-6) Refer to activity_labels.txt
y_train <- read.table("./UCI HAR Dataset-2/train/y_train.txt")

training_set <- cbind(subject_train, y_train, X_train)
names(training_set)[1:2] <- c("subject", "activity")

############################## Merges the test sets
# loading data

subject_test <- read.table("./UCI HAR Dataset-2/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset-2/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset-2/test/y_test.txt")

test_set <- cbind(subject_test, y_test, X_test)
names(test_set)[1:2] <- c("subject", "activity")

############################## Merges training and test sets
merged_set <- rbind(training_set, test_set)
# rm(list = ls()[2:9])

##########################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement.

# Loading features
features <- read.table("./UCI HAR Dataset-2/features.txt")
column_numbers <- grep("mean\\(\\)|std\\(\\)", features$V2) + 2
selected_columns <- merged_set %>%
        select(1, 2, column_numbers)

##########################################################################################
# 3. Uses descriptive activity names to name the activities in the data set
activity_names <- read.table("./UCI HAR Dataset-2/activity_labels.txt")
names(activity_names) <- c("activity", "attribute")
merged_with_activity_name <- inner_join(activity_names, selected_columns, by="activity")

##########################################################################################
# 4. Appropriately labels the data set with descriptive variable names.
names(merged_with_activity_name)[4:ncol(merged_with_activity_name)] <- 
        grep("mean\\(\\)|std\\(\\)", features$V2, value = TRUE)
merged_with_variable_name <- select(merged_with_activity_name, 2:69)
names(merged_with_variable_name)[1] <- "activity"

##########################################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
tidy_data <- tbl_df(merged_with_variable_name) %>%
        group_by(activity, subject) %>%
        summarize_each(funs(mean))

write.table(tidy_data, "Tidy_Data.txt", row.names = FALSE)

