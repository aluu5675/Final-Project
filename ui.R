# UI for Plane Crash App
library(shiny)
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
     
     
     h2(strong("Purpose")),
     
     p("By extracting the data based location, fatalities, and operator,
       we can see how plane crash accidents have evolved over the years
       and the number of deaths that have occurred from these incidents.
       We can also infer what has happened through history to explain
       these incidents based on the date."),
     br(),
     
     a("Reference", href="https://aviation-safety.net/database/")
     
     
     ),
   
  
  mainPanel(                     
    
    tabsetPanel(type = "tabs",
                
                tabPanel(strong("Table for Operator"), br(),
                         p("The data table gives a list of the operators involved in
                           the crashes in the given years. By organizing the data by 
                           military operators, we can see which types of operators
                           are involved in the most accidents."),
                         sliderInput("year",
                                     "Year:",
                                     value = 1968,
                                     min = 1920,
                                     max = 2018)),
                
                tabPanel(strong("Plots of Crash Data by Year"), br(), 
                         p("The plots display graphs of average fatality
                           over the given year due to plane crash accidents.
                           We can see that fatalities are commonly low in
                           the beginning years since traveling by plane is
                           not as prevalent during this time period. Throughout 
                           later decades, more and more accident become
                           greater since planes are becoming a more a efficient
                           way of travel. Safety becomes a greater priority in
                           the current decade compared to the previous years."),
                         numericInput("crash year",
                                      "Crash Year:",
                                      value = 1968,
                                      min = 1920,
                                      max = 2018,
                                      step = 1)),
                
                tabPanel(strong("Map of Crashes"), br(), 
                         p("On the map, we can see the places of where
                           each plane site crash was by the given year.
                           This gives a visual of where these types of crash
                           sites are in the world. This also can give us a 
                           sense of the country of where most of these 
                           accidents are occurring. This could be explained
                           by the current events happening in that country
                           during that time."),
                         sliderInput("date",
                                     "Date:",
                                     value = 1968,
                                     min = 1920,
                                     max = 2018),
                         plotOutput('plot'))
                
                
    )
    
    
  )
  
  )
)

