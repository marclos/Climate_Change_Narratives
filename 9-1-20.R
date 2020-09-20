file.choose()
read.csv("/home/CAMPUS/kmsa2017/Climate_Change_Narratives/Student_Folders/Swiere/Swiere_OrangeTX_Data.csv")
climate_data <- read.csv("/home/CAMPUS/kmsa2017/Climate_Change_Narratives/Student_Folders/Swiere/Swiere_OrangeTX_Data.csv")
climate_data
head(climate_data)
str(climate_data)
names(climate_data)
climate_data$TMAX
plot(TMAX~DATE, climate_data)
plot(climate_data$TMAX~climate_data$DATE)
min(climate_data$TMAX)
min(climate_data$TMAX, na.rm = T)
min(climate_data$TMIN, na.rm = T)
max(climate_data$TMAX, na.rm = T) 

plot(TMIN~DATE, climate_data)
str(climate_data)
class(climate_data$date)
strDates <- as.character(climate_data$DATE)
climate_data$NewDate <- as.Date(strDates, "%Y-%m-%d")
plot(TMAX~NewDate, climate_data, ty = "l")
bestfit <- lm(TMAX~NewDate, climate_data)
coef(bestfit)
abline(coef(bestfit), col = "red")



