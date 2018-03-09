# UI for Plane Crash App
library(shiny)
library(leaflet)
library(shinythemes)
library(plotly)
data_updated <- read.csv("data/updated_data.csv", stringsAsFactors = FALSE)


max.for.fatality.slider <- max(as.numeric(data_updated$total_fatality), na.rm = TRUE)
  
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
     
     p("By extracting the data based on location, fatalities, and operator,
       we can see how plane crash accidents have evolved over the years
       and the number of deaths that have occurred from these incidents.
       We can also infer what has happened through history to explain
       these incidents based on the date."),
     br(),
     
     radioButtons("type", "Operator Type:",
                  c("Military" = "military",
                    "Private" = "private",
                    "All data" = "data")),
     
     br(),
     
     sliderInput("year",
                 "Year for Chart:",
                 value = c(1968,2018),
                 min = 1920,
                 max = 2018, 
                 dragRange = TRUE
     ),
     
     
     br(),
     
     sliderInput("fatalities", "Select the Range of Fatalities to Display:", 
                 value = c(0, max.for.fatality.slider),
                 min = 0,
                 max = max.for.fatality.slider),
     
     br(),
     
     a("Reference", href="https://aviation-safety.net/database/")
                 
     
     ),
   
  
  mainPanel(                     
    
    tabsetPanel(type = "tabs",
                
                tabPanel(strong("Table for Operator"), br(),
                         p("The data table gives a list of the operators involved in
                           the crashes. By organizing the data by military operators,
                           private operators, or by any other operators we can see
                           which types of operators are involved in the most accidents
                           based on their category. This gives a sense 
                           of the types of events that could've been happening during
                           that time. There's a total occurrence column to indicate
                           the total number of occurrences of accidents by that operator
                           type, a total fatalties for the number of fatalies overall,
                           and an average fatality."), 
                         dataTableOutput('table')),
  
                
                tabPanel(strong("Bar Chart of Crashes"), br(),
                         p("The bar chart represents an overview of the fatalities
                           by a range of years. The chart presents data within qualified years
                           and fitality range. It shows the total occurences of accident by
                           respective airplane models.
                           As we can see, some of the specific type of aircraft have more accidents
                           then others"),
                         plotlyOutput("bar1.chart")),
                
                tabPanel(strong("Line Chart of Average fatality"), br(),
                         p("The line chart contains data points from the qualified year and fatality,
                           it shows within the qualifies datas, what is the average fatality for a single
                           accident on a type of air plane. As we can see, some kind of airplane have
                           significantly larger average fatality on a single accident"),
                         plotlyOutput("bar2.chart")),
                
                tabPanel(strong("Pi Chart of Crashes"), br(),
                         p("The pie chart represents an overview of the fatalities
                           by a range of years. The highest fatality ratios (calculated by dividing the 
                           total fatalities of the flight divided by the total crashes recorded that
                          year) are shown automatically for each year.

                           The percentages represent each year's share
                           of the number of fatalities by their ratio. As we can see,
                           more of the current years become less induced into having
                           fatalies per accident because there are more safety
                           precautions taken on plane travel during this age."),
                         plotlyOutput("pi.chart")),
                         
                tabPanel(strong("Map of Crashes"), br(), 
                         p("On the map, we can see the places of where
                            each plane site crash was by the given year.
                            This gives a visual of where these types of crash
                            sites are in the world. This also can give us a 
                            sense of the country of where the biggest accident was
                            This could be explained by the current events happening
                            in that country during that time. By placing values
                            the largest number of fatalies within that given
                            year on the map, we can see which plane accidents
                            had the greatest impact during that year and how
                            these crashes have changed along the years."),
                         leafletOutput('map'))            
                
                
                
    )
    
  )
  
  )
)


