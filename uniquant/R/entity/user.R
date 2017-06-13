library(RMySQL)

source('constant.R')
source('util/utils.R')

source('data/db.R')
source('entity/portfolio.R')

user.get      <- function (username) {
  database    <- db.connect()
  table       <- paste(DB_PRFX, 'users', sep = '')

  statement   <- paste("SELECT * FROM ", table, " WHERE username = '", username, "'", sep = '')

  log.info('user', paste('Executing statement:', statement))

  result      <- dbGetQuery(database, statement)

  db.disconnect(database)

  return(result)
}

user.register <- function (username, firstname, lastname, email, password, dob, gender) {
  gender      <- assign.if.na(gender, gender.NA)
  values      <- list(
    username   = username,
    firstname  = firstname,
    lastname   = lastname,
    email      = email,
    password   = password,
    dob        = dob,
    gender     = gender
  )

  log.info('user', paste('Registering User with values:', join(values, ', ')))

  if ( is.true(db.insert('users', values)) ) {
    user      <- user.get(username)
  } else {
    user      <- NULL
  }

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
