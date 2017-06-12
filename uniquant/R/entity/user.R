library(RMySQL)

source('data/db.R')
source('util/log.R')
source('entity/portfolio.R')

LOGGING_TAG   <- 'user.R'

user.get      <- function (username) {
  database    <- db.connect()
  table       <- paste(DB_PREFIX, 'users', sep = '')

  statement   <- paste("SELECT * FROM ", table, " WHERE username = '", username, "'", sep = '')

  log.debug(LOGGING_TAG, paste('Executing statement: ', statement, sep = ''))

  result      <- dbGetQuery(database, statement)

  db.disconnect(database)

  return(result)
}

user.register <- function (username, firstname, lastname, email, password, dob, gender) {
  values      <- list(
    username   = username,
    firstname  = firstname,
    lastname   = lastname,
    email      = email,
    password   = password,
    dob        = dob,
    gender     = gender
  )

  db.insert('users', values)

  user        <- user.get(username)

  return(user)
}

user.register_portfolio <- function (user, name) {
  log.debug(LOGGING_TAG, paste('Registering Portfolio for User: ', user$username))

  values      <- list(
    userID     = user$ID,
    name       = name
  )

  db.insert('portfolio', values)

  portfolio   <- portfolio.get(user, name)

  return(portfolio)
}
