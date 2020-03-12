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
  
}