library(RMySQL)

source('util/log.R')

DB_NAME       <- 'uniquant'
DB_HOST       <- '127.0.0.1'
DB_PORT       <- 0
DB_USER       <- 'root'
DB_PASS       <- 'toor'
DB_PREFIX     <<- paste(DB_NAME, '_', sep = '')

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

db.insert     <- function (table, list) {
  database    <- db.connect()
  table       <- paste(DB_PREFIX, table, sep = '')

  fcolumns    <- paste(names(list), collapse = ', ')
  fvalues     <- paste(paste("'", list, "'", sep = ''), collapse = ', ')

  statement   <- paste('INSERT INTO ', table, ' (', fcolumns, ') VALUES (', fvalues, ')', sep = '')

  log.debug(LOGGING_TAG, paste('Executing statement: ', statement, sep = ''))

  result      <- tryCatch(
                    {
                      result  <- dbSendQuery(database, statement)
                    },
                    error = function (error) {
                      log.danger(LOGGING_TAG, paste('Unable to execute query: ', statement, ' with error message: ', error, sep = ''))

                      return(FALSE)
                    }
                  )


  db.clear(result)
  db.disconnect(database)

  return(TRUE)
}
