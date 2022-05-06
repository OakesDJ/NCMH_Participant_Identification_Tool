
# Packages
library(shiny)
library(readxl)
library(magrittr)
library(tidyverse)
library(XML)

# Preliminary Data Cleaning
##data <- readxl::read_xlsx("C:/Users/Daniel Oakes/OneDrive - Cardiff University/NCMH_2022_OD/NCMH_RShiny_Participant_Identification/Practice/Participant_Identification_Dummy_Data.xlsx")
data <- download.file(url = "https://netstorage-mwe.cf.ac.uk/NetStorage/DriveS_D01/PSYCM/NCMH/NCMH/NCMH Database/ID numbers.xlsx", destfile = "local.xlsx", mode = "wb")
data$study_id <- gsub("[^0-9_]", "", data$study_id)
data$first_name <- gsub("[^a-z]", "", tolower(data$first_name))
data$middle_name <- gsub("[^a-z,]", "", tolower(data$middle_name))
data$last_name <- gsub("[^a-z-]", "", tolower(data$last_name))
data$dob <- gsub("[^0-9-]", "", as.character(data$dob))
data$post_code <- gsub("[^A-Za-z0-9]", "", tolower(data$post_code))
data$address <- tolower(data$address)
data[colnames(data)] <- lapply(data[colnames(data)], as.character)