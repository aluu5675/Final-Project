#load ggmap

#INSTALL THESE PACKAGES
#install.packages('devtools')
#devtools::install_github("dkahle/ggmap")
library("ggplot2")
library("ggmap")
source('../apikey/apikey.R')

#register using your api key
register_google(api.key)
 
# data frame resulting from tabledata.R program
dat <- dat 



# Loop through the addresses to get the latitude and longitude of each address and add it to the
# 'dat' data frame in new columns lat and lon

for(i in 1:nrow(dat)) {
  if (is.character(dat$location[i])) { 
  result <- geocode(dat$location[i], output = "latlon", source = "google")
  dat$lon[i] <- as.numeric(result[1])
  dat$lat[i] <- as.numeric(result[2])
  } else {
    dat$lon[i] <- NA
    dat$lat[i] <- NA
  }
  Sys.sleep(0.3)# to prevent exceeding query limit time out 
}



