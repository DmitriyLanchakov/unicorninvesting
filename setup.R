source('util/is.R')
source('entity/user.R')

REQUIRED_PACKAGES <- readLines('assets/dependencies.txt')
DEFAULT_MIRROR    <- 'http://cran.us.r-project.org'

for (i in 1:length(REQUIRED_PACKAGES)) {
  package <- REQUIRED_PACKAGES[i]

  if ( !is.installed(package) ) {
    install.packages(package, repos = DEFAULT_MIRROR)
  }
}

user.register(username = 'achillesrasquinha', firstname = 'Achilles', lastname = 'Rasquinha', email = 'achillesrasquinha@gmail.com', password  = '12345', dob = '1995-08-14', gender = 1)

user.create_portfolio()
