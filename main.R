# This file will be used to coordinate all functions

# Import function
source("global.R")


if(!file.exists("data/raw_import.txt")){
  d <- import_data("UCL")
}

clean_data()

visualise_data()

