library(RMySQL)

source('data/db.R')
source('util/log.R')

holding.type.STOCK <- 'STOCK'
holding.type.FOREX <- 'FOREX'

holding.get   <- function (portfolio, type, params = NULL) {
  database    <- db.connect()
  table       <- paste(DB_PRFX, 'holding', sep = '')

  statement   <- paste("SELECT * FROM ", table, " WHERE portfolioID = '", portfolio$ID,
    "'", " AND type = '", type, "'", sep = '')

  log.info('holding', paste('Executing statement:', statement))

  # if params is NULL, will always return a single row.
  holding     <- dbGetQuery(database, statement)

  if ( !is.null(params) ) {
    table     <- paste(DB_PRFX, 'holding_', sapply(type, tolower), sep = '')
    columns   <- names(params)

    fcolumns  <- join(paste("`", columns, "`", sep = ''), ', ')
    fvalues   <- join(paste("'",  params, "'", sep = ''), ', ')

    statement <- paste("SELECT * FROM ", table, " WHERE holdingID = '", holding$ID,
      "'", " AND (", fcolumns, ") IN ((", fvalues, "))", sep = '')

    log.info('holding', paste('Executing statement:', statement))

    tresult    <- dbGetQuery(database, statement)
    tresult$ID <- NULL

    colnames(tresult)[1] <- "ID"

    holding    <- merge(holding, tresult, key = "ID")
  }

  db.disconnect(database)

  return(holding)
}
