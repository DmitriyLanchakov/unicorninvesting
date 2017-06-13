library(RMySQL)

source('data/db.R')
source('util/log.R')

holding.type.STOCK <- 'STOCK'
holding.type.FOREX <- 'FOREX'

holding.get <- function (portfolio, type, params = NULL) {
  database  <- db.connect()
  table     <- paste(DB_PRFX, 'holding', sep = '')

  statement <- paste("SELECT * FROM ", table, " WHERE portfolioID = '", portfolio$ID, "'", sep = '')

  log.info('holding', paste('Executing statement:', statement))

  result    <- dbGetQuery(database, statement)

  db.disconnect(database)

  return(result)
}
