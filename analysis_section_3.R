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

bitcoin_comparison <- ggplot(data = high_low_price_bitcoin) +
  geom_point(mapping = aes(x = Date, y = High, colour = "High"), color = "Blue", alpha = .5) +
  geom_point(mapping = aes(x = Date, y = Low, colour = "Low"), color = "Red", alpha = .5) +
  labs(
    title = "High and Low Price for Bitcoin",
    x = "Date" ,
    y = "Value in USD"
  )

ethereum_comparison <- ggplot(data = high_low_price_ethereum) +
  geom_point(mapping = aes(x = Date, y = High, colour = "High"), color = "Blue", alpha = .5) +
  geom_point(mapping = aes(x = Date, y = Low, colour = "Low"), color = "Red", alpha = .5) +
  labs(
    title = "High and Low Price for Ethereum",
    x = "Date" ,
    y = "Value in USD"
  )


#####################
#### QUESTION 2 #####
#####################
price_bitcoin <- select(bitcoin, Date, Close)
names(price_bitcoin)[names(price_bitcoin) == "Close"] <- "Bitcoin_Price"
price_ethereum <- select(ethereum,Date, Close)
names(price_ethereum)[names(price_ethereum) == "Close"] <- "Ethereum_Price"

combined_price_data <- left_join(price_bitcoin, price_ethereum, by = "Date")
combined_price_data <- filter(combined_price_data, Bitcoin_Price != 0, Ethereum_Price != 0)

price_analysis <- ggplot(data = combined_price_data) +
  geom_point(mapping = aes(x = Date, y = Bitcoin_Price, colour = "Bitcoin Price"), alpha = .4) +
  geom_point(mapping = aes(x = Date, y = Ethereum_Price, colour = "Ethereum Price"), alpha = .4) +
  labs(
    title = "Price Analysis for Bitcoin and Ethereum",
    x = "Dates" ,
    y = "Price"
  )


bitcoin_price_mean <- price_bitcoin %>% 
  summarize(
    median(Bitcoin_Price, na.rm = TRUE)
  )

ethereum_price_mean <- price_ethereum %>% 
  summarize(
    median(Ethereum_Price, na.rm = TRUE)
  )

#####################
#### QUESTION 3 #####
#####################

volume_bitcoin <- select(bitcoin,Date, Volume.USDT)
names(volume_bitcoin)[names(volume_bitcoin) == "Volume.USDT"] <- "Bitcoin_Volume"

volume_ethereum <- select(ethereum,Date, Volume.USDT)
names(volume_ethereum)[names(volume_ethereum) == "Volume.USDT"] <- "Ethereum_Volume"

combined_volume_data <- left_join(volume_bitcoin, volume_ethereum, by = "Date")
combined_volume_data <- filter(combined_volume_data, Bitcoin_Volume != 0, Ethereum_Volume != 0)
volume_analysis <- ggplot(data = combined_volume_data) +
  geom_point(mapping = aes(x = Date, y = Bitcoin_Volume, color = "Bitcoin Volume"), alpha = .4) +
  geom_point(mapping = aes(x = Date, y = Ethereum_Volume, color = "Ethereum Volume"), alpha = .4) +
  labs(
    title = "Volume Analysis for Bitcoin and Ethereum",
    x = "Dates" ,
    y = "Volume"
  )



bitcoin_median <- volume_bitcoin %>% 
  summarize(
    median(Bitcoin_Volume, na.rm = TRUE)
  )


ethereum_median <- volume_ethereum %>% 
  summarize(
    median(Ethereum_Volume, na.rm = TRUE)
  )


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

