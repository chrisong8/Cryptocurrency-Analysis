library("shiny")
library("ggplot2")
library("dplyr")
library("DT")

source("analysis_section_3.R")

server <- function(input, output) {
  output$highLowAnalysis <- renderPlot({
    high_low(as.character(input$year1), input$coinType1)
  })
  
  output$priceAnalysis <- renderPlot({
    coinTypeTemp1 <- paste(input$coinType2, collapse = ", ")
    price(as.character(input$year2), coinTypeTemp1)
  })
  
  output$volumeAnalysis <- renderPlot({
    coinTypeTemp2 <- paste(input$coinType3, collapse = ", ")
    volume(as.character(input$year3), coinTypeTemp2)
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
  
<<<<<<< HEAD
### Results ###
  
  price_difference_bitcoin <- select(bitcoin, High, Low, Volume.USDT) 
  price_difference_bitcoin <- mutate(price_difference_bitcoin, 
                                     difference = High - Low)
  
  price_difference_ethereum <- select(ethereum, High, Low, Volume.USDT) 
  price_difference_ethereum <- mutate(price_difference_ethereum, 
                                      difference = High - Low)
  
  
  output$results <- renderPlot({
    bitcoin_result <- ggplot(data = price_difference_bitcoin) +
      geom_point(mapping = aes(x = Volume.USDT, y = difference, colour = "High"), color = "Blue", alpha = .5) +
      geom_smooth(mapping = aes(x = Volume.USDT, y = difference, colour = "High"), color = "Red", alpha = .5) +
      labs(
        title = "High and Low Price for Bitcoin",
        x = "Volume" ,
        y = "Difference in USD"
      )
    
    ethereum_result <- ggplot(data = price_difference_ethereum) +
      geom_point(mapping = aes(x = Volume.USDT, y = difference, colour = "High"), color = "Blue", alpha = .5) +
      geom_smooth(mapping = aes(x = Volume.USDT, y = difference, colour = "High"), color = "Red", alpha = .5) +
      labs(
        title = "High and Low Price for Ethereum",
        x = "Volume" ,
        y = "Difference in USD"
      )
    
  })
}



=======
}
>>>>>>> 8c5862b4073251413d2d3d5bb4c2e5aa47d03ea7
