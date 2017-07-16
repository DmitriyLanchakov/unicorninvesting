library(DBI)
library(stringr)

source('data/db.R')
source('util/utils.R')

history.get <- function (symbol, from = '', to = Sys.time()) {
	database    <- db.connect()
  	table       <- str_c(db.PREFIX, 'history')

  	fsymbol     <- join(str_c("'", symbol, "'"), ", ")
  	statement   <- str_c("SELECT * FROM ", table, " WHERE symbol IN (", fsymbol, ")")

  	log.info('history', paste('Executing statement:', statement))

  	data        <- dbGetQuery(database, statement)

  	db.disconnect(database)

  	return(data)
}