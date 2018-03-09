# UI for Plane Crash App
Sys.setlocale('LC_ALL','C')
library(shiny)
library(leaflet)
library(shinythemes)
library(plotly)
options(warn = -1)
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
       these incidents based on the data. This will allow us to see how
       we can prevent further plane crash accidents from happening in 
       the future."),
     br(),
     
     radioButtons("type", "Operator Type:",
                  c("Military" = "military",
                    "Private" = "private",
                    "All data" = "data")),
     
     br(),
     
     sliderInput("year",
                 "Year for Charts:",
                 value = c(1960,1970),
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
     
     a("Reference to Database", href="https://aviation-safety.net/database/")
                 
     
     ),
   
  
  mainPanel(                     
    
    tabsetPanel(type = "tabs",
                
                tabPanel(strong("Table of Operators"), br(),
                         p("The data table gives a list of the operators involved in
                           the crashes. By organizing the data by military operators,
                           private operators, or by all of the operators we can see
                           which types of operators are involved in the most accidents
                           based on their category. This also allows us to easily 
                           search for specific operator type and see what accidents
                           it has been involved in through a certain time frame.
                           that time. There's a total occurrence column to indicate
                           the total number of occurrences of accidents by that operator
                           type, a total fatalties for the number of fatalies overall,
                           and an average fatality. If we look at the past 10 years, from
                           2008-2018, we can see that there have only been 45 accidents
                           from private aircraft operators comapred to the 1,801
                           crashes that occurred that year. In addition, if we look
                           at military operators we can see that the greatest number
                           of plane crashes and fatalies came from the Lockheed C-130E
                           Hercules with 69 crashes and 459 fatalities in total. As we
                           can see, this type of operator was most likely not an
                           efficient type of aircraft. These are just a few examples
                           of the pieces of data we can gather from the table."), 
                         dataTableOutput('table')),
  
                
                tabPanel(strong("Bar Chart of Crashes"), br(),
                         p("The bar chart represents an overview of the total number of crashes
                           by the aircraft model. The chart presents data within specified years
                           and fatality range which then shows the total occurences of accident by
                           respective airplane models. As we can see, some of the specific type of
                           aircrafts have more accidents then others. For instance, the two biggest
                           outliers in the data are Curtiss C-46A with 403 accidents and Curtiss
                           C-46D with 235 accidents. Surprisingly the fatalies don't range
                           nearly as high as that of the Lockheed C-130E when we look at the
                           table. This is most likely because the Lockheed C-130E had more
                           civilians on the plane during the crash compared to the Curtiss models.
                           We can still see that the Curtiss C-46A and Curtiss C-46D models
                           weren't the best models during their time."),
                         suppressWarnings(plotlyOutput("bar1.chart"))),
                
                tabPanel(strong("Line Chart of Average fatality"), br(),
                         p("The line chart contains data points from the specified year and fatality.
                           It shows within the specified ranges what the average fatality for the number of
                           accidents for a type of aircraft. As we can see, some models of airplanes have
                           significantly larger average fatality which can be due to the fact that there
                           was only one accident from that model with many civilians on board. The greatest
                           outlier is the Shaanxi Y-8F-200W with 122 fatalities from it's crash that
                           happened recently in 2017. Air traffic control had lost signal with
                           the plane for 29 minutes into the flight causing the plane to crash
                           into the Andaman Sea."),
                         suppressWarnings(plotlyOutput("bar2.chart"))),
                
                tabPanel(strong("Pie Chart of Fatalities Over Total Crashes"), br(),
                         p("The pie chart represents the highest
                           fatality ratios (calculated by dividing the total fatalities
                           of the flight divided by the total crashes recorded that
                           year) as shown automatically for each year.
                           The percentages represent each year's share
                           of the number of fatalities over total flights. As we can see,
                           more of the current years become less induced into having
                           fatalies per accident because there are more safety
                           precautions taken on plane travel during this time. In addition
                           data from earlier years from 1920-1940 rarely make up
                           much of the data since planes weren't frequently
                           used for travel and were still new."),
                         suppressWarnings(plotlyOutput("pi.chart"))),
                         
                tabPanel(strong("Map of Crashes with Most Fatalies for Every Year"), br(), 
                         p("On the map, we can see the places of the crashes
                            with the most number of fatalities in every year.
                            This gives a visual of where these types of crash
                            sites are in the world. This also can give us a 
                            sense of the country of where the biggest accidents 
                            have been occurring throughout the past 98 years.
                            By placing values with the largest number of fatalies
                            within that given year on the map, we can see which
                            plane accidents had the greatest impact during that year.
                            Hovering over the data point shows the year, aircraft
                            model, and number of fatalities in that crash. We can
                            see that a majority of the major crashes are in the US,
                            specifically the eastern part, and just right above France
                            in Europe. This makes sense since most travel occurs
                            between these two continents in the world."),
                         leafletOutput('map'))            
                
                
                
    )
    
  )
  
  )
)


