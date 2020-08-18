## script for the "Peer-graded Assignment: Getting and Cleaning Data Course 
## Project"

## libraries requred for this script
library(dplyr)
library(data.table)

## load the feature list into an object called "feature"
feature <- read.table("./UCI HAR Dataset/features.txt", sep = " ", 
                      header = FALSE)

## extract the feature labels and put in a vector
feature_labels <- feature$V2

## read subject train, rename column as "subject" and add an id row with 
## unique ascending integer values
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- "subject"
subject_train$id <- 1:nrow(subject_train)

## read Y_train, rename column as "activity" and add an id row with unique 
## ascending integer values
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
names(Y_train) <- "activity"
Y_train$id <- 1:nrow(Y_train)

## read X_train and rename columns using feature_labels vector
X_train <- fread("./UCI HAR Dataset/train/X_train.txt")
names(X_train) <- feature_labels
X_train$id <- 1:nrow(X_train)

## merge all the train datasets by binding along columns and labeling dataset 
## type to "train"
train_df <- merge(subject_train, Y_train, by = "id", all = TRUE) %>% 
  mutate(type = "train")%>% merge(X_train, by = "id", all = TRUE)

## clean up memory by removing objects that are not in use
rm("subject_train", "X_train", "Y_train", "feature")

## read subject test, rename column as "subject" and add an id row with 
## unique ascending integer values
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- "subject"
subject_test$id <- 1:nrow(subject_test)

## read Y_test, rename column as "activity" and add an id row with unique 
## ascending integer values
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
names(Y_test) <- "activity"
Y_test$id <- 1:nrow(Y_test)

## read X_test and rename columns using feature_labels vector
X_test <- fread("./UCI HAR Dataset/test/X_test.txt")
names(X_test) <- feature_labels
X_test$id <- 1:nrow(X_test)

## merge all the test datasets by binding along columns and labeling dataset 
## type to "test"
test_df <- merge(subject_test, Y_test, by = "id", all = TRUE) %>% 
  mutate(type = "test")%>% merge(X_test, by = "id", all = TRUE)

## clean up memory by removing objects that are not in use
rm("subject_test", "X_test", "Y_test", "feature_labels")

## bind rows using dplyr function bind_rows, saved to full_df
full_df <- bind_rows(train_df, test_df)

## clean up memory by removing objects that are not in use
rm("test_df", "train_df")

## Extracts only the measurements on the mean and standard deviation for 
## each measurement
subset_df <- select(full_df, subject:type, contains(c("mean()", "std()")))

## Uses descriptive activity names to name the activities in the data set
subset_df <- subset_df %>% mutate(activity = case_when(
  activity == 1 ~ "walking",
  activity == 2 ~ "walking_upstairs",
  activity == 3 ~ "walking_downstairs",
  activity == 4 ~ "sitting",
  activity == 5 ~ "standing",
  activity == 6 ~ "laying"))

## remove full_df since we dont need it anymore
rm("full_df")

## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject
## stored in object called summary
by_group <- group_by(subset_df, subject, activity, type)
summary <- summarise_all(by_group, mean)

## summary data stored using write.table command
## write.table(summary, "tidy_data.txt", row.name=FALSE)
