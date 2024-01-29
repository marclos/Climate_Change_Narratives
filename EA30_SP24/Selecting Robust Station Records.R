
library(dplyr)
library(R.utils)
library(usmap)
library(ggplot2)


#devtools::install_github(“UrbanInstitute/urbnmapr”)

# Get Stations Data (Inventory)
inventory_names = c("ID", #            1-11   Character
                      "LATITUDE", #     13-20   Real
                      "LONGITUDE", #    22-30   Real
                      "ELEMENT", #      32-35   Character
                      "FIRSTYEAR", #    37-40   Integer
                      "LASTYEAR")

inventory = read.table("https://www.ncei.noaa.gov/pub/data/ghcn/daily/ghcnd-inventory.txt")
names(inventory) = inventory_names
str(inventory)

inventory.TMAX = subset(inventory, subset=ELEMENT=="TMAX"); str(inventory.TMAX)

plot(inventory.TMAX$LONGITUDE, inventory.TMAX$LATITUDE)

plot(inventory.TMAX$LONGITUDE, inventory.TMAX$LATITUDE, pch=20, cex=.4)

# Selective ~Active Stations

inventory.TMAX = subset(inventory.TMAX, subset=LASTYEAR>=2022); str(inventory.TMAX)

plot(inventory.TMAX$LONGITUDE, inventory.TMAX$LATITUDE, pch=20, cex=.4, xlab="Long", ylab="Lat", las=1)

#par(mfrow=c(2,2))

plot(LATITUDE~LONGITUDE, data=subset(inventory.TMAX, subset=FIRSTYEAR<=1961), pch=20, cex=.1, xlab="Long", ylab="Lat", las=1, col="grey70")
points(LATITUDE~LONGITUDE, data=subset(inventory.TMAX, subset=FIRSTYEAR<=1928), pch=20, cex=.2, col="azure")
points(LATITUDE~LONGITUDE, data=subset(inventory.TMAX, subset=FIRSTYEAR<=1893), pch=20, cex=.2, col="cornflowerblue")
points(LATITUDE~LONGITUDE, data=subset(inventory.TMAX, subset=FIRSTYEAR<=1888), pch=20, cex=.3, col="green")
points(LATITUDE~LONGITUDE, data=subset(inventory.TMAX, subset=FIRSTYEAR<=1873), pch=20, cex=.4, col="blue")

# Read All Stations

station_names = c("ID", #           1-11   Character 11
                   "LATITUDE", #     13-20   Real     8
                   "LONGITUDE", #    22-30   Real     9
                   "ELEVATION", #   32-37   Real      6
                   "STATE", #        39-40   Character 2
                   "NAME", #        42-71   Character
                   "GSN FLAG", #    73-75   Character
                   "HCN/CRN FLAG", # 77-79   Character
                   "WMO ID" #      81-85   Character
                   )

Stations = read.fwf("https://www.ncei.noaa.gov/pub/data/ghcn/daily/ghcnd-stations.txt", col.names=station_names, fill=2,
        widths=c(11, -1, 8, -1, 9, -1, 6, -1, 2, -1, 30, -1, 3, -1, 3, -1, 5 ))

str(Stations)

# Read ghcnd-states.txt

State_names = c("STATE", #         1-2    Character 2
                "STATE_NAME") #         4-50    Character 46

States = read.fwf("https://www.ncei.noaa.gov/pub/data/ghcn/daily/ghcnd-states.txt", col.names=State_names, fill=2, widths=c(2, -1, 46))

str(States)

StateIDs = subset(Stations, select=c("ID", "STATE"))
StateIDs = merge(StateIDs, States, by="STATE")

temp.TMAX = merge(inventory.TMAX, StateIDs, by="ID")

Station.sel = subset(temp.TMAX, subset=(STATE!="  "))

# Missing some in States!
StationStates = unique(Station.sel$STATE)
i = 3
temp2<-NULL

for(i in 1:length(StationStates)){
  temp=subset(Station.sel, subset=(STATE==StationStates[i])); str(temp)
  x=5 # Some STATES don't have five stations
  if(nrow(temp)< 5) x <-nrow(temp)
  temp2 <- rbind(temp2, temp[order(temp$FIRSTYEAR),][1:x,])
  print(i)
}

plot(LATITUDE~LONGITUDE, data=subset(temp2, subset=FIRSTYEAR<=1961), pch=20, cex=.1, xlab="Long", ylab="Lat", las=1, col="grey70", xlim=c(-165, -50))
points(LATITUDE~LONGITUDE, data=subset(temp2, subset=FIRSTYEAR<=1928), pch=20, cex=.2, col="azure")
points(LATITUDE~LONGITUDE, data=subset(temp2, subset=FIRSTYEAR<=1893), pch=20, cex=.2, col="cornflowerblue")
points(LATITUDE~LONGITUDE, data=subset(temp2, subset=FIRSTYEAR<=1888), pch=20, cex=.3, col="green")
points(LATITUDE~LONGITUDE, data=subset(temp2, subset=FIRSTYEAR<=1873), pch=20, cex=.4, col="blue")


# Download Updated Station Data
i=3

for(i in 1:nrow(temp2)){
  url = paste0("https://www.ncei.noaa.gov/pub/data/ghcn/daily/by_station/", temp2$ID[i], ".csv.gz")
  download.file(url,paste0("Data/SP24/",temp2$ID[i], ".csv.gz"), quiet = FALSE, mode = "w", cacheOK = TRUE)
  
  temp3 <- read.csv(gzfile(paste0("Data/SP24/",temp2$ID[i], ".csv.gz")), header=FALSE)
  print(i)
}

# Map Stations by State
State = "CA"
  State.sel <- temp2[temp2$STATE==State,]
  
  # Lat/Lon of Stations
  location_data <- subset(State.sel, select=c(LONGITUDE, LATITUDE))
  names(location_data) <- c("lon", "lat")
  transformed_data <- usmap_transform(location_data)
  
  plot_usmap(include=State) + 
    geom_point(data = transformed_data, 
               aes(x = x, y = y), 
               color = "grey40",
               size = 2)
  
  
  for(i in 1:nrow(State.sel)){
      csv.gz = paste0("Data/SP24/",temp2$ID[i], ".csv.gz")
      
      gunzip(csv.gz, remove=FALSE)
      assign(paste0(temp2$ID[i]), read.csv(paste0("Data/SP24/", temp2$ID[i], ".csv"), header=F))
      
      # NAMES OF VARIABLES ARE INCORRECT
      
      #ID = 11 character station identification code
      #YEAR/MONTH/DAY = 8 character date in YYYYMMDD format (e.g. 19860529 = May 29, 1986)
      #ELEMENT = 4 character indicator of element type 
      #DATA VALUE = 5 character data value for ELEMENT 
      #M-FLAG = 1 character Measurement Flag 
      #Q-FLAG = 1 character Quality Flag 
      #S-FLAG = 1 character Source Flag 
      #OBS-TIME = 4-character time of observation in hour-minute format (i.e. 0700 =7:00 am); if no ob time information 
      #is available, the field is left empty
      
      
      #names(get(temp2$ID[i])) <- c("ID", "DATE", "ELEMENT", "VALUE", "M-FLAG", "Q-FLAG", "S-FLAG", "OBS-TI")
   
      Temp4 <- get(temp2$ID[i])
      names(Temp4) <- c("ID", "DATE", "ELEMENT", "VALUE", "M-FLAG", "Q-FLAG", "S-FLAG", "OBS-TI")
      plot(VALUE/10 ~ DATE, data=Temp4[Temp4$ELEMENT=="TMAX",])
      
      # Convert Dates
      
      # Create Monthly Averages
      
      # Linear Regression
      
      # Add to datset of Station.sel
      
      # Plots...and Maps
      
  }

  download.file(url,paste0("Data/SP24/",temp2$ID[i], ".csv.gz"), quiet = FALSE, mode = "w", cacheOK = TRUE)
  
  temp3 <- read.csv(gzfile(paste0("Data/SP24/",temp2$ID[i], ".csv.gz")))
  print(i)
}

#paste0("https://www.ncei.noaa.gov/pub/data/ghcn/daily/by_station/", i, "csv.gz")