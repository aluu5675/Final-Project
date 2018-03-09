# Server for Plane Crash App
Sys.setlocale('LC_ALL','C')
library("rworldmap")
library('shiny')
source("data/read_data.R")
library(dplyr)
source("MAPSTART.R")
options(warn = -1)
server <- function(input, output) {

  output$pi.chart <- renderPlotly ({
     options(warn = -1)
     if(input$type == "military") {
      data.in.use <- military_pi_data
    } else if (input$type == "private") {
      data.in.use <-  private_pi_data
    } else if(input$type == "plane") {
      datain.in.use <- other_pi_data
    } else  {
      data.in.use <- data_updated
    }

    options(warn = -1)
    to.display <- data.in.use %>%
      filter(year >= input$year[1] & year <= input$year[2]) %>%
      filter(total_fatality >= input$fatalities[1] & total_fatality <= input$fatalities[2])
    

    colors <- c('rgb(211,94,96)', 'rgb(128,133,133)',
                'rgb(144,103,167)', 'rgb(171,104,87)',
                'rgb(114,147,203)')
    if(input$type != "data") {
    p <- plot_ly(to.display, labels = ~to.display$year, values = ~to.display$average_fatality, type = 'pie',
                 textposition = 'inside',
                 textinfo = 'label+percent',
                 insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text',
                 text = ~paste("fatality/crash flight", to.display$average_fatality , ', with',
                               to.display$total_fatality, 'fatalities. \nThe plane flown was',
                               'was', to.display$type),
                 marker = list(colors = colors,
                               line = list(color = '#FFFFFF', width = 1)),
                 showlegend = TRUE) %>%
      layout(title = 'Overview of Fatality/total flights ratio for Selected Data',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE) )
    } else {
      p <- plot_ly(to.display, labels = ~to.display$year, values = ~to.display$total_fatality, type = 'pie',
                   textposition = 'inside',
                   textinfo = 'label+percent',
                   insidetextfont = list(color = '#FFFFFF'),
                   hoverinfo = 'text',
                   text = ~paste("Total Fatalities:", to.display$total_fatality ),
                                
                   marker = list(colors = colors,
                                 line = list(color = '#FFFFFF', width = 1)),
                   showlegend = TRUE) %>%
        layout(title = 'Overview of Total Fatalities for Selected Data',
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE) )
      
    } 
    options(warn = -1)
    return(p)
  })

  output$bar1.chart <- renderPlotly({
    options(warn = -1)
    if(input$type == "military") {
      data.in.use <- military_pi_data
    } else if (input$type == "private") {
      data.in.use <-  private_pi_data
    } else if(input$type == "plane") {
      datain.in.use <- other_pi_data
    } else  {
      data.in.use <- data_updated
    }
    
    options(warn = -1)
    to.display <- data.in.use %>%
      filter(year >= input$year[1] & year <= input$year[2]) %>%
      filter(total_fatality >= input$fatalities[1] & total_fatality <= input$fatalities[2]) %>%
      group_by(type)
    
      
    if(input$type == "data"){
      to.display <- summarize(to.display, total = sum(occurence),
                              fat = sum(as.numeric(total_fatality), na.rm = T),
                              average = fat / total)
    } else {
      to.display <- summarize(to.display, total = total_occurence[1],
                              fat = total_fatality[1],
                              average = fat / total)
    }
    
    options(warn = -1) 
    
    p1 <- plot_ly(data = to.display, x = ~total, y = ~type, type = 'bar', orientation = 'h', 
                  marker = list(color = 'red',
                                line = list(color = 'black', width = 1)) ) %>%
      layout(autosize = F, width = 700, height = 15000,
             margin = list(l = 300),
             title = "Total occurence of accidents by aircraft model")
    options(warn = -1)
    return(p1)
  })
  
  output$bar2.chart <- renderPlotly({
    options(warn = -1)
    if(input$type == "military") {
      data.in.use <- military_pi_data
    } else if (input$type == "private") {
      data.in.use <-  private_pi_data
    } else if(input$type == "plane") {
      datain.in.use <- other_pi_data
    } else  {
      data.in.use <- data_updated
    }
    
    options(warn = -1)
    to.display <- data.in.use %>%
      filter(year >= input$year[1] & year <= input$year[2]) %>%
      filter(total_fatality >= input$fatalities[1] & total_fatality <= input$fatalities[2]) %>%
      group_by(type)
    
    
    if(input$type == "data"){
      to.display <- summarize(to.display, total = sum(occurence),
                              fat = sum(as.numeric(total_fatality), na.rm = T),
                              average = fat / total)
    } else {
      to.display <- summarize(to.display, total = total_occurence[1],
                              fat = total_fatality[1],
                              average = fat / total)
    }
    options(warn = -1) 
    
    p2 <- plot_ly(data = to.display, x = ~average, y = ~type, type = 'scatter',
                  mode = 'lines', line = list(color = 'red')) %>%
      layout(autosize = F, width = 700, height = 5000,
             margin = list(l = 300),
             title = "Average fatality per accident by aircraft model")
    options(warn = -1)
    return(p2)
  })
  
  output$table <- renderDataTable({
    if(input$type == "military") {
      data.in.use <- military_pi_data
    } else if (input$type == "private") {
      data.in.use <-  private_pi_data
    } else if(input$type == "plane") {
      datain.in.use <- other_pi_data
    } else  {
      data.in.use <- data_updated
    }
    data.in.use <- filter(data.in.use,year >= input$year[1] & year <= input$year[2]) %>%
      filter(total_fatality >= input$fatalities[1] & total_fatality <= input$fatalities[2]) %>%
      group_by(type)
    
    return(data.in.use)
    
  })



  output$map <- renderLeaflet({
    leaflet(mapping.data) %>%
      addTiles() %>%
      setView(lng = -10.51668566, lat = 34.36477579, zoom = 2) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addMarkers(mapping.data$lon, mapping.data$lat,
                 label = paste0(as.character(mapping.data$year), ", ",
                                as.character(mapping.data$operator),
                                ", ", as.character(mapping.data$fat.)))
  })
}

