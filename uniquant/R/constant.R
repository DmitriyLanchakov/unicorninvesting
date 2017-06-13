REQUIRED_PACKAGES <<- readLines('assets/dependencies.txt')
DEFAULT_MIRROR    <<- 'http://cran.us.r-project.org'

# For codes, visit https://en.wikipedia.org/wiki/ISO/IEC_5218
gender.MALE       <<- 1
gender.FEMALE     <<- 2
gender.UNKNOWN    <<- 3
gender.NA         <<- 9 # Not Applicable

db.NAME           <<- 'uniquant'
db.HOSTNAME       <<- '127.0.0.1'
db.PORT           <<- 0
db.USERNAME       <<- 'root'
db.PASSWORD       <<- 'toor'
