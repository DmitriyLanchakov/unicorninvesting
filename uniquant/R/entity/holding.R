library(RMySQL)

source('data/db.R')
source('util/log.R')

holding.type.STOCK <- 'STOCK'
holding.type.FOREX <- 'FOREX'

holding.get <- function (portfolio, type) {
  database  <- db.connect()
  table     <- paste(DB_PREFIX, 'holding', sep = '')

  statement <- paste("SELECT * FROM ", table, " WHERE portfolioID = '", portfolio$ID, "'", sep = '')

  log.debug(LOGGING_TAG, paste('Executing statement: ', statement, sep = ''))

  result    <- dbGetQuery(database, statement)

  db.disconnect(database)

  return(result)
}
