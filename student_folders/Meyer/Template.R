library(plyr)
library(rnoaa)

## Read CSV Data

file.choose()

climate_data <- read.csv("/home/CAMPUS/ekma2018/Climate_Change_Narratives/student_folders/Meyer/ella_seattle_data.csv")

View(climate_data)
head(climate_data)
str(climate_data)
names(climate_data)

climate_data$TMAX
min(climate_data$TMAX)
min(climate_data$TMAX, na.rm=T)

## Fix Dates

strDates <- as.character(climate_data$DATE)
climate_data$NewDate <- as.Date(strDates, "%m/%d/%Y")

CYear = sub("/([0-9]+)$", "/19\\1", strDates[1:18993]) # Defined for this dataset! 
CYear = c(CYear, sub("/([0-9]+)$", "/20\\1", strDates[18994:25959]))
head(CYear)

climate_data$NewDate <- as.Date(CYear, "%m/%d/%Y")

str(climate_data)


## Plot General Data

plot(TMAX ~ NewDate, climate_data)
plot(TMAX ~ NewDate, climate_data[1:1835,], ty='l')

plot(PRCP ~ NewDate, climate_data)

## Add best fit line

lm(TMAX ~ NewDate, climate_data)

plot(lm(TMAX ~ NewDate, climate_data))


## Month organization

climate_data$Month = format(as.Date(climate_data$NewDate), format = "%m")
climate_data$Year = format(climate_data$NewDate, format="%Y")


Months = c("January", "February", "March", "April",
           "May", "June", "July", "August", "September", "October",
           "November", "December")



## Monthly Max

MonthlyTMAXMean = aggregate(TMAX ~ Month + Year, climate_data, mean)

MonthlyTMAXMean$YEAR = as.numeric(MonthlyTMAXMean$Year)
MonthlyTMAXMean$MONTH = as.numeric(MonthlyTMAXMean$Month)

plot(MonthlyTMAXMean$TMAX, ty='l')

lm(MonthlyTMAXMean$MONTH ~ NewDate, climate_data)

plot(lm(MonthlyTMAXMean ~ NewDate, climate_data))

## Monthly Min

MonthlyTMINMean = aggregate(TMIN ~ Month + Year, climate_data, mean)

MonthlyTMINMean$YEAR = as.numeric(MonthlyTMINMean$Year)
MonthlyTMINMean$MONTH = as.numeric(MonthlyTMINMean$Month)

plot(MonthlyTMINMean$TMIN, ty='l')

head(MonthlyTMINMean)



## For loop - TMAX

par(mfrow = c(4, 3), mar = c(5, 4, 3, 2) + 0.1)
TMAXresult <- NA
for (i in 1:12) {
  plot(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH ==
                                             i, ], ty = "l", las = 1, xlim = c(1945, 2020),
       main = Months[i])
  Month.lm <- lm(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH ==
                                                       i, ])
  print(summary(Month.lm))
  abline(coef(Month.lm), col = "red")
  TMAXresult <- rbind(TMAXresult, cbind(Months[i],
                                        round(coef(Month.lm)[2], 4), round(summary(Month.lm)$coefficients[2,
                                                                                                          4], 4), round(summary(Month.lm)$r.squared,
                                                                                                                        3)))
}


TMAXresult <- rbind(TMAXresult, cbind(Months[i],
                                      round(coef(Month.lm)[2], 4), round(summary(Month.lm)$coefficients[2,
                                                                                                        4], 4), round(summary(Month.lm)$r.squared,
                                                                                                                      3)))
summary(TMAXresult)


## For loop - TMIN

par(mfrow = c(4, 3), mar = c(5, 4, 3, 2) + 0.1)
TMINresult <- NA
for (i in 1:12) {
  plot(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH ==
                                             i, ], ty = "l", las = 1, xlim = c(1945, 2020),
       main = Months[i])
  Month.lm <- lm(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH ==
                                                       i, ])
  summary(Month.lm)
  abline(coef(Month.lm), col = "blue")
  TMINresult <- rbind(TMINresult, cbind(Months[i],
                                        round(coef(Month.lm)[2], 4), round(summary(Month.lm)$coefficients[2,
                                                                                                          4], 4), round(summary(Month.lm)$r.squared,
                                                                                                                        3)))
}



## Precipitation

MonthlyPRCPMean = aggregate(PRCP ~ Month + Year, climate_data, mean)

MonthlyPRCPMean$YEAR = as.numeric(MonthlyPRCPMean$Year)
MonthlyPRCPMean$MONTH = as.numeric(MonthlyPRCPMean$Month)

plot(MonthlyPRCPMean$PRCP, ty='l')

par(mfrow = c(4, 3), mar = c(5, 4, 3, 2) + 0.1)
PRCPresult <- NA
for (i in 1:12) {
  plot(PRCP ~ YEAR, data = MonthlyPRCPMean[MonthlyPRCPMean$MONTH ==
                                             i, ], ty = "l", las = 1, xlim = c(1945, 2020),
       main = Months[i])
  Month.lm <- lm(PRCP ~ YEAR, data = MonthlyPRCPMean[MonthlyPRCPMean$MONTH ==
                                                       i, ])
  summary(Month.lm)
  abline(coef(Month.lm), col = "green")
  PRCPresult <- rbind(PRCPresult, cbind(Months[i],
                                        round(coef(Month.lm)[2], 4), round(summary(Month.lm)$coefficients[2,
                                                                                                          4], 4), round(summary(Month.lm)$r.squared,
                                                                                                                        3)))
}


## Snow

MonthlySNOWMean = aggregate(SNOW ~ Month + Year, climate_data, mean)

MonthlySNOWMean$YEAR = as.numeric(MonthlySNOWMean$Year)
MonthlySNOWMean$MONTH = as.numeric(MonthlySNOWMean$Month)

plot(MonthlySNOWMean$SNOW, ty='l')
