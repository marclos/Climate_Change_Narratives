
library(dplyr)


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
  temp2 <- rbind(temp2, temp[order(temp$FIRSTYEAR),][1:5,])
  print(i)
}

plot(LATITUDE~LONGITUDE, data=subset(temp2, subset=FIRSTYEAR<=1961), pch=20, cex=.1, xlab="Long", ylab="Lat", las=1, col="grey70", xlim=c(-170, -35))
points(LATITUDE~LONGITUDE, data=subset(temp2, subset=FIRSTYEAR<=1928), pch=20, cex=.2, col="azure")
points(LATITUDE~LONGITUDE, data=subset(temp2, subset=FIRSTYEAR<=1893), pch=20, cex=.2, col="cornflowerblue")
points(LATITUDE~LONGITUDE, data=subset(temp2, subset=FIRSTYEAR<=1888), pch=20, cex=.3, col="green")
points(LATITUDE~LONGITUDE, data=subset(temp2, subset=FIRSTYEAR<=1873), pch=20, cex=.4, col="blue")


# download Selection Stations by State
i=3

for(i in 1:length(StationStates)){
  url = paste0("https://www.ncei.noaa.gov/pub/data/ghcn/daily/by_station/", temp2$ID[i], ".csv.gz")
  download.file(url,paste0("Data/SP24/",temp2$ID[i], ".csv.gz"), quiet = FALSE, mode = "w", cacheOK = TRUE)
  
  temp3 <- read.csv(gzfile(paste0("Data/SP24/",temp2$ID[i], ".csv.gz")))
  
  print(i)
}

paste0("https://www.ncei.noaa.gov/pub/data/ghcn/daily/by_station/", i, "csv.gz")




