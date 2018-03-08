#load ggmap

#INSTALL THESE PACKAGES
install.packages('devtools')
devtools::install_github("dkahle/ggmap")
library("ggplot2")
library("ggmap")
library("dplyr")
source('../apikey.R')

#register using your api key
register_google(api.key)
 
# data frame resulting from tabledata.R program
dat <- read.csv('../data/mapvalues.csv', stringsAsFactors = FALSE)
typeof(dat$fat.[1])
highest <- as.data.frame(dat)
highest$fat. <- as.numeric(highest$fat.)
dat$fat. <- as.numeric(dat$fat.)
highest <- highest %>%
       group_by(year) %>%
       summarize(fat. = max(fat., na.rm = TRUE))


highest <- left_join(highest, dat, by = c("fat.", "year"))
highest$location <- sapply(highest$location, str_replace, " ", "+")


# Loop through the addresses to get the latitude and longitude of each address and add it to the
# 'dat' data frame in new columns lat and lon

for(i in 1:nrow(highest)) {
  if (is.character(highest$location[i])) { 
  result <- geocode(dat$location[i], output = "latlon", source = "google")
  highest$lon[i] <- as.numeric(result[1])
  highest$lat[i] <- as.numeric(result[2])
  } else {
    highest$lon[i] <- NA
    highest$lat[i] <- NA
  }
  Sys.sleep(0.3)# to prevent exceeding query limit time out 
}



View(highest)
  
