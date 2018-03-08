# Server for Plane Crash App
library(plotly)
library("rworldmap")
library('shiny')
server <- function(input, output) {
  
  plane.year <- reactive({
    
      
  })
  
  pie.data <- reactive({
    if(input$type == "military") {
      return(summary_year_military_plane)
    } else if (input$type == "private") {
      return(summary_year_private_plane)
    } else {
      return(summary_year_other_plane)
    }
    
  })
   
  output$pi.chart <- renderPlotly ({
    
    colors <- c('rgb(211,94,96)', 'rgb(128,133,133)', 
                'rgb(144,103,167)', 'rgb(171,104,87)', 
                'rgb(114,147,203)')
    
    p <- plot_ly(data, labels = ~, values = ~X1960, type = 'pie',
                 textposition = 'inside',
                 textinfo = 'label+percent',
                 insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text',
                 text = ~paste('$', X1960, ' billions'),
                 marker = list(colors = colors,
                               line = list(color = '#FFFFFF', width = 1)),
                 #The 'pull' attribute can also be used to create space between the sectors
                 showlegend = FALSE) %>%
      layout(title = 'United States Personal Expenditures by Categories in 1960',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    
    
  })
  
  output$table <- renderDataTable({
    if(input$type == "military") {
      return(summary_year_military_plane)
    } else if (input$type == "private") {
      return(summary_year_private_plane)
    } else {
      return(summary_year_other_plane)
    }
  })
  
  output$plot <- renderPlot({
    p <- plot_ly (
      type = 'scattergeo',
      lon = c( 42, 39 ) ,
      lat =c( 12, 50 ) ,
      text =c( 'Rome' , 'Greece') ,
      mode = 'markers' )
    
    print(p)
    
  })
}