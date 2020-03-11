library("shiny")
library("ggplot2")

bitcoin <-  read.csv("Binance_BTCUSDT_d.csv", stringsAsFactors = FALSE)
ethereum <- read.csv("Binance_ETHUSDT_d.csv", stringsAsFactors = FALSE)

volume_bitcoin <- select(bitcoin,Date, Volume.USDT)
names(volume_bitcoin)[names(volume_bitcoin) == "Volume.USDT"] <- "Bitcoin_Volume"

volume_ethereum <- select(ethereum,Date, Volume.USDT)
names(volume_ethereum)[names(volume_ethereum) == "Volume.USDT"] <- "Ethereum_Volume"

combined_volume_data <- left_join(volume_bitcoin, volume_ethereum, by = "Date")
combined_volume_data <- filter(combined_volume_data, Bitcoin_Volume != 0, Ethereum_Volume != 0)

server <- function(input, output) {
  
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
  
  
}


