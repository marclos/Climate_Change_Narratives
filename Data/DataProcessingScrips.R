#Importing Scripts

file = "/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Nicole/Marshfield climate.csv"
import = read.csv(file)
plot(TMAX~DATE, import)

import$TMAX[import$TMAX==-9999] = NA

plot(TMAX~DATE, import[import$DATE<19132131,], ty='l')
plot(TMAX~DATE, import[import$DATE<19130102,], ty='l')

#head(as.Date(

strDates <- as.character(import$DATE)

head(strDates)

import$NewDate <- as.Date(strDates, "%Y%m%d")

plot(TMAX~NewDate, import[import$DATE<19130102,], ty='l')

plot(TMAX~NewDate, import, ty='l')

# Linear Model
import.lm <- lm(TMAX~NewDate, data=import)
summary(import.lm)

abline(coef(import.lm), col='red')

#2.906*10-5 degrees/year or 2.9*10-2 per year.

# Moving Average!
# average of current sample and 19 previous samples (red)
f20 <- rep(1/600, 600)
y_lag <- filter(import$TMAX, f20, sides=1)
plot(y_lag)

# Create a time series
Tmax = ts(import$TMAX)

# Get months
import$Month = months(import$NewDate)
import$Year = format(import$NewDate, format="%Y")

MonthlyMean = aggregate(TMAX ~ Month + Year, import, mean)
MonthlyMean$YEAR = as.numeric(MonthlyMean$Year)
head(MonthlyMean)
plot(MonthlyMean$TMAX, ty='l')

plot(MonthlyMean$TMAX[MonthlyMean$Month=="May"], ty='l')
plot(TMAX~YEAR, data=MonthlyMean[MonthlyMean$Month=="May",], ty='l') 
May.lm <- lm(TMAX~YEAR, data=MonthlyMean[MonthlyMean$Month=="May",])
summary(May.lm)

abline(coef(May.lm), col="red")
