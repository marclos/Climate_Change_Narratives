file.choose()
read.csv("/home/CAMPUS/smac2019/Climate_Change_Narratives/Student_Folders/Meilinger/Sarah_Orlando_Data.csv")

climate_data <- read.csv("/home/CAMPUS/smac2019/Climate_Change_Narratives/Student_Folders/Meilinger/Sarah_Orlando_Data.csv")
head(climate_data)
str(climate_data)
names(climate_data)
## [1] "STATION" "STATION_NAME" "DATE" "PRCP" "TAVG"
## [6] "TMAX" "TMIN"

plot(TMAX~DATE, climate_data)

min(climate_data$TMAX, na.rm=T)
## [1] -9999


str(climate_data)
strDates <- as.character(climate_data$DATE)
climate_data$NewDate <- as.Date(strDates, "%Y-%m-%d")