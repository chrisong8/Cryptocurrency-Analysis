# install.packages("shiny")
library("shiny")
# install.packages("ggplot2")
library("ggplot2")

bitcoin <-  read.csv("Binance_BTCUSDT_d.csv", stringsAsFactors = FALSE)
ethereum <- read.csv("Binance_ETHUSDT_d.csv", stringsAsFactors = FALSE)

Main_UI_Section <- navbarPage(
  "Trends in Cryptocurrencies!",
  Home,
  Question1,
  Question2,
  Question3
)

Home <- tabPanel(
  "Label_Home"
)

Question1 <- tabPanel(
  "Label_Question1"
)

Question2 <- tabPanel(
  "Bitcoin vs Ethereum price", 
  titlePanel("Comparing Bitcoin versus Ethereum prices over time"),
  sidebarPanel(
    checkboxInput(
      id = "combined_price_data",
      choices = c("2017", "2018", "2019", "2020")
    ),
  ),
  p("How do the price values of Bitcoin and Ethereum compare with each other
    over time? Bitcoin and Ethereum are the 2 biggest currencies, and we look 
    to examine if their price trends are related in some way. As Bitcoin and Ethereum
    comprise a large amount of the cryptocurrency market share, this could suggest
    trends for cryptocurrency itself, since price is influenced by things such as 
    supply and demand. For this visualization, we will use the value of each 
    currency at market close."),
  renderPlot(price_analysis),
  p("We chose to visualize the relationship between Bitcoin and Ethereum price values
    with a point scatterplot. The x-axis represents dates, and the y-axis represents
    the price values in USD. The colors of the points represent the currency the observation
    belongs to. The years that you would like to view can be changed by checking boxes of 
    any combination of years from 2017 to 2020.")
)

Question3 <- tabPanel(
  "Label_Question3"
)
