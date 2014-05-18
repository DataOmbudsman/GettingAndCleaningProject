# Readme for run_analysis.R

## How to use
The R script works properly if the `UCI HAR Dataset` directory is next to it. This a condition of reading the input files.

## Code structure
The code consists of 4 parts:
1. Merging the training and test sets  
2. Naming the columns appropriately and exracting only the mean and standard deciation measurements  
3. Including descriptive value names to the target attribute  
4. Creating the final aggregated data set  

## 1st part description
The script reads all 3 training files from their directory and with the `cbind()` function. Then it does the same for the 3 test files. Finally, it puts all previous data to the `allData` dataframe with an `rbind()`.

## 2nd part description
The second part first reads the feature names from the `features.txt` file into the `nameVector` vector. We name the columns accordingly to them (except for the first and second column, whose name we know). Thus, we get interpretable names for our columns.
Using the `grepl` function, we are able to find which column we need finally. In the `neededData` dataframe we only put these needed columns.

## 3rd part description
The third part reads the activity names from `activity_labels.txt` into the `actLabes` dataframe. We merge this data frame with the `neededData` so for each line we get the tidy name of each activity. We arrange that the new column that has these values will have the `activity_label` name.

## 4th part description
With the `aggregate` function, the script calculates the mean value for reach activity and each subject. For that, both `activity_label` and `subject` need to be a factor variable. We finally write the new tidy data set into the `independent_tidy.txt` file.
