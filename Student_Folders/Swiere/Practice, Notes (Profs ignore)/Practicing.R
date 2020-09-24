climate_data <- read.csv("/home/CAMPUS/kmsa2017/Climate_Change_Narratives/Student_Folders/Swiere/Swiere_OrangeTX_DataNEW.csv")


strDates <- as.character(climate_data$DATE) #create object dates as characters
climate_data$NewDate <- as.Date(strDates, "%m/%d/%Y") #turn it into New Date

plot(TMAX~NewDate, climate_data, main = "TMAX Orange Texas", ylab = "Degrees C", 
     xlab = "Time", t = "l") #how can I get this to start at 1940?

bestfit <- lm(TMAX~NewDate, climate_data)
abline(coef(bestfit), col = "red")

#new stuff step 3
summary(bestfit)  #really low r squared
climate_data$Month <- format(as.Date(climate_data$NewDate), format = "%m")
climate_data$Year <- format(as.Date(climate_data$NewDate), format = "%Y")

MonthlyTMAXMean = aggregate(TMAX~Month + Year, climate_data, mean)
MonthlyTMAXMean$YEAR <- as.numeric(MonthlyTMAXMean$Year)
MonthlyTMAXMean$MONTH <- as.numeric(MonthlyTMAXMean$Month)

str(MonthlyTMAXMean)

plot(MonthlyTMAXMean$TMAX, ty = 'l')  #plot the data!!!! so exciting!!!

###Section 3.2
plot(TMAX~YEAR, MonthlyTMAXMean, ty = "l")
plot(TMAX~YEAR, MonthlyTMAXMean[MonthlyTMAXMean$MONTH == 5,], ty = "l", main = "Average May Max Temps")
May.max.lm <- lm(TMAX~YEAR, MonthlyTMAXMean[MonthlyTMAXMean$MONTH == 5,])
abline(coef(May.max.lm), col = "red")

#what would the TMAX be for january?
plot(TMAX~YEAR, MonthlyTMAXMean[MonthlyTMAXMean$MONTH == 1,], ty = "l", main = "Average January Max Temps")
Jan.max.lm <- lm(TMAX~YEAR, MonthlyTMAXMean[MonthlyTMAXMean$MONTH == 1,])
abline(Jan.max.lm, col = "blue") #this one looks like the most visible trend so far

##now many a TMIN graph
plot(TMIN~NewDate, climate_data, main = "TMIN SETX", ylab = "Degrees C", xlab = "Time", t = "l")
lm.min <- lm(TMIN~NewDate, climate_data)
abline(lm.min, col = "red")

MonthlyTMINMean <- aggregate(TMIN~Month + Year, climate_data, mean)
MonthlyTMINMean$Month <- as.numeric(MonthlyTMINMean$Month)
MonthlyTMINMean$Year <- as.numeric(MonthlyTMINMean$Year)

plot(TMIN~Year, MonthlyTMINMean, ty = "l")
plot(MonthlyTMINMean, ty = "l")
plot(TMIN~Year, MonthlyTMINMean[MonthlyTMINMean$Month == 5,], ty = "l", main = "Average May Min Temps") #look at min temps in may
May.min.lm <- lm(TMIN~Year, MonthlyTMINMean[MonthlyTMINMean$Month == 5,])
abline(May.min.lm, col = "red") #the average minimum temperature in may has decreased

#now TMIN for january
plot(TMIN~Year, MonthlyTMINMean[MonthlyTMINMean$Month == 1,], ty = "l", main = "Average Jan Min Temps") #look at min temps in jan
Jan.min.lm <- lm(TMIN~Year, MonthlyTMINMean[MonthlyTMINMean$Month == 1,])
abline(Jan.min.lm, col = "blue")

#plot all months at once
Months <- c("Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec")
par(mfrow = c(4,3), mar = c(5,4,3,2) +.1)
TMAXresult <- NA
for(i in 1:12) {
  plot(TMAX~YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH == i,], ty = "l", las = 1, xlim = c(1960,2020), main = Months[i])
  Month.lm <- lm(TMAX~YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH == i,])
  summary(Month.lm)
  abline(coef(Month.lm), col = "red")
  TMAXresult <- rbind(TMAXresult, cbind(Months[i], round(coef(Month.lm)[2],4), round(summary(Month.lm)$coefficients[2,4],4), round(summary(Month.lm)$r.squared,3)))
}
##plot all tmins at once

MonthlyTMINMean$YEAR = as.numeric(MonthlyTMINMean$Year)
MonthlyTMINMean$MONTH = as.numeric(MonthlyTMINMean$Month)
TMINresult <- NA
par(mfrow = c(4,3), mar = c(5,4,3,2) +.1)
for(i in 1:12) {
  plot(TMIN~YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH == i,], ty = "l", las = 1, xlim = c(1960,2020), main = Months[i])
  Month.lm <- lm(TMIN~YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH == i,])
  summary(Month.lm)
  abline(coef(Month.lm), col = "red")
  TMINresult <- rbind(TMINresult, cbind(Months[i], round(coef(Month.lm)[2],4), round(summary(Month.lm)$coefficients[2,4],4), round(summary(Month.lm)$r.squared,3)))
}

###PRECIPITATION
MonthlyPRCPSum = aggregate(PRCP~ Month + Year, climate_data, sum)

MonthlyPRCPSum$YEAR <- as.numeric(MonthlyPRCPSum$Year)
MonthlyPRCPSum$MONTH <- as.numeric(MonthlyPRCPSum$Month)
plot(MonthlyPRCPSum$PRCP, ty = "p")

plot(PRCP~YEAR, MonthlyPRCPSum, ty = "l")
plot(PRCP~YEAR, MonthlyPRCPSum[MonthlyPRCPSum$MONTH == 8,], ty = "l", main = "August Monthly Precipitation Over Time")
Aug.prcp <- lm(PRCP~YEAR, MonthlyPRCPSum[MonthlyPRCPSum$MONTH == 8,])
abline(coef(Aug.prcp), col = "red")

par(mfrow = c(4,3), mar = c(5,4,3,2) +.1)
PRCPresult <- NA
for(i in 1:12) {
  plot(PRCP~YEAR, data = MonthlyPRCPSum[MonthlyPRCPSum$MONTH == i,], ty = "l", las = 1, xlim = c(1960,2020), main = Months[i])
  Month.PRCP.lm <- lm(PRCP~YEAR, data = MonthlyPRCPSum[MonthlyPRCPSum$MONTH == i,])
  summary(Month.PRCP.lm)
  abline(coef(Month.PRCP.lm), col = "red")
  PRCPresult <- rbind(PRCPresult, cbind(Months[i], round(coef(Month.PRCP.lm)[2],4), round(summary(Month.PRCP.lm)$coefficients[2,4],4), round(summary(Month.PRCP.lm)$r.squared,3)))
}

##Results
Results <- data.frame(Month = TMINresult[,1],
                      TMINSlope = TMINresult[,2],
                      TMIN_P = as.numeric(TMINresult[,3]),
                      TMINRsq = TMINresult[,4],
                      TMAXSlope = TMAXresult[, 2],
                      TMAX_P = as.numeric(TMAXresult[,3]),
                      TMAXRsq = TMAXresult[,4],
                      PRCPSlope = PRCPresult[,2],
                      PRCP_P = as.numeric(PRCPresult[,3]),
                      PRCPsq = PRCPresult[,4])

Results$starTMIN <- ifelse(Results$TMIN_P <= .001, "***", 
                           ifelse(Results$TMIN_P <= .01, "**",
                            ifelse(Results$TMIN_P <= .05, "*", "NS")))
Results$starTMAX <- ifelse(Results$TMAX_P <= .001, "***", 
                                   ifelse(Results$TMAX_P <= .01, "**",
                                          ifelse(Results$TMAX_P <= .05, "*", "NS")))
Results$starPRCP <- ifelse(Results$PRCP_P <= .001, "***", 
                           ifelse(Results$PRCP_P <= .01, "**",
                                  ifelse(Results$PRCP_P <= .05, "*", "NS")))
Results$TMINSlope=paste(Results$TMINSlope, Results$starTMIN)
Results$TMAXSlope=paste(Results$TMAXSlope, Results$starTMAX)
Results$PRCPSlope=paste(Results$PRCPSlope, Results$starPRCP)
colnames(Results) <- c("Month", "2", "3", "R^2", "5", "6", 
                       

Results <- Results[,c("Month", "TMINSlope", "TMINRsq", "TMAXSlope", "TMAXRsq")]


Results <- Results[, c(1,2,4,5,7,8,10)]

colnames(Results) = c("Month", "Slope TMIN", "R^2", "Slope TMAX", "R^2", "Slope PRCP", "R^2")
print(xtable(Results))







