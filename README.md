# Getting and cleaning data project: Readme
## How to use
You have to have dplyr and tidyr packages installed on your machine. Before using my script you should specify your working directory 
with commands like setwd(). Your working directory must contain a folder with the name "UCI HAR Dataset" with all required data there. 
After doing above-given actions you can use the script. Load it into your R environment, than call a function run_analysis(). That's all.
## How does it work
In the script there are many steps. Firstly, we're loading libraries dplyr and tidyr. we're reading all the required data into varialbes, 
data frames and other structures. We're giving certain names to our data frames' columns (we're extracting names from features.txt). We're 
constructing two main data frames (tbl_df, to be exactly): x_train, x_test. We're merging it into one global with the name 
all_observations. It is our first data frame. We write it in "all_observation.txt". Than we group it by variables avtivity_type and 
subject. It is our second data frame. We're writing it in "observations_by_groups.txt"

