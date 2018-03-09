library("leaflet")
library('ggplot2')
library(htmltools)
options(warn = -1)
mapping.data <- read.csv("data/highest.csv", stringsAsFactors = FALSE)

leaflet(mapping.data) %>%
  addTiles() %>%
  setView(lng = -10.51668566, lat = 34.36477579, zoom = 2) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addMarkers(mapping.data$lon, mapping.data$lat,
             label = paste0(as.character(mapping.data$year), ", ",
                            as.character(mapping.data$operator),
                            ", ", as.character(mapping.data$fat.)))
  