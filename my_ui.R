# install.packages("shiny")
library("shiny")
# install.packages("ggplot2")
library("ggplot2")
#install.packages("shinythemes")
library("shinythemes")

Home <- tabPanel(
  icon("home"),
  fluidRow(column(tags$img(src="bitcoin.jpg", width="200px",height="260px"),width=2),
           column(
             h4(p("Our projects looks to investigate the trends of cryptocurrency. Cryptocurrency is a digital 
               form of money/currency. In simple terms, it only has an electronic form. Like regular money, it 
               may be bought,traded, or accepted as payment, but it can also be mined. Cryptocurrency is mined 
               in a process in which transactions for the currency are verified, then added to the blockchain, 
               a constantly-growing database that exists on multiple computers at the same time. We seek to 
               investigate the 2 biggest cryptocurrencies (together they comprise over two thirds of market 
               share in June 2019): Bitcoin and Ethereum. We believe examining the most popular currencies 
               would allow us to spot trends of cryptocurrency in general. Currency usage in human civilization 
               has shifted from barter trading, to universal monetary standards such as the dollar, to recent 
               usage of cryptocurrency in many markets. Therefore, it could be interesting to examine what many 
               coin as the next big thing for currency's evolution.", 
                  style="text-align:left;color:black;background-color:lavender;padding:15px;border-radius:10px")),
             width = 8
           ),
           column(tags$img(src="ethereum.jpg", width="200px",height="260px"),width=2)),
  hr(),
  p(
    "We analyzed two historical datasets that span from 2017 to 2020, one each for the Bitcoin and Ethereum currencies.
    The data sets consist of daily prices, transactions, and volume. It was collected by data scientists and researchers
    at CryptoDataDownload, and has been updated daily since 2017. We previously used this data to create a data report, 
    which is linked below along with the links for the data sets.",
    br(),
    a("Bitcoin Data Set, ", href = "https://www.cryptodatadownload.com/cdd/Binance_BTCUSDT_d.csv"), 
    a("Ethereum Data Set, ", href = "https://www.cryptodatadownload.com/cdd/Binance_ETHUSDT_d.csv"),
    a("Data Report ", href = "https://info201a-wi20.github.io/project-report-samyakUW/")
  ),
  p(
    h3("Target questions:"), style="text-align:center"
  ),
  fluidRow(
    column(width = 1),
    column(
      h5(p("1. How do the values of cryptocurrencies Bitcoin and Ethereum change in comparison to their trading 
      volumes? This is significant as strong trends in both value and volume may be indicators of the rise 
      of digital currency as a replacement for the universal-standard physical currency we have today. Our 
      2 datasets for Bitcoin and Ethereum both contain multiple features each for value and volume that can
      represent them."),
         p("2. How do the price values of Bitcoin and Ethereum compare with each other over time? Bitcoin and 
      Ethereum are the 2 biggest currencies, and we look to examine if their price trends are related in 
      some way. As Bitcoin and Ethereum comprise a large amount of the cryptocurrency market share, this 
      could suggest trends for cryptocurrency itself, since price is influenced by things such as supply and 
      demand. Our datasets for the currencies have multiple features for measuring price value, but we will 
      use the feature Close that captures prices when the market closes for the day."),
         p("3. How do the trading volumes of Bitcoin and Ethereum compare with each other over time? Volume 
      represents, among other things, potential and interest in the currency. For example, if we see that 
      both currencies have increasing volume over time, we may believe that cryptocurrency may be getting 
      more popular, and that we may see even more investment in the near future. Our datasets for Bitcoin 
      and Ethereum have 2 features that measure volume, 1 for USD and 1 in terms of their own currency 
      (BTC/ETH). The USD feature was used as it would make more sense to an audience that likely has more 
      knowledge of USD than knowledge of cryptocurrency")), 
      width=10, style="text-align:justify;background-color:papayawhip;border-radius:10px"
    )),
  hr(),
  
  tags$style(".fa-database {color:#E87722}"),
  h3(p(em("Bitcoin Dataset "),icon("database",lib = "font-awesome"),style="color:black;text-align:center")),
  fluidRow(column(DT::dataTableOutput("RawDataBitcoin"), width = 12)),
  hr(),
  tags$style(".fa-database {color:#E87722}"),
  h3(p(em("Ethereum Dataset "),icon("database",lib = "font-awesome"),style="color:black;text-align:center")),
  fluidRow(column(DT::dataTableOutput("RawDataEthereum"), width = 12))
)

Question1 <- tabPanel(
  "High vs Low Price",
  fluidRow(
    column(width=2),
    column(
      h1(p("Comparing the high and low price for each day",style="color:black;text-align:center")),
      width=8,style="background-color:lavender;border-radius: 10px"
    )
  ),
  br(),
  h3("High and low values per day for the 2 currencies were measured in terms of USD (Bitcoin and Ether were 
    converted to USD).", style="text-align:center;background-color:papayawhip;padding:10px;border-radius:10px"),
  hr(),
  h4("In the following scatterplot, you can see the trend of the highest and lowest price of the chosen crypto 
         coin you have choosen to view. By analysing the trend on the graph, one can clearly say that over a given time
         period, there has been great fluctuations in these values.", style="color:green"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("year1", p("Select year"), value = 2017, min = 2017, max = 2020, step = 1),
      br(),
      radioButtons(
        "coinType1",
        p("Select the cryptocurrency you would like to view:"),
        choices = c("Bitcoin" = 1, "Ethereum" = 2)
      )
    ),
    mainPanel(
      plotOutput("highLowAnalysis")
    )
  ),
  hr(),
  sidebarLayout(
    sidebarPanel(
      h4("Mean fluctuation in the difference of high price and low price for selected year:",
         style="aligh:center"),
      textOutput("meanHighLow")
    ),
    mainPanel(
      h5("We found the mean fluctuation of prices per day. 
         This seems to suggest that daily fluctuation is significantly large, and a frequently-changing currency. This 
         could be indicative of many things, likely higher trading volume, risk or instability. As we further observed 
         in question 3, trading volume trend increases in general. We can therefore likely attribute the fluctuation 
         to the increase in volume."
      )
    )
  )
)

Question2 <- tabPanel(
  "Bitcoin vs Ethereum price", 
  headerPanel("Comparing Bitcoin versus Ethereum prices over time"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("year2", p("Select year"), value = 2017, min = 2017, max = 2020, step = 1),
      br(),
      checkboxGroupInput(inputId = "coinType2",
                         p("Select the cryptocurrency you would like to include:"),
                         choices = c("Bitcoin", "Ethereum")
      ),
    ),
    mainPanel(
      p("How do the price values of Bitcoin and Ethereum compare with each other
        over time? Bitcoin and Ethereum are the 2 biggest currencies, and we look 
        to examine if their price trends are related in some way. As Bitcoin and Ethereum
        comprise a large amount of the cryptocurrency market share, this could suggest
        trends for cryptocurrency itself, since price is influenced by things such as 
        supply and demand. For this visualization, we will use the value of each 
        currency at market close."),
      plotOutput("priceAnalysis"),
      p("We chose to visualize the relationship between Bitcoin and Ethereum price values
        with a point scatterplot. The x-axis represents dates, and the y-axis represents
        the price values in USD. The colors of the points represent the currency the observation
        belongs to. The years that you would like to view can be changed by checking boxes of 
        any combination of years from 2017 to 2020."), 
      p("Overall, many points fluctuate from the mean value. This may suggest that cryptocurrency
        is rapidly changing, as it is not completely solidified as a universal form of currency
        and is frequently subject to change."),
    )
  )
)

Question3 <- tabPanel(
  "Bitcoin vs Ethereum Volume",
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
      sliderInput(inputId = "year3", p("Select year"),value = 2017, min = 2017, max = 2020, step = 1),
      br(),
      checkboxGroupInput("coinType3",
                         p("Select the cryptocurrency you would like to include:"),
                         choices = c("Bitcoin", "Ethereum")),
    ),
    mainPanel(
      fluidRow(
        plotOutput("volumeAnalysis"),
      ),
      h3("Results and Implications"),
      p("Based on the statistics, it was clear that bitcoin was the favored competitor in terms of cryptocurrencies trading. 
      But what's suprising was that Ethereum's volume trading wasn't as small as we thought it would. 
      We were assuming that Bitcoin would be the monopoly in the cryptocurrency business because in a surface level, users tends to only know about Bitcoin. 
      Because of the volume, it definitely clarify our assumptions of Bitcoin being the only competitor. 
      Thus, the results demonstrates that Bitcoin is popular cryptocurrencies and it doesn't mean they're the only dominating the field. ")
    )
  )
)

Result <- tabPanel(
  "Result Page",
  h1("Results"),
  sidebarLayout(
    sidebarPanel(
      h4("The graph on the right is the difference in the high price and the low price over change in volume of Bitcoin.")
    ),
    mainPanel(
      plotOutput("results1")
    )
  ),
  sidebarLayout(
    sidebarPanel(
      h4("The graph on the right is the difference in the high price and the low price over change in volume of Ethereum.")
    ),
    mainPanel(
      plotOutput("results2")
    )
  ),
  hr(),
  h3("Results and Implications", style = "align:center"),
  br(),
  fluidRow(
    column(p("The mean price for bitcoin was "),
           p(textOutput("question2_stats1")),
           width = 3, style = "align:center"
    ),
    column(p("The mean price for ethereum was "),
           p(textOutput("question2_stats2")),
           width = 3
    ),
    column(p("The mean volume for bitcoin was "),
           p(textOutput("question3_stats1")),
           width = 3
    ),
    column(p("The mean volume for ethereum was "),
           p(textOutput("question3_stats2")),
           width = 3
    ),
    style = "text-align:left;color:black;background-color:lavender;padding:15px;border-radius:10px"  
  ),
  
  br(),
  p("Based on the results, we can conclude that both cryptocurrencies has a general increasing trend between volume and price.
      However, Ethereum's data points tend to be more spread out and scatter around the lower volumes, and greatly fluctuate from
      the calculated means.
      This could imply that our data could been have skewed. Furthemore, this could be telling that Ethereum is a having a lower demand at lower price
      since you can see all the data points hovering around the lower end of the volume. This also explains Bitcoin being the preferred cryptocurrency
      since the linear progression (red line) is growing at a higher exponential rate than Ethereum.")
)

my_ui <- shinyUI(
  fluidPage(
    theme = shinytheme("cerulean"),
    titlePanel("Analysing Different Factors that affect the Price of Cryptocurrencies"),
    h3("G7, Samyak Jain, Chris Ong, Minh tu Huynh"),
    navbarPage(
      "Trends in Cryptocurrencies!",
      Home,
      Question1,
      Question2,
      Question3, 
      Result
    )
  )
)