library(stringr)

source('util/utils.R')

source('entity/history.R')

strategy.BUY    <- 'BUY'
strategy.SELL   <- 'SELL'

back.test       <- function (user, holding, strategy, from = '', to = Sys.time(), tick = 1) {
    if ( is.equal(holding$type, holding.FOREX) ) {
        symbol  <- paste(holding$from, holding$to, sep = '')
    } else if ( is.equal(holding$type, holding.STOCK) ) {
        symbol  <- holding$symbol
    }

    symbol      <- unique(symbol)
    # data - assuming a single symbol
    data        <- history.get(symbol = symbol, from = from, to = to)
    
    length      <- nrow(data)

    for (slice in 1:length) {
        frame      <- data[ 1:slice , ]
        evaluation <- strategy(frame)

        if ( is.equal(evaluation, strategy.BUY) ) {
            trade.buy(user, holding)
        } else if ( is.equal(evaluation, strategy.SELL) ) {
            trade.sell(user, holding)
        }

        Sys.sleep(tick)
    }
}