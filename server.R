# Server for Plane Crash App

library("rworldmap")
library('shiny')
source("data/read_data.R")
library(dplyr)

server <- function(input, output) {

  output$pi.chart <- renderPlotly ({

     if(input$type == "military") {
      data.in.use <- military_pi_data
    } else if (input$type == "private") {
      data.in.use <-  private_pi_data
    } else if(input$type == "plane") {
      datain.in.use <- other_pi_data
    } else  {
      data.in.use <- data_updated
    }


    to.display <- data.in.use %>%
      filter(year >= input$year[1] & year <= input$year[2]) %>%
      filter(total_fatality >= input$fatalities[1] & total_fatality <= input$fatalities[2])



    colors <- c('rgb(211,94,96)', 'rgb(128,133,133)',
                'rgb(144,103,167)', 'rgb(171,104,87)',
                'rgb(114,147,203)')

    p <- plot_ly(to.display, labels = ~to.display$year, values = ~to.display$total_fatality, type = 'pie',
                 textposition = 'inside',
                 textinfo = 'label+percent',
                 insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text',
                 text = ~paste(to.display$total_fatality , 'fatalities'),
                 marker = list(colors = colors,
                               line = list(color = '#FFFFFF', width = 1)),
                 showlegend = TRUE) %>%
      layout(title = 'Overview of Fatalities for Selected Data',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE) )

    return(p)
  })

  output$bar1.chart <- renderPlotly({
    
    if(input$type == "military") {
      data.in.use <- military_pi_data
    } else if (input$type == "private") {
      data.in.use <-  private_pi_data
    } else if(input$type == "plane") {
      datain.in.use <- other_pi_data
    } else  {
      data.in.use <- data_updated
    }
    
    
    to.display <- data.in.use %>%
      filter(year >= input$year[1] & year <= input$year[2]) %>%
      filter(total_fatality >= input$fatalities[1] & total_fatality <= input$fatalities[2]) %>%
      group_by(type) %>%
      summarize(total = total_occurence[1],
                fat = total_fatality[1],
                average = total / fat)
    
    options(warn = -1) 
    
    p1 <- plot_ly(data = to.display, x = ~total, y = ~type, type = 'bar', orientation = 'h', 
                  marker = list(color = 'red',
                                line = list(color = 'black', width = 1)) ) %>%
      layout(autosize = F, width = 700, height = 15000,
             margin = list(l = 300),
             title = "Total occurence of accidents by aircraft model")
    
    return(p1)
  })
  
  output$bar2.chart <- renderPlotly({
    
    if(input$type == "military") {
      data.in.use <- military_pi_data
    } else if (input$type == "private") {
      data.in.use <-  private_pi_data
    } else if(input$type == "plane") {
      datain.in.use <- other_pi_data
    } else  {
      data.in.use <- data_updated
    }
    
    
    to.display <- data.in.use %>%
      filter(year >= input$year[1] & year <= input$year[2]) %>%
      filter(total_fatality >= input$fatalities[1] & total_fatality <= input$fatalities[2]) %>%
      group_by(type) %>%
      summarize(total = total_occurence[1],
                fat = total_fatality[1],
                average = fat / total)
    
    
    options(warn = -1) 
    
    p2 <- plot_ly(data = to.display, x = ~average, y = ~type, type = 'scatter',
                  mode = 'lines', line = list(color = 'red')) %>%
      layout(autosize = F, width = 700, height = 5000,
             margin = list(l = 300),
             title = "Average fatality per accident by aircraft model")
    
    return(p2)
  })
  
  output$table <- renderDataTable({
    if(input$type == "military") {
      return(military_table_data)
    } else if (input$type == "private") {
      return(private_table_data)
    } else if(input$type == "plane") {
      return(other_table_data)
    } else if(input$type == "data") {
      return(data_updated)
    }
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

