
#excercise 1 - loop files and calculate mean#

#write function that binds


install.packages("data.table")
library("data.table")

pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  # Format number with fixed width and then append .csv to number
  fileNames <- list.files(path="specdata",pattern=".csv",full.names=TRUE)
  
  
  fileNames <- paste0(directory, '/', formatC(id, width=3, flag="0"), ".csv" )
  
  # Reading in all files and making a large data.table
  lst <- lapply(fileNames, data.table::fread)
  dt <- rbindlist(lst)
  
  if (c(pollutant) %in% names(dt)){
    return(dt[, lapply(.SD, mean, na.rm = TRUE), .SDcols = pollutant][[1]])
  } 
}

#usage
pollutantmean(directory = 'C:/Users/Sheetal/Documents/coursea course/R Programming/specdata', pollutant = 'sulfate', id = 20)

#exercise 2#
#Write a function that reads a directory full of files and reports the number of completely observed cases in each data file.#

complete <- function(directory,  id = 1:332) {
  
  # Format number with fixed width and then append .csv to number
  fileNames <- list.files(path="specdata",pattern=".csv",full.names=TRUE)
  
  # Reading in all files and making a large data.table
  lst <- lapply(fileNames, data.table::fread)
  dt <- rbindlist(lst)
  
  return(dt[complete.cases(dt), .(nobs = .N), by = ID])
  
}

#Example usage
test <- complete(directory = 'C:/Users/Sheetal/Documents/coursea course/R Programming/specdata', id = 20:30)

#exercise 3#
#Write a function that takes a directory of data files and a threshold for complete cases and calculates the correlation between 
#sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold.

corr <- function(directory, threshold = 0) {
  
  # Reading in all files and making a large data.table
  lst <- lapply(file.path(directory, list.files(path = directory, pattern="*.csv")), data.table::fread)
  dt <- rbindlist(lst)
  
  # Only keep completely observed cases
  dt <- dt[complete.cases(dt),]
  
  # Apply threshold
  dt <- dt[, .(nobs = .N, corr = cor(x = sulfate, y = nitrate)), by = ID][nobs > threshold]
  return(dt[, corr])
}

# Example Usage
corr(directory = 'C:/Users/Sheetal/Documents/coursea course/R Programming/specdata', threshold = 150)





