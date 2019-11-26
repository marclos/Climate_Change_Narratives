#Importing Scripts

file.choose() 
file = "/home/CAMPUS/vesj2015/Climate_Change_Narratives/Valeria/HOTSPRINGSVA24445.csv"
import = read.csv(file)
#Checking the Data
plot(TMAX~DATE, import)

import$TMAX[import$TMAX==-9999] = NA
plot(TMAX~DATE, import[import$DATE>18930101,], ty='l')

import$NewDate <- as.Date(strDates, "%Y%m%d")
#Checking the New Dates
plot(TMAX~NewDate, import[import$DATE>18930101,], ty='l', ylab = "Max. Temp. Recorded" , xlab = "Date")
#Checking the New Dates? nah this doesn't work :///
head(NewDate)
#checking the weird gap

#same difference as date limited one lol:
plot(TMAX~NewDate, import, ty='l', ylab = "Max. Temp. Recorded" , xlab = "Date")


import.lm <- lm(TMAX~NewDate, data=import)
summary(import.lm)


plot(TMAX~NewDate, import, ty='l')
abline(coef(import.lm), col='red')

#####SKIP 
----------------------------------------------------------------

import$TMAX_cor <- import$TMAX
import$TMAX_cor[import$Year<1995 & import$Year>1990] <- NA

------------------------------------------------------------------
# CREATE VARIABLE MONTHS AND YEARS

import$Month = months(import$NewDate)

import$Year = as.numeric (format(import$NewDate, format="%Y"))

MonthlyMean = aggregate(TMAX ~ Month + Year, import, mean)

#dont thinkneed 
MonthlyMean$YEAR = as.numeric(MonthlyMean$Year)
head(MonthlyMean)
tail(MonthlyMean)

###SCREW THIS DONT NEED IT 
YearlyMean = aggregate(TMAX_cor ~ Year, import, mean)
##head(YearlyMean)
##need something like: MonthlyMean$YEAR = as.numeric(MonthlyMean$Year)?
#probably not


#PLOT THESE AGGREGRATIONS
#PLOT MONTHLY

plot(MonthlyMean$TMAX, ty='l', ylab = "Max. Temp. Recorded" , xlab = "Date")

#Plot yearly?

plot(YearlyMean$TMAX, ty='l', ylab = "Max. Temp. Recorded" , xlab = "Year Number")



#plot SPECIFIC MONTH
plot(MonthlyMean$TMAX[MonthlyMean$Month=="May"], ty='l')
plot(TMAX~YEAR, data=MonthlyMean[MonthlyMean$Month=="May",], ty='l') 




#AGAIN, not working, ignore:
-------------------------------------------------------
#DROP SOME OBSERVATIONS

  #idk why NEed a string but it's here:
str(import)

#check number of obs (ture and flase =something else)
sum(import$Year>1990)
sum(import$Year<1995)

import$TMAX_cor <- import$TMAX

import$TMAX_cor[import$Year<1995 & import$Year>1990] <- NA
  
#just check lenght
length(import$Year<1995 & import$Year>1990)


##Error in eval(expr, envir, enclos) : object 'TMAX_cor' not found

--------

  
  
  
  
#LINEAR REGRESSIONS
#from sophie's?

May.lm <- lm(TMAX~YEAR, data=MonthlyMean[MonthlyMean$Month=="May",])
summary(May.lm)

plot(TMAX~YEAR, data=MonthlyMean[MonthlyMean$Month=="May",], ty='l', ylab = "Max Temp", xlab="YEAR", main= "May Monthly Av", las=1) 

abline(coef(May.lm), col="red")

#old one:
  
Monthly.lm = lm(TMAX~MonthlyMean)
YearlyMean$Year = as.numeric(YearlyMean$Year)
Yearly.lm = lm(TMAX_cor~ Year, data = YearlyMean)
summary(Yearly.lm)


#IGNORE THIS TOO:
plot(TMAX~ Year, data = YearlyMean, ty="l", las=1, ylab="temperature")
abline(coef(Yearly.lm), col="green")

####Soo I'm just gonna do it with the old "Date" variable }:/

Monthly.lm = lm(TMAX ~ MonthlyMean)
YearlyMean$Year = as.numeric(YearlyMean$Year)
Yearly.lm = lm(TMAX_cor~ Year, data = YearlyMean)
summary(Yearly.lm)

plot(TMAX_cor~ Year, data = YearlyMean, ty="l", las=1, ylab="temperature")
abline(coef(Yearly.lm), col="green")


#Montly?

May.lm <- lm(TMAX_cor~YEAR, data=MonthlyMean[MonthlyMean$Month=="May",]) 
summary(May.lm)
abline(coef(May.lm), col="red")

-----------------------
#What part of linear regression summary tells you what?

#Coefficients:
                          #Estimate Std. Error t value Pr(>|t|)    
# Y-Interc-> #(Intercept) 2.839104   4.078240   0.696 0.487698    
# SLOPE ->    #Year       0.007178   0.002088   3.438 0.000809 ***

# abline is how u get best fit line
-----
#eh i think it ended up not working 
monthlymeans = aggregate(TMAX[TMAX$ELEMENT=="TMAX",], list(TMAX$YEAR, MONTH), mean)
