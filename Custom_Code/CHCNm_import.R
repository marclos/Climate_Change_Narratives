library(R.utils)

url ="https://www.ncei.noaa.gov/pub/data/ghcn/v4/ghcnm.tavg.latest.qcf.tar.gz"

download.file(url, "temp.gz")

untar("temp.gz", list=TRUE)

untar("temp.gz")

dat = "/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Social_Media/ghcnm.v4.0.1.20220328/ghcnm.tavg.v4.0.1.20220328.qcf.dat"
read.table(dat)


#noaa_dir <- "pathname of directory with GHCN data"
#noaaout <- "pathname of directory for output files"

library(dplyr) 
numFiles <- length(us80$ID)
dirname <- paste0(noaa_dir,"ghcnd_all/ghcnd_all/")

for (i in 1:numFiles) {
  infile <- paste0(dirname, us80$ID[i], ".dly")
  outfile <- paste0(noaaout, us80$ID[i], ".csv")
  
  
  #Each record in a file contains one month of daily data.  The variables on each
  #line include the following:
  #
  #------------------------------
  #Variable   Columns   Type
  #------------------------------
  #ID            1-11   Character
  #YEAR         12-15   Integer
  #MONTH        16-17   Integer
  #ELEMENT      18-21   Character
  #VALUE1       22-26   Integer
  #MFLAG1       27-27   Character
  #QFLAG1       28-28   Character
  #SFLAG1       29-29   Character
  #VALUE2       30-34   Integer
  #MFLAG2       35-35   Character
  #QFLAG2       36-36   Character
  #SFLAG2       37-37   Character
  #  .           .          .
  #  .           .          .
  #  .           .          .
  #VALUE31    262-266   Integer
  #MFLAG31    267-267   Character
  #QFLAG31    268-268   Character
  #SFLAG31    269-269   Character
  #------------------------------
  
  
  cols <- c( "A11", "I4", "I2", "A4",
             rep( c( "I5", "A1", "A1", "A1"), 31) )
  df <- read.fortran(infile, cols, na.strings="-9999") # -9999 indicates missing data
  
  # next, fill in the column names
  tmp <- c("Val","xxM","xxQ","xxS") # xx so we can ditch them later
  vhdrs <- paste(   rep(tmp,31),   rep(1:31,each=4), sep="")
  hdrs <- c("ID", "year", "month", "element", vhdrs)
  names(df) <- hdrs
  df <- df[df$year >= 1936 & df$year <= 2015,]
  df_out <- dplyr::select(df, -matches("xx*")) # get rid of M, Q, S 
  write.csv(df_out, outfile)
}