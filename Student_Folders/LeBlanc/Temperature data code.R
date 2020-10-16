climate_data <-read.csv("/home/CAMPUS/cjld2018/Climate_Change_Narratives/Data/FA20/LeBlanc_temp_percp_data.csv")
strDates <- as.character(climate_data$DATE)
climate_data$NewDate <- as.Date(strDates, "%Y-%m-%d")

# daily temperature
plot(TMAX~NewDate, climate_data[1:30106,], type = "l", main="Daily Max Temperature in Portland, OR", xlab = "Date", ylab= "Max Temperature (Celcius)", col="aquamarine4")
bestfitline.lm=lm(TMAX~NewDate, climate_data)
abline(coef(bestfitline.lm), col="black",lwd=3)

# temperature monthly average
climate_data$Month = format(as.Date(climate_data$NewDate), format = "%m")
climate_data$Year = format(climate_data$NewDate, format = "%Y")

MonthlyTMAXMean = aggregate(TMAX ~ Month + Year, climate_data, mean)
MonthlyTMAXMean$YEAR = as.numeric(MonthlyTMAXMean$Year)
MonthlyTMAXMean$MONTH = as.numeric(MonthlyTMAXMean$Month)

plot(MonthlyTMAXMean$TMAX, ty = 'l')

plot(TMAX~YEAR, data=MonthlyTMAXMean[MonthlyTMAXMean$Month=="06",], ty='l', xlim=c(1940, 2019))
June.lm <- lm(TMAX~YEAR, data=MonthlyTMAXMean[MonthlyTMAXMean$Month=="06",])
summary(June.lm)
abline(coef(June.lm), col="blue")

plot(TMAX~YEAR, data=MonthlyTMAXMean[MonthlyTMAXMean$Month=="07",], ty='l', xlim=c(1940, 2019))
July.lm <- lm(TMAX~YEAR, data=MonthlyTMAXMean[MonthlyTMAXMean$Month=="07",])
summary(July.lm)
abline(coef(July.lm), col="blue")

plot(TMAX~YEAR, data=MonthlyTMAXMean[MonthlyTMAXMean$Month=="08",], ty='l', xlim=c(1940, 2019))
August.lm <- lm(TMAX~YEAR, data=MonthlyTMAXMean[MonthlyTMAXMean$Month=="08",])
summary(August.lm)
abline(coef(August.lm), col="blue")
plot(August.lm)

plot(TMAX~YEAR, data=MonthlyTMAXMean[MonthlyTMAXMean$Month=="09",], ty='l', xlim=c(1940, 2019))
September.lm <- lm(TMAX~YEAR, data=MonthlyTMAXMean[MonthlyTMAXMean$Month=="09",])
summary(September.lm)
abline(coef(September.lm), col="blue")
plot(September.lm)


