

#Montly Over certain level
highAQdf <- PMdf[which(PMdf$PM25 >= 100,),] 
highAQsum <- aggregate(PM25~ Month + Year, data=high90DF, length)
highAQsum$YEAR = as.numeric(highAQsum$Year)
highAQsum$MONTH = as.numeric(highAQsum$Month)


plot(PM25~YEAR, data=highAQsum[highAQsum$Month=="08",], ty='l', xlim=c(2000, 2019))
June.lm <- lm(PM25~YEAR, data=highAQsum[highAQsum$Month=="08",])
summary(June.lm)
abline(coef(June.lm), col="blue")

plot(PM25~YEAR, data=highAQsum[highAQsum$Month=="09",], ty='l', xlim=c(2000, 2019))
June.lm <- lm(PM25~YEAR, data=highAQsum[highAQsum$Month=="09",])
summary(June.lm)
abline(coef(June.lm), col="blue")
