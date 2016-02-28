run_analysis <- function() {
      library(dplyr) #   loading required libraries
      library(tidyr)
      
      read_data()      # reading data
}
download_data <- function() {
      archive_URL <- #   defining archive URL  
            "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      
      download.file(archive_URL, # downloading archive
                    destfile = "data_archive.zip")
      print("Data has been succesfully downloaded!")
}
read_data <- function() {
      setwd("UCI HAR Dataset")
      # =================================================
      seq <- 1:6
      features <- tbl_df(read.table("features.txt")) # loading variable names
      # =================================================
      setwd("train")
      x_train <- tbl_df(read.table("X_train.txt"))[, seq] # reading tables into vars
      y_train <- tbl_df(read.table("y_train.txt"))
      subject_train <- tbl_df(read.table("subject_train.txt"))
      # =================================================
      setwd("..")
      # =================================================
      setwd("test")
      x_test <- tbl_df(read.table("X_test.txt"))[, seq]
      y_test <- tbl_df(read.table("y_test.txt"))
      subject_test <- tbl_df(read.table("subject_test.txt"))
      # =================================================
      column_names <- c("tBodyAccMeanX",
                        "tBodyAccMeanY",
                        "tBodyAccMeanZ",
                        "tBodyAccStdX",
                        "tBodyAccStdY",
                        "tBodyAccStdZ")
      
      names(x_train) <- column_names
      names(x_test)  <- column_names
      # ==================================================
      y_train <- cbind(y_train, subject_train)
      x_train <- tbl_df(cbind(x_train, y_train))
      
      names(x_train)[7:8] <- c("activity_type", "subject")
      # ==================================================
      y_test <- cbind(y_test, subject_test)
      x_test <- tbl_df(cbind(x_test, y_test))
      
      names(x_test)[7:8] <- c("activity_type", "subject")
      # =================================================
      all_observations <- rbind(x_test, x_train)
      # =================================================
      setwd("..")
      activity_labels <- tbl_df(read.table("activity_labels.txt"))
      # =================================================
      activity_type <- activity_labels$V2[all_observations$activity_type]
      
      all_observations <- select(all_observations, -activity_type)
      all_observations <- cbind(all_observations, activity_type)
      # =================================================
      write.table(all_observations, "all_observations.txt")
      # =================================================
      by_activity <- group_by(all_observations, activity_type, subject)
      observations_by_groups <- 
            summarize(by_activity, 
            accelerator_X_mean = mean(tBodyAccMeanX),
            accelerator_Y_mean = mean(tBodyAccMeanY),
            accelerator_Z_mean = mean(tBodyAccMeanZ),
            accelerator_X_std = mean(tBodyAccStdX),
            accelerator_Y_std = mean(tBodyAccStdY),
            accelerator_Z_std = mean(tBodyAccStdZ)
            )
      write.table(observations_by_groups, "observations_by_groups.txt")
      # =================================================
}