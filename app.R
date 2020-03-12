library(shiny)
library(ggplot2)

source("my_ui.R")
source("my_server.R")


# Run the application 
shinyApp(ui = my_ui, server = server)