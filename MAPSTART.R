library("leaflet")
library('ggplot2')
mapping.data <- read.csv("data/highest.csv", stringsAsFactors = FALSE)



leaflet(mapping.data) %>%
  addTiles() %>%
  setView(lng = -10.51668566, lat = 34.36477579, zoom = 2) %>%
  addProviderTiles(providers$CartoDB.Positron)
  
  