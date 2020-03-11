library("shiny")
library("ggplot2")

bitcoin <-  read.csv("www/Binance_BTCUSDT_d.csv", stringsAsFactors = FALSE)
ethereum <- read.csv("www/Binance_ETHUSDT_d.csv", stringsAsFactors = FALSE)

price_bitcoin <- select(bitcoin, Date, Close)
names(price_bitcoin)[names(price_bitcoin) == "Close"] <- "Bitcoin_Price"

price_ethereum <- select(ethereum, Date, Close)
names(price_ethereum)[names(price_ethereum) == "Close"] <- "Ethereum_Price"

combined_price_data <- left_join(price_bitcoin, price_ethereum, by = "Date")
combined_price_data <- filter(combined_price_data, Bitcoin_Price != 0, Ethereum_Price != 0)

volume_bitcoin <- select(bitcoin,Date, Volume.USDT)
names(volume_bitcoin)[names(volume_bitcoin) == "Volume.USDT"] <- "Bitcoin_Volume"

volume_ethereum <- select(ethereum,Date, Volume.USDT)
names(volume_ethereum)[names(volume_ethereum) == "Volume.USDT"] <- "Ethereum_Volume"

combined_volume_data <- left_join(volume_bitcoin, volume_ethereum, by = "Date")
combined_volume_data <- filter(combined_volume_data, Bitcoin_Volume != 0, Ethereum_Volume != 0)

server <- function(input, output) {
  output$priceAnalysis <- renderPlot({
    price_analysis <- ggplot(data = combined_price_data) +
      geom_point(mapping = aes(x = Date, y = Bitcoin_Price, color = "Bitcoin Price"), alpha = .4) +
      geom_point(mapping = aes(x = Date, y = Ethereum_Price, color = "Ethereum Price"), alpha = .4) +
      labs(
        title = "Price Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Price"
      )
    scale_x_continuous(limits = input$price)
  })
  
  output$volumeAnalysis <- renderPlot({
    volume_analysis <- ggplot(data = combined_volume_data) +
      geom_point(mapping = aes(x = Date, y = Bitcoin_Volume, color = "Bitcoin Volume"), alpha = .4) +
      geom_point(mapping = aes(x = Date, y = Ethereum_Volume, color = "Ethereum Volume"), alpha = .4) +
      labs(
        title = "Volume Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Volume"
      )
    scale_x_continuous(limits = input$volume)
  })
  
  output$RawDataBitcoin <- DT::renderDataTable(
    DT::datatable({
      bitcoin
    },
    options = list(lengthMenu=list(c(5,15,20),c('5','15','20')),pageLength=10,
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': 'moccasin', 'color': '1c1b1b'});",
                     "}"),
                   columnDefs=list(list(className='dt-center',targets="_all"))
    ),
    filter = "top",
    selection = 'multiple',
    style = 'bootstrap',
    class = 'cell-border stripe',
    rownames = FALSE,
    colnames = c("Date","Symbol","Open","High","Low","Close","Volume BTC","Volume USDT")
    ))
  
  output$RawDataEthereum <- DT::renderDataTable(
    DT::datatable({
      ethereum
    },
    options = list(lengthMenu=list(c(5,15,20),c('5','15','20')),pageLength=10,
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': 'moccasin', 'color': '1c1b1b'});",
                     "}"),
                   columnDefs=list(list(className='dt-center',targets="_all"))
    ),
    filter = "top",
    selection = 'multiple',
    style = 'bootstrap',
    class = 'cell-border stripe',
    rownames = FALSE,
    colnames = c("Date","Symbol","Open","High","Low","Close","Volume BTC","Volume USDT")
    ))
  
}




