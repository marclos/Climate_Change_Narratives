library(plyr)
library(rnoaa)

## Read CSV Data

file.choose()

climate_data <- read.csv("/home/CAMPUS/ekma2018/Climate_Change_Narratives/student_folders/Meyer/ella_seattle_data.csv")

View(climate_data)
head(climate_data)
str(climate_data)
names(climate_data)

climate_data$TMAX
min(climate_data$TMAX)
min(climate_data$TMAX, na.rm=T)

## Fix Dates

strDates <- as.character(climate_data$DATE)
climate_data$NewDate <- as.Date(strDates, "%m/%d/%Y")

CYear = sub("/([0-9]+)$", "/19\\1", strDates[1:18993]) # Defined for this dataset! 
CYear = c(CYear, sub("/([0-9]+)$", "/20\\1", strDates[18994:25959]))
head(CYear)

climate_data$NewDate <- as.Date(CYear, "%m/%d/%Y")

str(climate_data)


## Plot Data

plot(TMAX ~ NewDate, climate_data)
plot(TMAX ~ NewDate, climate_data[1:1835,], ty='l')

plot(PRCP ~ NewDate, climate_data)

## Add best fit line

lm(TMAX ~ NewDate, climate_data)

plot(lm(TMAX ~ NewDate, climate_data))

plot(lm(PRCP ~ NewDate, climate_data))

climate_data$Month = format(as.Date(climate_data$NewDate), format = "%m")
climate_data$Year = format(climate_data$NewDate, format="%Y")

