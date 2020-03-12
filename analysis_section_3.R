library(wbstats)
library(dplyr)
library(ggplot2)
library(tidyr)
library(maps)
library(mapproj)
library(knitr)


#####################
#### QUESTION 1 #####
#####################


bitcoin <-  read.csv("www/Binance_BTCUSDT_d.csv", stringsAsFactors = FALSE)
ethereum <- read.csv("www/Binance_ETHUSDT_d.csv", stringsAsFactors = FALSE)

high_low_price_bitcoin <- select(bitcoin, Date, High, Low)
high_low_price_bitcoin <- filter(high_low_price_bitcoin, High != 0, Low != 0)
high_low_price_ethereum <- select(ethereum, Date, High, Low)
high_low_price_ethereum <- filter(high_low_price_ethereum, High != 0, Low != 0)

meanCal <- function(year, coinType) {
  if(coinType == 1) {
    high_low_price_bitcoin <- filter(high_low_price_bitcoin, startsWith(Date, year))
    high_low_price_bitcoin <- mutate(high_low_price_bitcoin, difference = High - Low)
    return(as.character(mean(high_low_price_bitcoin$difference)))
  } else {
    high_low_price_ethereum <- filter(high_low_price_ethereum, startsWith(Date, year))
    high_low_price_ethereum <- mutate(high_low_price_ethereum, difference = High - Low)
    return(as.character(mean(high_low_price_ethereum$difference)))
  }
}

high_low <- function(year, coin_type) {
  if(coin_type == 1) {
    high_low_price_bitcoin <- filter(high_low_price_bitcoin, startsWith(Date, year))
    bitcoin_comparison <- ggplot(data = high_low_price_bitcoin) +
      geom_point(mapping = aes(x = Date, y = High, colour = "High"), color = "Blue", alpha = .5) +
      geom_point(mapping = aes(x = Date, y = Low, colour = "Low"), color = "Red", alpha = .5) +
      labs(
        title = "High and Low Price for Bitcoin",
        x = "Date",
        y = "Value in USD"
      ) +
      theme(axis.text.x=element_blank())
    return(bitcoin_comparison)
  } else {
    high_low_price_ethereum <- filter(high_low_price_ethereum, startsWith(Date, year))
    ethereum_comparison <- ggplot(data = high_low_price_ethereum) +
      geom_point(mapping = aes(x = Date, y = High, colour = "High"), color = "Blue", alpha = .5) +
      geom_point(mapping = aes(x = Date, y = Low, colour = "Low"), color = "Red", alpha = .5) +
      labs(
        title = "High and Low Price for Ethereum",
        x = "Date",
        y = "Value in USD"
      ) +
      theme(axis.text.x=element_blank())
    return(ethereum_comparison)
  }
}

#####################
#### QUESTION 2 #####
#####################
price_bitcoin <- select(bitcoin, Date, Close)
names(price_bitcoin)[names(price_bitcoin) == "Close"] <- "Bitcoin_Price"
price_ethereum <- select(ethereum,Date, Close)
price_ethereum <- filter(price_ethereum, Close != 0)
names(price_ethereum)[names(price_ethereum) == "Close"] <- "Ethereum_Price"

combined_price_data <- left_join(price_bitcoin, price_ethereum, by = "Date")
combined_price_data <- filter(combined_price_data, Bitcoin_Price != 0, Ethereum_Price != 0)

price <- function(year, coin_value) {
  combined_price_data <- filter(combined_price_data, startsWith(Date, year))
  if(coin_value == "Bitcoin") {
    price_analysis <- ggplot(data = combined_price_data) +
      geom_point(mapping = aes(x = Date, y = Bitcoin_Price, colour = "Bitcoin Price"), alpha = .4) +
      labs(
        title = "Price Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Price"
      ) +
      theme(axis.text.x=element_blank())
    return(price_analysis)
  } else if(coin_value == "Ethereum") {
    price_analysis <- ggplot(data = combined_price_data) +
      geom_point(mapping = aes(x = Date, y = Ethereum_Price, colour = "Ethereum Price"), alpha = .4) +
      labs(
        title = "Price Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Price"
      ) +
      theme(axis.text.x=element_blank())
    return(price_analysis)
  } else if(coin_value == "Bitcoin, Ethereum") {
    price_analysis <- ggplot(data = combined_price_data) +
      geom_point(mapping = aes(x = Date, y = Bitcoin_Price, colour = "Bitcoin Price"), alpha = .4) +
      geom_point(mapping = aes(x = Date, y = Ethereum_Price, colour = "Ethereum Price"), alpha = .4) +
      labs(
        title = "Price Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Price"
      ) +
      theme(axis.text.x=element_blank())
    return(price_analysis)
  } else {
    price_analysis <- ggplot(data = combined_price_data) +
      labs(
        title = "Price Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Price"
      ) +
      theme(axis.text.x=element_blank())
    return(price_analysis)
  }
}


bitcoin_price_mean <- as.character(mean(price_bitcoin$Bitcoin_Price))

ethereum_price_mean <- as.character(mean(price_ethereum$Ethereum_Price))

#####################
#### QUESTION 3 #####
#####################

volume_bitcoin <- select(bitcoin,Date, Volume.USDT)
volume_bitcoin <- filter(volume_bitcoin, Volume.USDT != 0)
names(volume_bitcoin)[names(volume_bitcoin) == "Volume.USDT"] <- "Bitcoin_Volume"

volume_ethereum <- select(ethereum,Date, Volume.USDT)
volume_ethereum <- filter(volume_ethereum, Volume.USDT != 0)
names(volume_ethereum)[names(volume_ethereum) == "Volume.USDT"] <- "Ethereum_Volume"

combined_volume_data <- left_join(volume_bitcoin, volume_ethereum, by = "Date")
combined_volume_data <- filter(combined_volume_data, Bitcoin_Volume != 0, Ethereum_Volume != 0)

volume <- function(year, coin_value) {
  combined_volume_data <- filter(combined_volume_data, startsWith(Date, year))
  if(coin_value == "Bitcoin") {
    volume_analysis <- ggplot(data = combined_volume_data) +
      geom_point(mapping = aes(x = Date, y = Bitcoin_Volume, colour = "Bitcoin Volume"), alpha = .4) +
      labs(
        title = "Volume Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Volume"
      ) +
      theme(axis.text.x=element_blank())
    return(volume_analysis)
  } else if(coin_value == "Ethereum") {
    volume_analysis <- ggplot(data = combined_volume_data) +
      geom_point(mapping = aes(x = Date, y = Ethereum_Volume, colour = "Ethereum Volume"), alpha = .4) +
      labs(
        title = "Volume Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Volume"
      ) +
      theme(axis.text.x=element_blank())
    return(volume_analysis)
  } else if(coin_value == "Bitcoin, Ethereum") {
    volume_analysis <- ggplot(data = combined_volume_data) +
      geom_point(mapping = aes(x = Date, y = Bitcoin_Volume, colour = "Bitcoin Volume"), alpha = .4) +
      geom_point(mapping = aes(x = Date, y = Ethereum_Volume, colour = "Ethereum Volume"), alpha = .4) +
      labs(
        title = "Volume Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Volume"
      ) +
      theme(axis.text.x=element_blank())
    return(volume_analysis)
  } else {
    volume_analysis <- ggplot(data = combined_volume_data) +
      labs(
        title = "Volume Analysis for Bitcoin and Ethereum",
        x = "Dates" ,
        y = "Volume"
      ) +
      theme(axis.text.x=element_blank())
    return(volume_analysis)
  }
}

bitcoin_volume_mean <- as.character(mean(volume_bitcoin$Bitcoin_Volume))

ethereum_volume_mean <- as.character(mean(volume_ethereum$Ethereum_Volume))

########################
###### RESULT ##########
########################
price_difference_bitcoin <- select(bitcoin, High, Low, Volume.USDT) 
price_difference_bitcoin <- mutate(price_difference_bitcoin, 
                                   difference = High - Low)


price_difference_ethereum <- select(ethereum, High, Low, Volume.USDT) 
price_difference_ethereum <- mutate(price_difference_ethereum, 
                                    difference = High - Low)

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