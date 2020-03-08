install.packages("shiny")
library("shiny")

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
  "Label_Question2"
)

Question3 <- tabPanel(
  "Label_Question3"
)
