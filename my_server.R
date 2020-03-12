library("shiny")
library("ggplot2")
library("dplyr")
library("DT")

source("analysis_section_3.R")


server <- function(input, output) {
  output$qwert <- renderPlot({
    high_low(as.character(input$year1), input$coinType1)
  })
  
  output$priceAnalysis <- renderPlot({
    temp3 <- paste(input$coinType2, collapse = ", ")
    temp2(as.character(input$year2), temp3)
  })
  
  output$volumeAnalysis <- renderPlot(
    volume_analysis <- ggplot(data = combined_volume_data) +
      geom_point(mapping = aes(x = Date, y = Bitcoin_Volume, color = "Bitcoin Volume"), alpha = .4) +
      geom_point(mapping = aes(x = Date, y = Ethereum_Volume, color = "Ethereum Volume"), alpha = .4) +
      labs(
        title = "Volume Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Volume"
      )
  )
  
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