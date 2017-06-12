library(RMySQL)

source('data/db.R')
source('util/log.R')

portfolio.get              <- function (user, name = NULL) {
  database    <- db.connect()
  table       <- paste(DB_PREFIX, 'portfolio', sep = '')

  statement   <- paste("SELECT * FROM ", table, " WHERE userID = '", user$ID, "'", sep = '')

  log.debug(LOGGING_TAG, paste('Executing statement: ', statement, sep = ''))

  result      <- dbGetQuery(database, statement)

  db.disconnect(database)

  return(result)
}

portfolio.register_holding <- function (portfolio, type) {
  
}
