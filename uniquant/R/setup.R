source('constant.R')
source('util/utils.R')

source('entity/user.R')
source('entity/portfolio.R')
source('entity/holding.R')

mirror      <-  Sys.getenv('UNIQUANT_PACKAGE_MIRROR', DEFAULT_MIRROR)
log.DEBUG   <<- TRUE

log.info('setup', paste('Installing necessary dependencies:', join(REQUIRED_PACKAGES, ', ')))
install.package(REQUIRED_PACKAGES, mirror = mirror)

username    <- 'achillesrasquinha'
log.info('setup', paste('Registering a User:', username))
user        <- user.register(
  username  = username,
  firstname = 'Achilles',
  lastname  = 'Rasquinha',
  email     = 'achillesrasquinha@gmail.com',
  password  = '12345',
  dob       = '1995-08-14',
  gender    = gender.MALE
)

if ( !is.null(user) ) {
  log.success('setup', paste('Successfully registered User:', username))

  portname  <- 'My Portfolio'
  user.register_portfolio(user, name = portname)
  user.register_portfolio(user, name = 'My Other Portfolio')

  portfolio <- portfolio.get(user, name = portname)

  if ( !is.null(portfolio) ) {
    log.success('setup', paste('Successfully created portfolio', portname, 'for user', username))

    holding <- portfolio.add_holding(portfolio, type = holding.type.FOREX, params = list(
        from   = forex.USD,
        to     = forex.CAD,
        amount = 300
    ))
  } else {
    log.danger('setup', paste('Error in creating portfolio', portname, 'for user', username))
  }
} else {
  log.danger('setup', paste('Error in registering User:', username))
}
