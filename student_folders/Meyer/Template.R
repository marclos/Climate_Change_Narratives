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


## Plot Data

plot(TMAX ~ NewDate, climate_data)
plot(TMAX ~ NewDate, climate_data[1:1835,], ty='l')

plot(TMIN ~ NewDate, climate_data)

plot(PRCP ~ NewDate, climate_data)

## Add best fit line

print(lm(TMAX ~ NewDate, data = climate_data))

plot(lm(TMAX ~ NewDate, climate_data))

lm(TMIN ~ NewDate, climate_data)

plot(lm(PRCP ~ NewDate, climate_data))

## MONTHS

climate_data$Month = format(as.Date(climate_data$NewDate), format = "%m")
climate_data$Year = format(climate_data$NewDate, format="%Y")

climate_data$Month = format(as.Date(climate_data$NewDate), format = "%m")
climate_data$Year = format(climate_data$NewDate, format="%Y")


Months = c("January", "February", "March", "April",
           "May", "June", "July", "August", "September", "October",
           "November", "December")



## Monthly Max

MonthlyTMAXMean = aggregate(TMAX ~ Month + Year, climate_data, mean)

MonthlyTMAXMean$YEAR = as.numeric(MonthlyTMAXMean$Year)
MonthlyTMAXMean$MONTH = as.numeric(MonthlyTMAXMean$Month)

## July

plot(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH == 7, ], ty = "l", las = 1, xlim = c(1945, 2020),
     main = Months[7])
MaxJuly.lm <- lm(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH ==
                                                     7, ])
abline(coef(Month.lm), col = "red")

MaxJuly.lm.

## August

plot(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH == 8, ], ty = "l", las = 1, xlim = c(1945, 2020),
     main = Months[8])
MaxAugust.lm <- lm(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH ==
                                                     8, ])
abline(coef(Month.lm), col = "yellow")

MaxAugust.lm

## September

plot(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH == 9, ], ty = "l", las = 1, xlim = c(1945, 2020),
     main = Months[9])
MaxSeptember.lm <- lm(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH ==
                                                     9, ])
abline(coef(Month.lm), col = "orange")

MaxSeptember.lm

## Monthly Min

MonthlyTMINMean = aggregate(TMIN ~ Month + Year, climate_data, mean)

MonthlyTMINMean$YEAR = as.numeric(MonthlyTMINMean$Year)
MonthlyTMINMean$MONTH = as.numeric(MonthlyTMINMean$Month)

## July

plot(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH ==
                                           7, ], ty = "l", las = 1, xlim = c(1945, 2020),
     main = Months[7])
MinJuly.lm <- lm(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH ==
                                                     7, ])
abline(coef(Month.lm), col = "red")

MinJuly.lm

## August

plot(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH ==
                                           8, ], ty = "l", las = 1, xlim = c(1945, 2020),
     main = Months[8])
MinAugust.lm <- lm(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH ==
                                                     8, ])
abline(coef(Month.lm), col = "yellow")

MinAugust.lm

## September

plot(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH ==
                                           9, ], ty = "l", las = 1, xlim = c(1945, 2020),
     main = Months[9])
MinSeptember.lm <- lm(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH ==
                                                     9, ])
abline(coef(Month.lm), col = "orange")

MinSeptember.lm 