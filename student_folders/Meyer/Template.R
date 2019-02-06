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

## Plot Data

plot(TMAX~DATE, climate_data)
plot(TMAX~NewDate, climate_data)
plot(TMAX~NewDate, climate_data[1:1835,], ty='l')

## Add best fit line

plot(lm(TMAX ~ NewDate, climate_data))


climate_data$Month = format(as.Date(climate_data$NewDate), format = "%m")
climate_data$Year = format(climate_data$NewDate, format="%Y")



