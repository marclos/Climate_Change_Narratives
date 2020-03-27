# Analysis of Monthly Southern Oscillation Index Numbers
library(dplyr)
import = read.table("https://crudata.uea.ac.uk/cru/data/soi/soi.dat", na.strings=-99.99)

import2 = read.table("https://www.esrl.noaa.gov/psd/gcos_wgsp/Timeseries/Data/nino34.long.anom.data", na.strings=-99.99, nrow=150, skip=1)

str(import)
str(import2)

names(import) = c("Year", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Mean")
names(import2) = c("Year", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
head(import)
library(tidyr)
library(zoo)
SO <- import %>% gather(Month, SOI, Jan:Dec)
Nino <- import2 %>% gather(Month, Index, Jan:Dec)

SO$Date = as.yearmon(paste(SO$Year, SO$Month), "%Y %b"); SO <- SO[order(SO$Date),]
Nino$Date = as.yearmon(paste(Nino$Year, Nino$Month), "%Y %b"); Nino <- Nino[order(Nino$Date),]


#SO[complete.cases(SO),]
SO_smooth <- data.frame(
  x = SO$Date[complete.cases(SO)],
  y = as.vector(smooth(SO$SOI[complete.cases(SO)])),
  method = "smooth()"
)

nino_smooth <- data.frame(
  x = Nino$Date[complete.cases(Nino)],
  y = as.vector(smooth(Nino$Index[complete.cases(Nino)])),
  method = "smooth()"
)


pos <- mutate(SO_smooth, SOIp = ifelse(y >= .5, .5, NA))
neg <- mutate(SO_smooth, SOIp = ifelse(y <= -.5, -.5, NA))

pos1 <- mutate(nino_smooth, Ip = ifelse(y >= .5, .5, NA))
neg1 <- mutate(nino_smooth, Ip = ifelse(y <= -.5, -.5, NA))

par(mfrow=c(2,1), las=1, mar=c(2,4,1,0)+.1)
plot(SOI~Date, SO, pch=19, cex=.3, col="grey", xaxt="n")
axis(1, at=seq(1860, 2020, by =10))
lines(y~x, SO_smooth, col="black")
abline(h=0)

with(pos, 
  segments(x, SOIp, x, y, col= 'blue'))
with(pos, polygon(x, SOIp, col="black", lwd=.1))
with(neg, 
     segments(x, SOIp, x, y, col= 'red'))
mtext("A", 2, 3, at=3, cex=2)

plot(Index~Date, Nino, pch=19, cex=.3, col="grey", xaxt="n", xlim=c(1866,2020))
axis(1, at=seq(1860, 2020, by =10))
lines(y~x, nino_smooth, col="black")
abline(h=0)

with(pos1, 
     segments(x, Ip, x, y, col= 'red'))
with(pos1, polygon(x, Ip, col="black", lwd=.1))
with(neg1, 
     segments(x, Ip, x, y, col= 'blue'))
with(neg1, polygon(x, Ip, col="black", lwd=.1))
mtext("B", 2, 3, at=3, cex=2)

### Bar Graph Approach
SO$col = ifelse(SO$SOI <= -1, 2, ifelse(SO$SOI >= 1, 3, 1))
SO.mat = matrix(c(SO$Date, SO$SOI), ncol=2)
length(SO.mat[,2])
col=c("grey", "red", "blue")
barplot(SO.mat[,2], col=col[SO$col], border=col[SO$col], 
    ylim=c(-5,5), las=1, names.arg = SO.mat[,1])
#axis(1, at=seq(0,length(SO.mat[,1]), by=360), labels=SO.mat[seq(1,length(SO.mat[,1]), by=360),1])
