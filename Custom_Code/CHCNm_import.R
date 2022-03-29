library(R.util)

temp = 
  file.download("https://www.ncei.noaa.gov/pub/data/ghcn/v4/ghcnm.tavg.latest.qcf.tar.gz")

temp2 = gunzip(temp)

