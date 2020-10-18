SCZ2020.csv <- "/home/CAMPUS/smac2019/Climate_Change_Narratives/Student_Folders/Meilinger/Daily 2020 Oak.csv"
SCZ2019.csv <- "/home/CAMPUS/smac2019/Climate_Change_Narratives/Student_Folders/Meilinger/Daily 2019 Oak.csv"
SCZ2018.csv <- "/home/CAMPUS/smac2019/Climate_Change_Narratives/Student_Folders/Meilinger/Daily 2018 Oak.csv"
SCZ2017.csv <- "/home/CAMPUS/smac2019/Climate_Change_Narratives/Student_Folders/Meilinger/Daily 2017 Oak.csv"
SCZ2016.csv <- "/home/CAMPUS/smac2019/Climate_Change_Narratives/Student_Folders/Meilinger/Daily 2016 Oak.csv"

SCZ2019 = read.csv(SCZ2019.csv)
SCZ2020 = read.csv(SCZ2020.csv)
SCZ2018 = read.csv(SCZ2018.csv)
SCZ2017 = read.csv(SCZ2017.csv)
SCZ2016 = read.csv(SCZ2016.csv)

SCZ=rbind(SCZ2018, SCZ2019, SCZ2020, SCZ2017, SCZ2016)

Date.char = as.character(SCZ$Date)

Date.char = as.character(SCZ$Date)
# testing to make sure this works...
# as.Date(Date.char, format="%Y-%m-%d")
SCZ$Date = as.Date(Date.char, format="%m/%d/%Y")
str(SCZ)
names(SCZ)

# [1] "Date"                           "Source"                        
# [3] "Site.ID"                        "POC"                           
# [5] "Daily.Mean.PM2.5.Concentration" "UNITS"                         
# [7] "DAILY_AQI_VALUE"                "Site.Name"                     
# [9] "DAILY_OBS_COUNT"                "PERCENT_COMPLETE"              
# [11] "AQS_PARAMETER_CODE"             "AQS_PARAMETER_DESC"            
# [13] "CBSA_CODE"                      "CBSA_NAME"                     
# [15] "STATE_CODE"                     "STATE"                         
# [17] "COUNTY_CODE"                    "COUNTY"                        
# [19] "SITE_LATITUDE"                  "SITE_LONGITUDE"  

#plotting
par(mfrow= c(1,2), cex.main=0.75, cex.lab=0.75, cex.axis=0.75, pin= c(1.5, 1) )
min(SCZ$Daily.Mean.PM2.5.Concentration, na.rm=T)
max(SCZ$Daily.Mean.PM2.5.Concentration, na.rm=T)
plot(SCZ$Daily.Mean.PM2.5.Concentration ~ SCZ$Date, data= SCZ, ylim= c(1,40), xlab = "Year", ylab = "Daily PM 2.5", main = "Daily PM 2.5 Readings in Oakland Califonia")
abline(h=12, col="red")
plot(SCZ$Daily.Mean.PM2.5.Concentration ~ SCZ$Date, data= SCZ, xlab = "Year", ylab = "Daily PM 2.5", main = "Daily PM 2.5 Readings in Oakland Califonia")
abline(h=12, col="red")

library(dplyr)
library(lubridate)
#str(SCZ)
tmp1 <- mutate(SCZ, Date = ymd(Date),Year = year(Date), Month = month(Date))
tmp2 <- group_by(tmp1, Month, Year)
Monthly <- summarise(tmp2, result = mean(Daily.Mean.PM2.5.Concentration) )
Monthly <- SCZ %>%
  mutate(Date = ymd(Date),Year = year(Date), Month = month(Date)) %>%
  group_by(Month) %>%
  summarise(mean = mean(Daily.Mean.PM2.5.Concentration),
            sd = sd(Daily.Mean.PM2.5.Concentration),
            N = length(Daily.Mean.PM2.5.Concentration) )

qnorm(.975)
## [1] 1.959964
Monthly$UCL95 = Monthly$mean + qnorm(.975)*Monthly$sd/sqrt(Monthly$N)
Monthly$LCL95 = Monthly$mean - qnorm(.975)*Monthly$sd/sqrt(Monthly$N)

library(xtable)
Monthly$Months
4
## Warning: Unknown or uninitialised column: `Months`.
NULL
print(xtable(Monthly), include.rownames=FALSE)
