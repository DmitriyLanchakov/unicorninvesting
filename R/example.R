library(stringr)

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

if ( !user.exists(username) ) {
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

  if ( !is.null(user) ) {
    log.success('setup', paste('Successfully registered User:', username))
  } else {
    log.danger('setup', paste('Error in registering User:', username))
  }
} else {
  user      <- user.get(username, password)
}

portfolio   <- portfolio.get(user, name = portname)
if ( is.null(portfolio) ) {
  log.info('setup', paste('Portfolio "', portname, '" does not exist.', sep = ''))

  portfolio <- portfolio.register(user, name = portname)
}

holding.add(portfolio, type = holding.FOREX, params = list(
    from   = forex.EUR,
    to     = forex.USD,
    amount = 300
))
holding.add(portfolio, type = holding.FOREX, params = list(
    from   = forex.GBP,
    to     = forex.CAD,
    amount = 500
))

holding     <- holding.get(portfolio, type = holding.FOREX)
# pairs       <- str_c(holding$from, holding$to)

# cache.FOREX(pairs)

back.test(holding, holding.FOREX, function (data) {
  
})


