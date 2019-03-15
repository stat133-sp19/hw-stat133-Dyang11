#Title: Make Shots Data Script
#Description: Preparing the raw data for data analysis/visualization
#Inputs: Shot descriptions of players
#Outputs: A prepared data table ready for visualization/analysis and summaries of the the various shot charts. 

library (dplyr, readr)
#import the data sets
curry <- read_csv("../data/stephen-curry.csv", col_names = TRUE, col_types = "fcfiiicffifii")
green <- read_csv("../data/draymond-green.csv", col_names = TRUE, col_types = "fcfiiicffifii")
durant <- read_csv("../data/kevin-durant.csv", col_names = TRUE, col_types = "fcfiiicffifii")
iguodala <- read_csv("../data/andre-iguodala.csv", col_names = TRUE, col_types = "fcfiiicffifii")
thompson <- read_csv("../data/klay-thompson.csv", col_names = TRUE, col_types = "fcfiiicffifii")
#add the name column
curry <- mutate(curry, name = "Stephen Curry")
iguodala <- mutate(iguodala, name = "Andre Iguodala")
green <- mutate(green, name = "Draymond Green")
thompson <- mutate(thompson, name = "Klay Thompson")
durant <- mutate(durant, name = "Kevin Durant")
#add the minute column
curry <- mutate(curry, minute = ((curry$period-1)*12) + (12-curry$minutes_remaining))
durant <- mutate(durant, minute = ((durant$period-1)*12) + (12-durant$minutes_remaining))
iguodala <- mutate(iguodala, minute = ((iguodala$period-1)*12) + (12-iguodala$minutes_remaining))
thompson <- mutate(thompson, minute = ((thompson$period-1)*12) + (12-thompson$minutes_remaining))
green <- mutate(green, minute = ((green$period-1)*12) + (12-green$minutes_remaining))
#change the shot_made_flag to more descriptive values
durant$shot_made_flag[durant$shot_made_flag == "n"] = "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "y"] = "shot_yes"
durant$shot_made_flag <- as.factor(x= durant$shot_made_flag)
curry$shot_made_flag[curry$shot_made_flag == "y"] = "shot_yes"
curry$shot_made_flag[curry$shot_made_flag == "n"] = "shot_no"
curry$shot_made_flag <- as.factor(x= curry$shot_made_flag)
thompson$shot_made_flag[thompson$shot_made_flag == "y"] = "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag == "n"] = "shot_no"
thompson$shot_made_flag <- as.factor(x= thompson$shot_made_flag)
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] = "shot_yes"
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] = "shot_no"
iguodala$shot_made_flag <- as.factor(x= iguodala$shot_made_flag)
green$shot_made_flag[green$shot_made_flag == "y"] = "shot_yes"
green$shot_made_flag[green$shot_made_flag == "n"] = "shot_no"
green$shot_made_flag <- as.factor(x= green$shot_made_flag)
#add summary of data frame into individaul text files
sink(file='../output/stephen-curry-summary.txt')
summary(curry)
sink()
sink(file='../output/andre-iguodala-summary.txt')
summary(iguodala)
sink()
sink(file='../output/draymond-green-summary.txt')
summary(green)
sink()
sink(file='../output/kevin-durant-summary.txt')
summary(durant)
sink()
sink(file='../output/klay-thompson-summary.txt')
summary(thompson)
sink()
#stack the data frames together
shots_data <- do.call("rbind",list(curry,durant,green,iguodala,thompson))
#export the assembled table
write_csv(shots_data,'../data/shots-data.csv')
#export the summary of the assembled table
sink(file='../output/shots-data-summary.txt')
summary(shots_data)
sink()