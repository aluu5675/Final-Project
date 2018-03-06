#load ggmap
library("ggplot2")
library("ggmap")
 
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
    dat$geoAddress[i] <- NA
  }
  Sys.sleep(0.5) # to prevent exceeting query limit time out 
}



