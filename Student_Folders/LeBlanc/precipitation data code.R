# Percipitation Montly Means
MonthlyPRCPMean = aggregate(PRCP ~ Month + Year, climate_data, sum)
MonthlyPRCPMean$YEAR = as.numeric(MonthlyPRCPMean$Year)
MonthlyPRCPMean$MONTH = as.numeric(MonthlyPRCPMean$Month)

plot(MonthlyPRCPMean$PRCP, ty = 'l')

#June
plot(PRCP~YEAR, data=MonthlyPRCPMean[MonthlyPRCPMean$Month=="06",], ty='l', xlim=c(1940, 2019))
June.lm <- lm(PRCP~YEAR, data=MonthlyPRCPMean[MonthlyPRCPMean$Month=="06",])
summary(July.lm)
abline(coef(June.lm), col="blue")

#July
plot(PRCP~YEAR, data=MonthlyPRCPMean[MonthlyPRCPMean$Month=="07",], ty='l', xlim=c(1940, 2019))
July.lm <- lm(PRCP~YEAR, data=MonthlyPRCPMean[MonthlyPRCPMean$Month=="07",])
summary(July.lm)
abline(coef(July.lm), col="blue")

#August
plot(PRCP~YEAR, data=MonthlyPRCPMean[MonthlyPRCPMean$Month=="08",], ty='l', xlim=c(1940, 2019))
August.lm <- lm(PRCP~YEAR, data=MonthlyPRCPMean[MonthlyPRCPMean$Month=="08",])
summary(August.lm)
abline(coef(August.lm), col="blue") 

#September
plot(PRCP~YEAR, data=MonthlyPRCPMean[MonthlyPRCPMean$Month=="09",], ty='l', xlim=c(1940, 2019))
September.lm <- lm(PRCP~YEAR, data=MonthlyPRCPMean[MonthlyPRCPMean$Month=="09",])
summary(September.lm)
abline(coef(September.lm), col="blue")
