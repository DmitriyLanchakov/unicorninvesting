source('constant.R')
source('util/utils.R')

source('entity/user.R')
source('entity/portfolio.R')
source('entity/holding.R')

source('data/cache.R')
source('backtest/test.R')

log.DEBUG   <<- TRUE

username    <- 'achillesrasquinha'
password    <- '12345'
firstname   <- 'Achilles'
lastname    <- 'Rasquinha'
email       <- 'achillesrasquinha@gmail.com'
dob         <- '1995-08-14'
gender      <- gender.MALE

portname    <- 'My Portfolio'

if ( !is.true(user.exists(username)) ) {
  log.info('setup', paste('Registering User:', username))

  user      <- user.register(
    username  = username,
    firstname = firstname,
    lastname  = lastname,
    email     = email,
    password  = password,
    dob       = dob,
    gender    = gender.MALE
  )

  if ( !is.na(user) || !is.null(user) ) {
    log.success('setup', paste('Successfully registered User:', username))
  } else {
    log.danger('setup', paste('Error in registering User:', username))
  }
} else {
  user      <- user.get(username, password)
}

portfolio   <- portfolio.get(user, name = portname)
if ( is.na(portfolio) ) {
  log.info('setup', join(c('Portfolio"', portname, '" does not exist.')))

  portfolio <- portfolio.register(user, name = portname)
}

holding     <- holding.add(portfolio, type = holding.FOREX, params = list(
    from   = forex.EUR,
    to     = forex.USD,
    amount = 300
))

pairs       <- paste(holding$from, holding$to, sep = '')
cache.FOREX(pairs)

back.test(user, holding, function (data) {
  
})


