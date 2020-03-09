library(shiny)

source("my_ui.R")
source("my_server.R")

# Run the application 
shinyApp(ui = my_ui, server = my_server)
