 # Step 1. Merge the training and the test data sets to create one data set
> setwd("C:/Work/MOOC/R dir/UCI HAR Dataset")
> train_x = read.table("./train/X_train.txt")
> train_y = read.table("./train/y_train.txt")
> train_subject = read.table("./train/subject_train.txt")
> test_x = read.table("./test/X_test.txt")
> test_y = read.table("./test/y_test.txt")
> test_subject = read.table("./test/subject_test.txt")
> merge_x = rbind(train_x, test_x)
> merge_y = rbind(train_y, test_y)
> merge_subject = rbind(train_subject, test_subject)
> # Step2. Extracts only the measurements on the mean and standard deviation for each measure
> features = read.table("./features.txt")
> measures = grep("mean\\(\\)|std\\(\\)", features[, 2])
> merge_x = merge_x[, measures]
> 
> # Step3. Uses descriptive activity names to name the activities in the data set
> activity = read.table("./activity_labels.txt")
> activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
> substr(activity[2, 2], 8, 8) = toupper(substr(activity[2, 2], 8, 8))
> substr(activity[3, 2], 8, 8) = toupper(substr(activity[3, 2], 8, 8))
> act_label = activity[merge_y[, 1], 2]
> merge_y[, 1] = act_label
> names(merge_y) = "activity"
> 
> # Step 4. Appropriately labels the data set with descriptive activity names
> names(merge_subject) = "subject"
> final_data = cbind(merge_subject, merge_y, merge_x)
> 
> # Step 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
> subject_len = length(table(merge_subject))
> act_len = dim(activity)[1]
> column_len = dim(final_data)[2]
> result = matrix(NA, nrow=subject_len*act_len, ncol=column_len)
> result = as.data.frame(result)
> colnames(result) = colnames(final_data)
> row = 1
> for(i in 1:subject_len) {
+ for(j in 1:act_len) {
+ result[row, 1] = sort(unique(merge_subject)[, 1])[i]
+ result[row, 2] = activity[j, 2]
+ bool1 = i == final_data$subject
+ bool2 = activity[j, 2] == final_data$activity
+ result[row, 3:column_len] = colMeans(final_data[bool1&bool2, 3:column_len])
+ result[row, 3:column_len] = colMeans(final_data[bool1&bool2, 3:column_len]) 
+ row = row + 1
+ }
+ }
> head(result)

> write.table(result, "tidy_data.txt")
> savehistory("C:/Work/MOOC/R dir/UCI HAR Dataset/run_analysis.R")
