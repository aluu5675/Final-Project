# Server for Plane Crash App
library(plotly)
library("rworldmap")
server <- function(input, output) {
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