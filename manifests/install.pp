# mysql::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::install
class mysql::install inherits mysql {
  # install mysql version
  if $mysql::package_name == 'mariadb' {
    include ::mysql::mariadb
  } else {
    include ::mysql::community
  }
}
