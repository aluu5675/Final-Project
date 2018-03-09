# Code to run app
Sys.setlocale('LC_ALL','C')
source("ui.R")
source("server.R")
shinyApp(ui = ui, server = server)

