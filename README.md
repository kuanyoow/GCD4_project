# GCD4_project
Course project assignment for getting and cleaning data.

The dataset used in this project was obtained from the follwing link
https://d396qusza40orc.cloudfront.net/
  getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The raw data was then unzipped and stored in the folder "UCI HAR Dataset".

The script used to generate the datatables in his repository called 
"run_analysis.R".

The script contains the code to generate the independent tidy data set with the 
average of each variable for each activity and each subject. This tidy dataset
is saved in the object called "summary" and has been saved as a txt file called
"tidy_data.txt".
    
To load the "tidy_data.txt" file use the read.table command with header = TRUE.

The file "codebook.md" that explains what the column titles mean from the 
"tidy_data.txt" dataset.

#The workflow to generate the tidy dataset was as follows:

Load the various train and test datasets into a dataframe.

Label the various columns with a more descriptive name.

Merge the datasets into a dataframe with the train and test assigned with the 
label "type".

Select the mean and standard variation variable columns.

Replace the numerical activity with a more descriptive activity.

Create a new dataframe with a summary of averages according each "subject", 
"activity" and "type".
