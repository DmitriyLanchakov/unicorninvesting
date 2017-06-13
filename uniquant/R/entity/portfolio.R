library(RMySQL)

source('data/db.R')
source('util/log.R')

portfolio.get <- function (user, name = NULL) {
  database    <- db.connect()
  table       <- paste(DB_PREFIX, 'portfolio', sep = '')

  statement   <- paste("SELECT * FROM ", table, " WHERE userID = '", user$ID, "'", sep = '')

  log.debug(LOGGING_TAG, paste('Executing statement: ', statement, sep = ''))

  result      <- dbGetQuery(database, statement)

  db.disconnect(database)

  return(result)
}

portfolio.register_holding <- function (portfolio, type, params) {
  values      <- list(
    portfolioID = portfolio$ID,
    type        = type
  )

  db.insert('holding', values)

  holding     <- holding.get(portfolio, type)

  values      <- append(list(holdingID = holding$ID), params)

  table       <- paste('holding_', sapply(holding$type, tolower), sep = '')

  db.insert(table, values)

  return(holding)
}
