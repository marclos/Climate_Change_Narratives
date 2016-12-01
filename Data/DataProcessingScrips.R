#Importing Scripts

file = "/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Nicole/Marshfield climate.csv"
import = read.csv(file)
plot(TMAX~DATE, import)

import$TMAX[import$TMAX==-9999] = NA

plot(TMAX~DATE, import[import$DATE<19132131,], ty='l')
plot(TMAX~DATE, import[import$DATE<19130102,], ty='l')
