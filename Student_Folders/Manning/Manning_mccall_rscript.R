# Download Mccall Data
  setwd("~/Climate_Change_Narratives/Student_Folders/Manning")
  mccall=read.csv("manning_mccall_data.csv")

# Dataframe with max and min temperature
  names(mccall)
  hist(mccall$TMIN)
  hist(mccall$TMAX)
  
  #Minimum Temperature Graph
  plot(mccall$DATE, mccall$TMIN)
  lm(TMAX~DATE, data=mccall)
  
  summary(mccall$TMAX)  
  stripchart(DATE~TMAX, mccall,method="jitter”)
  
  
  
  
  
  