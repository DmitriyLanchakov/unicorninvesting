library(DBI)

source('constant.R')
source('util/utils.R')

#' db.connect
#'
#' A database connection wrapper to RMySQL dbConnect
db.connect    <- function (name = db.NAME, host = db.HOSTNAME, port = db.PORT,
  user = db.USERNAME, password = db.PASSWORD) {
  driver      <- RMySQL::MySQL()
  connection  <- dbConnect(driver, dbname = name, user = user,
    password = password, host = host, port = port)

  return(connection)
}

db.disconnect <- function (connection) {
  dbDisconnect(connection)
}

db.clear      <- function (result) {
  dbClearResult(result)
}

db.insert     <- function (table, values) {
  database    <- db.connect()
  table       <- join(c(db.PREFIX, table))

  columns     <- names(values)

  fcolumns    <- join(join(c("`", columns, "`")), ', ')
  fvalues     <- join(join(c("'",  values, "'")), ', ')

  statement   <- paste('INSERT INTO', table, '(', fcolumns, ') VALUES (', fvalues, ')')

  log.info('db', paste('Executing statement:', statement))

  tryCatch(
      {
        result <- dbSendQuery(database, statement)

        log.success('db', 'Statement executed successfully')

        db.clear(result)
        db.disconnect(database)

        return(TRUE)
      },
      error    = function (error) {
        error  <- paste('Unable to execute query:', statement, 'with error message', error)
        log.danger('db', error)
      },
      finally  = function ( ) {
        db.disconnect(database)
      }
    )

  return(FALSE)
}
