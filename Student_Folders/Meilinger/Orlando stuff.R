#file.choose()
read.csv("/home/CAMPUS/smac2019/Climate_Change_Narratives/Data/FA20/Sarah_Orlando_Data.csv")
filepath = "/home/CAMPUS/smac2019/Climate_Change_Narratives/Data/FA20/Sarah_Orlando_Data.csv"
#filepath = "/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Student_Folders/Meilinger/Sarah_Orlando_Data.csv"

#climate_data[20000,]
climate_data_full <- read.csv(filepath)
climate_data <- subset(climate_data_full, subset=c(STATION=="USW00012841"))
droplevels(climate_data)

head(climate_data)
str(climate_data)
unique(climate_data$NAME)
names(climate_data)
## [1] "STATION" "NAME"    "DATE"    "DAPR"    "MDPR"    "PRCP"    "SNOW"   
## [8] "SNWD"    "TMAX"    "TMIN"    "NewDate"

min(climate_data$TMAX, na.rm=T)
## [1] -9999

str(climate_data)
strDates <- as.character(climate_data$DATE)
climate_data$NewDate <- as.Date(strDates, "%Y-%m-%d")


slopeMaxTemp = lm(TMAX ~ NewDate, data= climate_data)
coefMaxTemp = coef(slopeMaxTemp)
# (Intercept)      NewDate  
# 2.834675e+01 8.480721e-06
plot(TMAX ~ NewDate, data= climate_data, ty='l', las=1, xlab = "Date", ylab = "Daily Max Temperature", pch=20)
abline(coefMaxTemp, col="red", lwd=3)
summary(slopeMaxTemp)

# Residuals:
#   Min      1Q  Median      3Q     Max 
# -24.886  -3.165   1.041   4.061  11.203 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 2.835e+01  3.130e-02  905.62  < 2e-16 ***
#   NewDate     8.481e-06  1.991e-06    4.26 2.05e-05 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 5.318 on 36721 degrees of freedom
# (460 observations deleted due to missingness)
# Multiple R-squared:  0.000494,	Adjusted R-squared:  0.0004668 
# F-statistic: 18.15 on 1 and 36721 DF,  p-value: 2.047e-05

climate_data$Month = format(as.Date(climate_data$NewDate), format = "%m")
climate_data$Year = format(climate_data$NewDate, format="%Y")

MonthlyTMAXMean = aggregate(TMAX ~ Month + Year, climate_data, mean)
MonthlyTMAXMean$YEAR = as.numeric(MonthlyTMAXMean$Year)
MonthlyTMAXMean$MONTH = as.numeric(MonthlyTMAXMean$Month)
#plot(MonthlyTMAXMean$TMAX, ty='l', xlab = "Year", ylab = "Monthly Max Temp")
#plot(MonthlyTMAXMean$TMAX[MonthlyTMAXMean$Month=="08"], ty='l', ylab = "August Max Temp")
plot(TMAX~YEAR, data=MonthlyTMAXMean[MonthlyTMAXMean$Month=="08",],
     ty='l', xlim=c(1890, 2022))
augustSlope <- lm(TMAX~YEAR, data=MonthlyTMAXMean[MonthlyTMAXMean$Month=="08",])
abline(coef(augustSlope), col="red")
summary(augustSlope)
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -2.20265 -0.60344 -0.03157  0.61231  2.22548 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 3.238e+01  4.471e+00   7.242  9.7e-11 ***
#   YEAR        4.518e-04  2.292e-03   0.197    0.844    
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.8871 on 99 degrees of freedom
# Multiple R-squared:  0.0003923,	Adjusted R-squared:  -0.009705 
# F-statistic: 0.03885 on 1 and 99 DF,  p-value: 0.8442

#creating a monthly min
MonthlyTMINMean = aggregate(TMIN ~ Month + Year, climate_data, mean)
MonthlyTMINMean$YEAR = as.numeric(MonthlyTMINMean$Year)
# Fixing the Format of Month and Year as numeric
MonthlyTMINMean$YEAR = as.numeric(MonthlyTMINMean$Year)
MonthlyTMINMean$MONTH = as.numeric(MonthlyTMINMean$Month)
head(MonthlyTMINMean)
# Month Year      TMIN YEAR MONTH
# 1    01 1892  9.280645 1892     1
# 2    02 1892 13.172414 1892     2
# 3    03 1892 11.651613 1892     3
# 4    04 1892 17.136667 1892     4
# 5    05 1892 18.990323 1892     5
# 6    06 1892 22.176667 1892     6

Months = c("January", "February", "March", "April",
           "May", "June", "July", "August", "September", "October",
           "November", "December")
# Create a panel so I can see all the figures at once.
par(mfrow = c(4, 3), mar=c(1,1,1,1))
#par(mar=c(1,1,1,1))   mar = c(5, 4, 3, 2) + 0.1
TMAXresult <- NA
for (i in 1:12) {
  # plot(MonthlyTMAXMean£TMAX[MonthlyTMAXMean£Month==i],
  # ty='l')
  plot(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH == i, ], pch= 20 , las = 1, xlim = c(1890, 2020),
       main = Months[i])
  Month.lm <- lm(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH == i, ])
  summary(Month.lm)
  abline(coef(Month.lm), col = "red")
  TMAXresult <- rbind(TMAXresult, cbind(Months[i],
       round(coef(Month.lm)[2], 4), round(summary(Month.lm)$coefficients[2, 4], 4), round(summary(Month.lm)$r.squared,3)))
}

oct.lm <- lm(TMAX ~ YEAR, data = MonthlyTMAXMean[MonthlyTMAXMean$MONTH == 10, ])
summary(oct.lm)

### AND NOW MINIMUMSSS ##### WOOOOO ####AAAA

MonthlyTMINMean = aggregate(TMIN ~ Month + Year, climate_data, mean)
MonthlyTMINMean$YEAR = as.numeric(MonthlyTMINMean$Year)
# Fixing the Format of Month and Year as numeric
MonthlyTMINMean$YEAR = as.numeric(MonthlyTMINMean$Year)
MonthlyTMINMean$MONTH = as.numeric(MonthlyTMINMean$Month)
head(MonthlyTMINMean)

plot(MonthlyTMINMean$TMIN, pch=20)
par(mfrow = c(4, 3), mar=c(1,1,1,1))
TMINresult <- NA
for (i in 1:12) {
  # plot(MonthlyTMAXMean£TMAX[MonthlyTMAXMean£Month==i],
  # ty='l')
  plot(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH == i, ], pch= 20 , las = 1, xlim = c(1890, 2020),
       main = Months[i])
  MonthMin.lm <- lm(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH == i, ])
  summary(MonthMin.lm)
  abline(coef(MonthMin.lm), col = "red")
  TMINresult <- rbind(TMINresult, cbind(Months[i],
                                        round(coef(MonthMin.lm)[2], 4), round(summary(MonthMin.lm)$coefficients[2, 4], 4), round(summary(MonthMin.lm)$r.squared,3)))
}

aug.lm <- lm(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH == 08, ])
summary(aug.lm)
plot(TMIN ~ YEAR, data = MonthlyTMINMean[MonthlyTMINMean$MONTH == 08, ], pch= 20 , las = 1, xlim = c(1890, 2020), main = Months[08])
