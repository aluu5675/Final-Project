# Server for Plane Crash App
library(plotly)
library("rworldmap")
library('shiny')
server <- function(input, output) {
  
  plane.year <- reactive({
      
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