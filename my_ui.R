library("shiny")
library("ggplot2")

navbarPage(
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
  "Label_Question3",
  
  br(),
  
  fluidRow(
    h1("How do the trading volumes of Bitcoin and Ethereum compare with each other over time?"),
    p("Volume represents, among other things, potential and interest in the currency. 
         For example, if we see that both currencies have increasing volume over time, we may believe that cryptocurrency may be getting more popular, and that we may see even more investment in the near future. 
         Our datasets for Bitcoin and Ethereum have 2 features that measure volume, 1 for USD and 1 in terms of their own currency (BTC/ETH). The USD feature was used as it would make more sense to an audience that likely has more knowledge of USD than knowledge of cryptocurrency
        "),
    
    br()
    
  ),
  sidebarLayout(
    sidebarPanel(
      sliderInput("volume", p("Current Date of Volumes"), min = 2015, max = 2020, step = 1),
      
      br(),
      
      checkboxInput("cryptocurrency",p("Select the cryptocurrency you would like to include:"),choices = c("Projected population"=1,"Thefts"=2,"Traffic accidents"=3,"Homicides"=4,"School deserters"=5,"Sports venues"=6,"Extortions"=7),selected = c("Projected population"=1,"Thefts"=2,"Traffic accidents"=3,"Homicides"=4,"School deserters"=5,"Sports venues"=6,"Extortions"=7)),
      mainPanel(
        plotOutput(outputId = "volumeEthereum"),
        plotOutput(outputId = "volumeBitcoin"),
        
      )
      
    )
  )
)

ui <- 
