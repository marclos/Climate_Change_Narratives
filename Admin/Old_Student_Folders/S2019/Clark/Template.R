## Read CSV Data

filepath = "/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/student_folders/Clark/Chris_Arlington_Data.csv"
climate_data = read.csv(filepath)
## Fix Dates
str(climate_data)
head(climate_data$DATE)
strDates <- as.character(climate_data$DATE)
head(strDates)

CYear = sub("/([0-9]+)$", "/19\\1", strDates[1:23132]) # Defined for this dataset! 
CYear = c(CYear, sub("/([0-9]+)$", "/20\\1", strDates[23133:30098]))
head(CYear)

climate_data$NewDate <- as.Date(CYear, "%m/%d/%Y")

str(climate_data)
## Plot Data
plot(TMAX ~ NewDate, data=climate_data)

## Add best fit line

