Gettingandcleaning
==================
After setting the actual working directory, the next 6 lines just simply pulls data tables, 
then merges the test and train data. In step 2, the code reads the features table, 
and searches for the 2 required columns, and merges them with the previously pulled data. 

Next, the function reads the activity labels, subtract labels, 
and merges them with the "merge_y" label file. Step 4 creates the final, 
cleaned data set by merging all 3 tables. In step 5, I've created a matrix for the tidy data, 
with the same number of columns as the data. There is a loop to calculate the mean of all columns, 
then the function shows the head of the result, and writes the table.
