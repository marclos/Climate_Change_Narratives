library(chron)
library(RColorBrewer)
library(lattice)
library(ncdf)
library(ncdf4)
library(greenbrown) # for gridded trend analysis

ersst.nc = "/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Data/FA19/ersst.v5.185401.nc"
Y1854 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1854.asc"
Y1864 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1864.asc"
Y1874 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1874.asc"
Y1884 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1884.asc"
Y1894 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1894.asc"
Y1904 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1904.asc"
Y1914 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1914.asc"
Y1924 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1924.asc"
Y1934 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1934.asc"
Y1944 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1944.asc"
Y1954 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1954.asc"
Y1964 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1964.asc"
Y1974 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1974.asc"
Y1984 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1984.asc"
Y1994 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.1994.asc"
Y2004 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.2004.asc"
Y2014 = "https://www1.ncdc.noaa.gov/pub/data/cmb/ersst/v5/ascii/ersst.v5.2014.asc"

temp = rbind(read.table(Y1854)[75,67], read.table(Y1864)[75,67], read.table(Y1874)[75,67],
             read.table(Y1884)[75,67], read.table(Y1894)[75,67], read.table(Y1904)[75,67],
             read.table(Y1914)[75,67], read.table(Y1924)[75,67], read.table(Y1934)[75,67],
             read.table(Y1944)[75,67], read.table(Y1954)[75,67], read.table(Y1964)[75,67],
             read.table(Y1974)[75,67], read.table(Y1984)[75,67], read.table(Y1994)[75,67],
             read.table(Y2004)[75,67], read.table(Y2014)[75,67])

temp.df = data.frame(Temp = as.vector(temp)/100); temp.df
temp.df$Year = seq(1854, 2014, 10)
plot(Temp~ Year, temp.df)
abline(coef(lm(Temp~Year, data=temp.df)), col="red")
#automating this process!