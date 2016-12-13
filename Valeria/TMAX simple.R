
file = "/home/CAMPUS/vesj2015/Climate_Change_Narratives/Valeria/HOTSPRINGSVA24445.csv"
import = read.csv(file)

import$TMAX[import$TMAX==-9999] = NA

import$NewDate <- as.Date(strDates, "%Y%m%d")
# CREATE VARIABLE MONTHS AND YEARS
  
import$Month = months(import$NewDate)

import$Year = as.numeric (format(import$NewDate, format="%Y"))

MonthlyMean = aggregate(TMAX ~ Month + Year, import, mean)

#dont thinkneed 
MonthlyMean$YEAR = as.numeric(MonthlyMean$Year)
head(MonthlyMean)
tail(MonthlyMean)


  #LINEAR REGRESSIONS
  #from sophie's?
  
May.lm <- lm(TMAX~YEAR, data=MonthlyMean[MonthlyMean$Month=="May",])
summary(May.lm)

plot(TMAX~YEAR, data=MonthlyMean[MonthlyMean$Month=="May",], ty='l', ylab = "Max Temp", xlab="YEAR", main= "May Monthly Av-Slope = .03, Not Sig", las=1) 

abline(coef(May.lm), col="red")

