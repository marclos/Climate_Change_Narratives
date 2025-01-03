#file.choose()
#read.csv("/home/CAMPUS/smac2019/Climate_Change_Narratives/Student_Folders/Meilinger/Sarah_Orlando_Data.csv")
filepath = "/home/CAMPUS/smac2019/Climate_Change_Narratives/Student_Folders/Meilinger/Sarah_Orlando_Data.csv"
filepath = "/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Student_Folders/Meilinger/Sarah_Orlando_Data.csv"

#climate_data[20000,]
climate_data_full <- read.csv(filepath)
climate_data <- subset(climate_data, subset=c(STATION=="USW00012841"))
droplevels(climate_data)

head(climate_data)
str(climate_data)
unique(climate_data$NAME)
names(climate_data)
## [1] "STATION" "STATION_NAME" "DATE" "PRCP" "TAVG"
## [6] "TMAX" "TMIN"

plot(TMAX~DATE, climate_data)

min(climate_data$TMAX, na.rm=T)
## [1] -9999


str(climate_data)
strDates <- as.character(climate_data$DATE)
climate_data$NewDate <- as.Date(strDates, "%Y-%m-%d")