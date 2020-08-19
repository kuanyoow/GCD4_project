# Codebook

The dataset for "tidy_data.txt" contains 180 observations and 69 variables.

The "subject" column represents the 30 volunteers within an age bracket of 
19-48 years. Each of the subjects are assigned a numerical variable 1 to 30.

The "activity" column represents the 6 different activities the volunteers 
performed. They are categorised as "walking", "walking_upstairs", 
"walking_downstairs", "sitting", "standing" and "laying".

The "type" column represents the type of exercise, either the training exercise 
which is labeled as "train" or the testing exercise labeled as "test".

The next 60 columns represents the averages of the various measurements on the 
mean and standard deviation for each measurement.

# The workflow to generate the tidy dataset was as follows:

Load the various train and test datasets into a dataframe.

Label the various columns with a more descriptive name.

Merge the datasets into a dataframe with the train and test assigned with the 
label "type".

Select the mean and standard variation variable columns.

Replace the numerical activity with a more descriptive activity.

Create a new dataframe with a summary of averages according each "subject", 
"activity" and "type".