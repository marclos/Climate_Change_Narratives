#Importing Scripts

file.choose() 
file = "/home/CAMPUS/vesj2015/Climate_Change_Narratives/Valeria/HOTSPRINGSVA24445.csv"
import = read.csv(file)
#Checking the Data
plot(TMAX~DATE, import)

import$TMAX[import$TMAX==-9999] = NA
plot(TMAX~DATE, import[import$DATE<18930101,], ty='l')

strDates <- as.character(import$DATE)

#check
head(strDates)
tail(strDates)


import$NewDate <- as.Date(strDates, "%Y%m%d")
#Checking the New Dates
#PROB STARST HERE
plot(TMAX~NewDate, import[import$DATE<18930901,], ty='l')

plot(TMAX~NewDate, import, ty='l')

import.lm <- lm(TMAX~NewDate, data=import)
summary(import.lm)

#[**
jan.lm = lm(TMAX~NewDate, data=monthlymeans[month[ymeans$month==1]])
#]

plot(TMAX~NewDate, import, ty='l')
abline(coef(import.lm), col='red')


# create months and years
import$Month = months(import$NewDate)
#^missing format = "%M"? Like the one below

import$Year = as.numeric(format(import$NewDate, format="%Y"))

MonthlyMean = aggregate(TMAX ~ Month + Year, import, mean)
MonthlyMean$YEAR = as.numeric(MonthlyMean$Year)
head(MonthlyMean)

str(import)

sum(import$Year>1990)
sum(import$Year<1995)

import$TMAX_cor <- import$TMAX
import$TMAX_cor[import$Year<1995 & import$Year>1990] <- NA
-----
#eh i think it ended up not working 
monthly means = aggregate(TMAX[TMAX$ELEMENT=="TMAX",], list(TMAX$YEAR, MONTH), mean)
