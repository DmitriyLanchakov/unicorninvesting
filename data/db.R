library(RMySQL)

DB_NAME       <- 'uniquant'
DB_HOST       <- '127.0.0.1'
DB_PORT       <- 0
DB_USER       <- 'root'
DB_PASS       <- 'toor'

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

db.insert     <- function (table, values) {
  database    <- db.connect()

  columns     <- paste(names(values),  collapse = ', ')
  values      <- paste(paste("'", values, "'", sep = ''), collapse = ', ')

  statement   <- paste('INSERT INTO ', table, ' (', columns, ') VALUES (', values, ')', sep = '')

  result      <- dbSendQuery(database, statement)

  db.disconnect(database)
}
