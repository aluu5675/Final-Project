# Server for Plane Crash App

library("rworldmap")
library('shiny')
source("Final Project.R")

server <- function(input, output) {

  output$pi.chart <- renderPlotly ({
   
     if(input$type == "military") {
      data.in.use <- summary_year_military_year
    } else if (input$type == "private") {
      data.in.use <- summary_year_private_year
    } else if(input$type == "plane") {
      datain.in.use <- summary_year_other_year
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
  
  output$table <- renderDataTable({
    if(input$type == "military") {
      return(summary_year_military_plane)
    } else if (input$type == "private") {
      return(summary_year_private_plane)
    } else if(input$type == "plane") {
      return(summary_year_other_plane)
    } else if(input$type == "data") {
      return(data_updated)
    }
  })
  
  
  
  output$plot <- renderPlot({
    p <- plotly (
      type = 'scattergeo',
      lon = c( 42, 39 ) ,
      lat =c( 12, 50 ) ,
      text =c( 'Rome' , 'Greece') ,
      mode = 'markers' )
    
    print(p)
    
  })
}
