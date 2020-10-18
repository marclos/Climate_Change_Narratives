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
min(SCZ$Daily.Mean.PM2.5.Concentration, na.rm=T)
max(SCZ$Daily.Mean.PM2.5.Concentration, na.rm=T)
plot(Date ~ Daily.Mean.PM2.5.Concentration, data= SCZ)

