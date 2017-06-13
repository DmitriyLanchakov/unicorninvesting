library(RMySQL)

source('constant.R')
source('util/log.R')

DB_NAME <- Sys.getenv('UNIQUANT_DB_NAME', db.NAME)
DB_HOST <- Sys.getenv('UNIQUANT_DB_HOST', db.HOSTNAME)
DB_PORT <- as.numeric(Sys.getenv('UNIQUANT_DB_PORT', db.PORT))
DB_USER <- Sys.getenv('UNIQUANT_DB_USER', db.USERNAME)
DB_PASS <- Sys.getenv('UNIQUANT_DB_PASS', db.PASSWORD)
DB_PRFX <- Sys.getenv('UNIQUANT_DB_PREFIX', paste(db.NAME, '_', sep = ''))

#' db.connect
#'
#' A database connection wrapper to RMySQL dbConnect
db.connect    <- function (name = DB_NAME, host = DB_HOST, port = DB_PORT,
  user = DB_USER, password = DB_PASS) {
  driver      <- MySQL()
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
  table       <- paste(DB_PRFX, table, sep = '')

  columns     <- names(values)

  fcolumns    <- paste(paste("`", columns, "`", sep = ''), collapse = ', ')
  fvalues     <- paste(paste("'",  values, "'", sep = ''), collapse = ', ')

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
