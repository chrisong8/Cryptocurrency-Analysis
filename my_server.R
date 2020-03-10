library("shiny")
library("ggplot2")

bitcoin <-  read.csv("Binance_BTCUSDT_d.csv", stringsAsFactors = FALSE)
ethereum <- read.csv("Binance_ETHUSDT_d.csv", stringsAsFactors = FALSE)

server <- function(input, output) {
  output$volumeEthereum <- renderPlot({
    # return the plot
    ggplot(data = price_difference_ethereum) +
      geom_point(mapping = aes(x = Volume.USDT, y = difference, colour = "High"), color = "Blue", alpha = .5) +
      geom_smooth(mapping = aes(x = Volume.USDT, y = difference, colour = "High"), color = "Red", alpha = .5) +
      labs(
        title = "High and Low Price for Ethereum",
        x = "Volume" ,
        y = "Difference in USD"
      )
  })
  
  output$volumeBitcoin <- renderPlot({
    # return the plot
    ggplot(data = price_difference_bitcoin) +
      geom_point(mapping = aes(x = Volume.USDT, y = difference, colour = "High"), color = "Blue", alpha = .5) +
      geom_smooth(mapping = aes(x = Volume.USDT, y = difference, colour = "High"), color = "Red", alpha = .5) +
      labs(
        title = "High and Low Price for Bitcoin",
        x = "Volume" ,
        y = "Difference in USD")
  })
  
  
}

