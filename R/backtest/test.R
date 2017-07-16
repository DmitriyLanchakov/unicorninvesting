library(stringr)

source('util/utils.R')

source('entity/history.R')

strategy.BUY    <- 'BUY'
strategy.SELL   <- 'SELL'

back.logger     <- function ( ) {

}

back.test       <- function (holding, type, strategy, from = '', to = Sys.time(), logger = back.logger) {
    if ( is.equal(type, holding.FOREX) ) {
        symbols <- str_c(holding$from, holding$to)
    } else if ( is.equal(type, holding.STOCK) ) {
        symbols <- holding$symbol
    }

    symbols     <- unique(symbols)
    data        <- history.get(symbol = symbols, from = from, to = to)
    
    length      <- nrow(data)

    for (slice in 1:length) {
        frame   <- data[ 1:slice , ]

        if ( is.equal(strategy(frame), strategy.BUY) ) {

        } else if ( is.equal(strategy(frame), strategy.SELL) ) {
            
        }
    }
}