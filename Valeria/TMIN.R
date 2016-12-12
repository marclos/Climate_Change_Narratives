#Importing Scripts


file.choose() 
file = "/home/CAMPUS/vesj2015/Climate_Change_Narratives/Valeria/HOTSPRINGSVA24445.csv"
import = read.csv(file)
#Checking the Data
plot(TMIN~DATE, import)


import$TMIN[import$TMIN==-9999] = NA
plot(TMIN~DATE, import[import$DATE<18930101,], ty='l')


strDates <- as.character(import$DATE)


#check
head(strDates)
tail(strDates)




import$NewDate <- as.Date(strDates, "%Y%m%d")
#Checking the New Dates


#checking the weird gap






#PROB STARST HERE
plot(TMIN~NewDate, import[import$DATE<18930901,], ty='l')


plot(TMIN~NewDate, import, ty='l')


import.lm <- lm(TMIN~NewDate, data=import)
summary(import.lm)




plot(TMIN~NewDate, import, ty='l')
abline(coef(import.lm), col='red')




# CREATE VARIABLE MONTHS AND YEARS


import$TMIN_cor <- import$TMIN
import$TMIN_cor[import$Year<1995 & import$Year>1990] <- NA




import$Month = months(import$NewDate)


import$Year = as.numeric (format(import$NewDate, format="%Y"))


MonthlyMean = aggregate(TMIN ~ Month + Year, import, mean)


#dont thinkneed MonthlyMean$YEAR = as.numeric(MonthlyMean$Year)
head(MonthlyMean)
tail(MonthlyMean)


YearlyMean = aggregate(TMIN_cor ~ Year, import, mean)
head(YearlyMean)
##need something like: MonthlyMean$YEAR = as.numeric(MonthlyMean$Year)?
#probably not




#PLOT THESE AGGREGRATIONS
#PLOT MONTHLY


plot(MonthlyMean$TMIN, ty='l')


#Plot yearly?


plot(YearlyMean$TMIN, ty='l')




#plot SPECIFIC MONTH
plot(MonthlyMean$TMIN[MonthlyMean$Month=="May"], ty='l')
plot(TMIN~YEAR, data=MonthlyMean[MonthlyMean$Month=="May",], ty='l') 




-----
  #DROP SOME OBSERVATIONS
  
  
  #idk why NEed a string but it's here:
  str(import)


#check number of obs (ture and flase =something else)
sum(import$Year>1990)
sum(import$Year<1995)


import$TMIN_cor <- import$TMIN
import$TMIN_cor[import$Year<1995 & import$Year>1990] <- NA

#just check lenght
length(import$Year<1995)
--------
  
  
  #LINEAR REGRESSIONS
  
  #Yearly 
  #notdone
  
  
  
  
Monthly.lm = lm(TMIN_cor ~ MonthlyMean)
YearlyMean$Year = as.numeric(YearlyMean$Year)
Yearly.lm = lm(TMIN_cor~ Year, data = YearlyMean)
summary(Yearly.lm)



plot(TMIN_cor~ Year, data = YearlyMean, ty="l", las=1, ylab="temperature")
abline(coef(Yearly.lm), col="blue")
#Montly?


May.lm <- lm(TMIN_cor~YEAR, data=MonthlyMean[MonthlyMean$Month=="May",]) 
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
  monthlymeans = aggregate(TMIN[TMIN$ELEMENT=="TMIN",], list(TMIN$YEAR, MONTH), mean)




