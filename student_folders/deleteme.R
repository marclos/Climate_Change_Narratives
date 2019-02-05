## Vanessa's Date Issues

climate = read.csv("/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Data/SP18/VRS_LAUSC_DATA.csv")

head(climate)

strDates <- as.character(climate$DATE)
strDates

head(strDates)

as.Date(strDates, "%m/%d/%Y")



