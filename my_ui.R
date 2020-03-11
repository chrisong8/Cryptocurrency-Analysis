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
      sliderInput(inputId = "volume", p("Current Date of Volumes"), min = 2015, max = 2020, step = 1),
      
      br(),
      
      checkboxInput(inputId = "cryptocurrency",p("Select the cryptocurrency you would like to include:"),choices = c("Bitcoin", "Ethereum")),
      mainPanel(
        fluidRow(
          plotOutput(outputId = "volumeAnalysis"),
        ),
        
      ),
      
      h3("Results and Implications"),
      
      p("Based on the statistics, it was clear that bitcoin was the favored competitor in terms of cryptocurrencies trading. 
        But what's suprising was that Ethereum's volume trading wasn't as small as we thought it would. 
        We were assuming that Bitcoin would be the monopoly in the cryptocurrency business because in a surface level, users tends to only know about Bitcoin. 
        Because of the volume, it defintilt clarify our assumptions of Bitcoin being the only competitor. 
        Thus, the results demonstrates that Bitcoin is popular cryptocurrencies and it doesn't mean they're the only dominating the field. ")
      
    )
  )
)

ui <- 
