# UI for Plane Crash App
library(shinythemes)
library(plotly)
ui <- fluidPage(
  
  theme = shinytheme("slate"),
  
  includeCSS("style.css"),
  
  
  titlePanel(h1("Plane Crash Data from 1920-2018")
           
   
  ),
  
  sidebarLayout(
    
     sidebarPanel(
     h2(strong("Description")),
     

     p("This data was collected from the Aviation Safety
               Network Database, containing descriptions of the 
               incidents with the aircraft type, operator, date,
               and location of the crash."),
     br(),
     
     
     h2(strong("Purpose"))
     
     
     ),
  
  
  mainPanel(                     
    
    tabsetPanel(type = "tabs",
                
                tabPanel(strong("Table for Operator"), br(),
                         p("The data table gives a list of the operators involved in the crashes in the given years.")),
                fluidRow(
                  
                  column(4,
                         wellPanel(
                           sliderInput("obs", "Number of observations:",  
                                       min = 1, max = 1000, value = 500)
                         )       
                  ),
                  
                  column(8,
                         plotOutput("distPlot")
                  )
                ),
                tabPanel(strong("Map of Crashes"), br(),
                         plotOutput('plot'))
                
                
    )
    
    
  )
  
  )
)

