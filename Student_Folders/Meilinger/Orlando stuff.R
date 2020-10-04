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
