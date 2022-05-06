
# Packages
library(shiny)
library(readxl)
library(magrittr)
library(tidyverse)

# Preliminary Data Cleaning
data <- read.csv(url("https://raw.githubusercontent.com/OakesDJ/NCMH_Participant_Identification_Tool/main/Participant_Identification_Dummy_Data.csv"), skipNul = F, sep = ",", fill = T) ## Importing data from github. 
data$study_id <- gsub("[^0-9_]", "", data$study_id) ## Formatting individual variables. 
data$first_name <- gsub("[^a-z]", "", tolower(data$first_name))
data$middle_name <- gsub("[^a-z,]", "", tolower(data$middle_name))
data$last_name <- gsub("[^a-z-]", "", tolower(data$last_name))
data$dob <- gsub("[^0-9/]", "", data$dob)
data$post_code <- gsub("[^A-Za-z0-9]", "", tolower(data$post_code))
data$address <- tolower(data$address)
data[colnames(data)] <- lapply(data[colnames(data)], as.character) ## Appling character format to all variables. 
data[is.na(data)] <- as.character("NA") ## Used to convert NAs into a character format so they are not removed in the GSUB. 



