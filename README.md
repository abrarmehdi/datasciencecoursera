# Getting and Cleaning Data Assignment

## Problem statement
"Create a clean and tidy data set" using the datasets provided.

### Getting Data
Initially two data sets were given. "Training Data Set" & "Test Data Set"

### Cleaning Data
Although it seems like we might need to clean the data but data is already. Only thing we need to do is to filter out columns and row.

NOTE: By cleaning I meant removing NAs and factors

### Prerequisites
Before proceeding further make sure to download the data and read the all the required files for purpose of understanding the data.

## Approach
<ol> Preprocessing </ol>
<ol> Merge Data Sets</ol>
<ol> Create Tidy Data Set</ol>

### Preprocessing
Before going ahead with merging the data sets we need to know the attributes of data sets. This information can be easily obtained through readme, features, features_info & activity_labels files.

As the problem statements clearly states that we have to merge the data along with taking care of additional information like extracting only mean and standard deviation measurements, using proper variable names and activity names. We will look into each and every piece of information before proceeding with Merging of data.

As most of the time I have spent in preprocessing it makes sense for me to explain each and every step in detail.

Below are the list of things which I have done to preprocess the data.
<ol> 1. Indentifying Mean and Standard Deviation Columns (Column Numbers) </ol>
  <ol> <ol> - Used grep function to identify mean and standard deviation columns </ol> </ol>
<ol> 2. Indentifying Mean and Standard Deviation Columns (Column Names) </ol>
  <ol> <ol> - Used grep function with value = TRUE to identify mean and standard deviation columns </ol> </ol>
<ol> 3. Modifying existing column names to Proper Variable Names </ol>
  <ol> <ol> - Created a function to identify distinctive names and create a proper variable name </ol> </ol>
  <ol> <ol> - Used sapply function to apply the function for each of the column names </ol> </ol>
<ol> 4. Reading Activity Labels </ol>
  <ol> <ol> - Read activity_label.txt file </ol> </ol>
<ol> 5. Reading Activities for each observation for training and test data</ol>
  <ol> <ol> - Read Y_train.txt and Y_test.txt files </ol> </ol>
<ol> 6. Reading Subjects for each observation for training and test data</ol>
  <ol> <ol> - Read subject_train.txt and subject_test.txt </ol> </ol>
<ol> 7. Calculating widths for reading training and test data as data sets is in fixed width format</ol>
  <ol> <ol> - As we are more interested in mean and standard deviation measurements we had to skip unnecessary columns while reading it </ol> </ol>
<ol> 8. Preparing Activity Column Values for training and test data</ol>
  <ol> <ol> - Created a vector with activity column values for all the observations </ol> </ol>
<ol> 9. Reading Training and Test Data</ol>
  <ol> <ol> - Read X_train.txt and X_test.txt files </ol> </ol>
<ol> 10. Adding Activity and Subject Columns</ol>
  <ol> <ol> - Added activity and subject columns to the data sets</ol> </ol>
 
## Merging Data
Merged both the data sets using merge function.

## Creating Tidy Data
Once merge was done then created a sample subset which had all the possible combinations of Activity and Subject columns and filled their values with average of each measurement
