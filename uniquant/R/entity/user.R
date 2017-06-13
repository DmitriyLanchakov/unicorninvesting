library(RMySQL)
library(bcrypt)

source('constant.R')
source('util/utils.R')

source('data/db.R')
source('entity/portfolio.R')

user.exists   <- function (username) {
  database    <- db.connect()
  table       <- paste(DB_PRFX, 'users', sep = '')

  statement   <- paste("SELECT * FROM ", table, " WHERE username = '", username, "'", sep = '')

  log.info('user', paste('Executing statement:', statement))

  result      <- dbGetQuery(database, statement)

  db.disconnect(database)

  exists      <- nrow(result) != 0

  return(exists)
}

user.get      <- function (username, password) {
  database    <- db.connect()
  table       <- paste(DB_PRFX, 'users', sep = '')

  statement   <- paste("SELECT * FROM ", table, " WHERE username = '", username, "'", sep = '')

  log.info('user', paste('Executing statement:', statement))

  result      <- dbGetQuery(database, statement)

  db.disconnect(database)

  hashpass    <- result$password
  validated   <- checkpw(password, hashpass)

  if ( is.true(validated) ) {
    log.success('user', paste('Validation successful of User:', username))

    return(result)
  } else {
    log.danger('user', paste('Validation unsucessful of User:', username))

    return(NULL)
  }
}

user.register <- function (username, firstname, lastname, email, password, dob, gender) {
  gender      <- assign.if.na(gender, gender.NA)
  hashpass    <- hashpw(password, gensalt(DB_PASS_SALT))
  values      <- list(
    username   = username,
    firstname  = firstname,
    lastname   = lastname,
    email      = email,
    password   = hashpass,
    dob        = dob,
    gender     = gender
  )

  log.info('user', paste('Registering User with values:', join(values, ', ')))

  if ( is.true(db.insert('users', values)) ) {
    user      <- user.get(username, password)
  } else {
    user      <- NULL
  }

  return(user)
}

user.register_portfolio <- function (user, name) {
  log.info('user', paste('Registering Portfolio for User: ', user$username))

  values      <- list(
    userID     = user$ID,
    name       = name
  )

  if ( is.true(db.insert('portfolio', values)) ) {
    portfolio <- portfolio.get(user, name)
  } else {
    portfolio <- NULL
  }

  return(portfolio)
}
