# Imports NOAA CSV Files and Prepares them to be analyzed 	
CSV_import <- function(filename=file.choose()){	
  #filename <- file.choose()	
  import = read.csv(filename)	
  import$TMAX[import$TMAX==-9999] = NA	
  import$TMIN[import$TMIN==-9999] = NA	
  strDates <- as.character(import$DATE)	
  #head(strDates)	
  import$NewDate <- as.Date(strDates, "%Y%m%d")	
  return(import)	
}