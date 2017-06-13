library(RMySQL)

source('data/db.R')
source('util/log.R')

portfolio.get <- function (user, name = NULL) {
  database    <- db.connect()
  table       <- paste(db.PREFIX, 'portfolio', sep = '')

  statement   <- paste("SELECT * FROM ", table, " WHERE userID = '", user$ID, "'", sep = '')

  if ( !is.null(name) ) {
    fname     <- join(paste("'", name, "'", sep = ''), ", ")
    statement <- paste(statement, " AND name IN (", fname, ")", sep = '')
  }

  log.info('portfolio', paste('Executing statement:', statement))

  result      <- dbGetQuery(database, statement)

  db.disconnect(database)

  return(result)
}

portfolio.add_holding <- function (portfolio, type, params) {
  values      <- list(
    portfolioID = portfolio$ID,
    type        = type
  )

  log.info('portfolio', paste('Adding a holding of type:', type))

  db.insert('holding', values)

  holding     <- holding.get(portfolio, type)

  table       <- paste('holding_', sapply(holding$type, tolower), sep = '')
  values      <- append(list(holdingID = holding$ID), params)

  db.insert(table, values)

  holding     <- holding.get(portfolio, type, params)

  return(holding)
}
