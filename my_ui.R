library("shiny")

bitcoin <-  read.csv("Binance_BTCUSDT_d.csv", stringsAsFactors = FALSE)
ethereum <- read.csv("Binance_ETHUSDT_d.csv", stringsAsFactors = FALSE)

Home <- tabPanel(
  "Label_Home"
)

Question1 <- tabPanel(
  "Label_Question1"
)

Question2 <- tabPanel(
  "Label_Question2"
)

Question3 <- tabPanel(
  "Label_Question3"
)

my_ui <- navbarPage(
  "Trends in Cryptocurrencies!",
  Home,
  Question1,
  Question2,
  Question3
)